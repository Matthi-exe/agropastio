import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:agropastio/l10n/app_localizations.dart';
import 'package:agropastio/services/health_protocols.dart';

// ==========================================
// 5. SOUS-MODULE : DIAGNOSTIC IA CULTURES
// ==========================================
class DiagnosticScreen extends StatefulWidget {
  const DiagnosticScreen({super.key});

  @override
  State<DiagnosticScreen> createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> {
  File? _imageFile;
  File? _imageFileVerso;
  final ImagePicker _picker = ImagePicker();
  bool _isAnalyzing = false;
  String _selectedCrop = 'Mil';

  late Interpreter _interpreter;
  List<String> _labels = [];
  bool _modeleCharge = false;

  @override
  void initState() {
    super.initState();
    _chargerModele();
  }

  Future<void> _chargerModele() async {
    _interpreter = await Interpreter.fromAsset(
      'assets/model/model_unquant.tflite',
    );
    final labelsData = await rootBundle.loadString('assets/model/labels.txt');
    _labels = labelsData.split('\n').where((l) => l.trim().isNotEmpty).toList();
    setState(() => _modeleCharge = true);
  }

  Float32List _preprocessImage(File imageFile) {
    final rawImage = img.decodeImage(imageFile.readAsBytesSync())!;
    final resized = img.copyResize(rawImage, width: 224, height: 224);

    var input = Float32List(224 * 224 * 3);
    int index = 0;
    for (int y = 0; y < 224; y++) {
      for (int x = 0; x < 224; x++) {
        final pixel = resized.getPixel(x, y);
        input[index++] = pixel.r / 255.0;
        input[index++] = pixel.g / 255.0;
        input[index++] = pixel.b / 255.0;
      }
    }
    return input;
  }

  Map<String, dynamic> _analyserImage(File imageFile) {
    var input = _preprocessImage(imageFile).reshape([1, 224, 224, 3]);
    var output = List.filled(
      1 * _labels.length,
      0.0,
    ).reshape([1, _labels.length]);

    _interpreter.run(input, output);

    List<double> scores = output[0];
    double maxScore = scores.reduce((a, b) => a > b ? a : b);
    int maxIndex = scores.indexOf(maxScore);

    return {'label': _labels[maxIndex], 'confidence': maxScore * 100};
  }

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source, {bool isVerso = false}) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isVerso) {
          _imageFileVerso = File(pickedFile.path);
        } else {
          _imageFile = File(pickedFile.path);
        }
      });
    }
  }

  void _runLocalAnalysis() {
    final loc = AppLocalizations.of(context);
    if (_imageFile == null || _imageFileVerso == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.get('selectPhotoBoth')),
        ),
      );
      return;
    }

    setState(() => _isAnalyzing = true);

    final resultatRecto = _analyserImage(_imageFile!);
    final resultatVerso = _analyserImage(_imageFileVerso!);

    final meilleurResultat =
        resultatRecto['confidence'] > resultatVerso['confidence']
        ? resultatRecto
        : resultatVerso;

    setState(() => _isAnalyzing = false);
    _showResult(
      context,
      meilleurResultat['label'],
      meilleurResultat['confidence'],
    );
  }

  void _showResult(
    BuildContext context,
    String detectedDisease,
    double confidenceScore,
  ) {
    final loc = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    List<String> actions = getProtocolActions(detectedDisease, languageCode);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.orange,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      loc.get('detectedDisease', params: {'disease': detectedDisease}),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                loc.get(
                  'certitudeIndex',
                  params: {'score': confidenceScore.toStringAsFixed(0)},
                ),
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Divider(height: 24),
              Text(
                loc.get('protocolTitle'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: actions.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      '${entry.key + 1}. ${entry.value}',
                      style: const TextStyle(fontSize: 13, height: 1.4),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.get('scanPhytosanitary'),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              loc.get('scanInstructions'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              initialValue: _selectedCrop,
              decoration: InputDecoration(
                labelText: loc.get('cropConcerned'),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              items: [
                'Mil',
                'Maïs',
                'Sorgho',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _selectedCrop = v!),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildPhotoBox(
                      _imageFile,
                      loc.get('rectoFace'),
                      false,
                      loc,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildPhotoBox(
                      _imageFileVerso,
                      loc.get('versoBack'),
                      true,
                      loc,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.bolt),
              label: Text(
                !_modeleCharge
                    ? loc.get('loadingModel')
                    : _isAnalyzing
                    ? loc.get('analyzing')
                    : loc.get('launchAnalysis'),
              ),
              onPressed: (_isAnalyzing || !_modeleCharge)
                  ? null
                  : _runLocalAnalysis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoBox(
    File? image,
    String label,
    bool isVerso,
    AppLocalizations loc,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFF2E7D32).withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              : Icon(
                  Icons.photo_camera_outlined,
                  size: 56,
                  color: const Color(0xFF2E7D32).withValues(alpha: 0.3),
                ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt, size: 18),
                label: Text(loc.get('photoButton')),
                onPressed: () =>
                    _pickImage(ImageSource.camera, isVerso: isVerso),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.photo_library, size: 18),
                label: Text(loc.get('galleryButton')),
                onPressed: () =>
                    _pickImage(ImageSource.gallery, isVerso: isVerso),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
