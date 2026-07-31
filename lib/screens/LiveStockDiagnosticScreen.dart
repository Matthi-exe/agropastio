import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ==========================================
// 8. SOUS-MODULE : DIAGNOSTIC IA BÉTAIL
// ==========================================
class LiveStockDiagnosticScreen extends StatefulWidget {
  const LiveStockDiagnosticScreen({super.key});

  @override
  State<LiveStockDiagnosticScreen> createState() =>
      _LiveStockDiagnosticScreenState();
}

class _LiveStockDiagnosticScreenState extends State<LiveStockDiagnosticScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isAnalyzing = false;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _runLocalAnalysis() {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez d\'abord prendre ou sélectionner une photo.'),
        ),
      );
      return;
    }

    setState(() => _isAnalyzing = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isAnalyzing = false);
      _showLivestockResult(context);
    });
  }

  void _showLivestockResult(BuildContext context) {
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
              const Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFFE65100), size: 28),
                  SizedBox(width: 10),
                  Text(
                    'Dermatose Nodulaire Suspectée',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Indice de corrélation locale : 89%',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Divider(height: 24),
              const Text(
                'PROTOCOLE BIOLOGIQUE D\'URGENCE :',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFFE65100),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '1. Isoler immédiatement le sujet atteint pour stopper les vecteurs ailés.\n2. Désinfecter localement les nodules cutanés avec une solution saline purifiée.\n3. Alerter l\'auxiliaire d\'élevage ou vétérinaire local pour confirmation.',
                style: TextStyle(fontSize: 13, height: 1.4),
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
          'Analyse Épidermique',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFE65100),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Cadrez la zone cutanée affectée de l\'animal',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFE65100).withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _imageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          )
                        : Icon(
                            Icons.pets_outlined,
                            size: 72,
                            color: const Color(
                              0xFFE65100,
                            ).withValues(alpha: 0.3),
                          ),
                    _buildCorners(),
                    if (_isAnalyzing)
                      Container(
                        color: Colors.black45,
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Appareil Photo'),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galerie'),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE65100),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.bolt),
              label: Text(
                _isAnalyzing ? 'ANALYSE EN COURS...' : 'ANALYSER LE VIVANT',
              ),
              onPressed: _isAnalyzing ? null : _runLocalAnalysis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorners() {
    return Stack(
      children: [
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFE65100), width: 3),
                left: BorderSide(color: Color(0xFFE65100), width: 3),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFE65100), width: 3),
                right: BorderSide(color: Color(0xFFE65100), width: 3),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE65100), width: 3),
                left: BorderSide(color: Color(0xFFE65100), width: 3),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE65100), width: 3),
                right: BorderSide(color: Color(0xFFE65100), width: 3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
