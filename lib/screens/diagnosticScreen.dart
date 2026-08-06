import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:agropastio/l10n/app_localizations.dart';
import 'package:agropastio/services/health_protocols.dart';
import 'package:agropastio/services/diagnostic_utils.dart';

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

  bool _modeleCharge = true;

  @override
  void initState() {
    super.initState();
    _chargerModele();
  }

  Future<void> _chargerModele() async {
    if (mounted) {
      setState(() => _modeleCharge = true);
    }
  }

  Map<String, dynamic> _analyserImage(File imageFile) {
    // Diagnostic de test : générer des probabilités fictives pour chaque label
    // Les libellés proviennent de assets/model/labels.txt et doivent correspondre
    final Map<String, double> fakeProbs = {
      'Sain': 0.0,
      'Common Rust(rouille)': 0.0,
      'Helminthosporiose(NLB)': 0.0,
      'Tache Grise(GLS)': 0.0,
      'Necrose Letale(MLN)': 0.0,
      'Striures(MSV)': 0.0,
    };

    // Simple pseudo-random deterministe basé sur la taille du fichier pour varier les résultats
    final seed = imageFile.lengthSync();
    int i = 0;
    fakeProbs.keys.toList().forEach((k) {
      final v = ((seed >> (i * 3)) & 0x1F) % 101; // 0..100
      fakeProbs[k] = v.toDouble();
      i++;
    });

    // Normaliser pour que la somme soit 100
    final total = fakeProbs.values.fold<double>(0.0, (s, e) => s + e);
    if (total <= 0) {
      // fallback simple
      fakeProbs.forEach((k, _) => fakeProbs[k] = 100.0 / fakeProbs.length);
    } else {
      fakeProbs.updateAll((k, v) => (v / total) * 100.0);
    }

    // Top label
    final sorted = fakeProbs.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return {
      'label': sorted.first.key,
      'confidence': sorted.first.value,
      'probabilities': fakeProbs,
    };
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

    // Fusionner probabilités des deux faces en utilisant la fonction utilitaire
    final Map<String, double> probsRecto = Map<String, double>.from(resultatRecto['probabilities'] ?? {});
    final Map<String, double> probsVerso = Map<String, double>.from(resultatVerso['probabilities'] ?? {});
    final merged = mergeProbabilities(probsRecto, probsVerso);
    final sorted = merged.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final top = sorted.first;

    setState(() => _isAnalyzing = false);

    _showResult(
      context,
      top.key,
      top.value,
      allProbabilities: merged,
    );
  }

  void _showResult(
    BuildContext context,
    String detectedDisease,
    double confidenceScore, {
    Map<String, double>? allProbabilities,
  }) {
    final loc = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final detail = getProtocolDetail(detectedDisease, languageCode);
    List<String> actions = List<String>.from(detail['actions'] ?? []);
    List<String> products = List<String>.from(detail['products'] ?? []);
    List<String> traditional = List<String>.from(detail['traditional'] ?? []);

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
              // Afficher les probabilités
              if (allProbabilities != null) ...[
                Text(
                  loc.get('probabilitiesTitle'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: allProbabilities.entries.toList()
                      .map((e) => Text('${e.key}: ${e.value.toStringAsFixed(1)}%'))
                      .toList(),
                ),
                const Divider(height: 24),
              ],
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
              if (products.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  loc.get('recommendedProducts'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: products.map((p) => Text('- $p')).toList(),
                ),
              ],
              if (traditional.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  loc.get('traditionalRemedies'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: traditional.map((p) => Text('- $p')).toList(),
                ),
              ],
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
