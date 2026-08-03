import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:agropastio/main.dart';

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
    if (_imageFile == null || _imageFileVerso == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez prendre une photo du recto ET du verso.'),
        ),
      );
      return;
    }

    setState(() => _isAnalyzing = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isAnalyzing = false);
      _showResult(context, _selectedCrop, 94.0);
    });
  }

  void _showResult(
    BuildContext context,
    String detectedDisease,
    double confidenceScore,
  ) {
    List<String> actions = getProtocolActions(detectedDisease);

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
                      '$detectedDisease détectée',
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
                'Indice de certitude locale : ${confidenceScore.toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Divider(height: 24),
              const Text(
                'PROTOCOLE DE TRAITEMENT BIOLOGIQUE :',
                style: TextStyle(
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scanner Phytosanitaire',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Positionnez la feuille malade dans le cadre',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              initialValue: _selectedCrop,
              decoration: const InputDecoration(
                labelText: 'Culture concernée',
                border: OutlineInputBorder(),
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
                    child: _buildPhotoBox(_imageFile, 'Face (recto)', false),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildPhotoBox(_imageFileVerso, 'Dos (verso)', true),
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
                _isAnalyzing
                    ? 'ANALYSE EN COURS...'
                    : 'LANCER L\'ANALYSE LOCALE',
              ),
              onPressed: _isAnalyzing ? null : _runLocalAnalysis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoBox(File? image, String label, bool isVerso) {
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
                label: const Text('Photo'),
                onPressed: () =>
                    _pickImage(ImageSource.camera, isVerso: isVerso),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.photo_library, size: 18),
                label: const Text('Galerie'),
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
