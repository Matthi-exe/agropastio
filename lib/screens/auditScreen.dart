import 'package:flutter/material.dart';

// ==========================================
// 6. SOUS-MODULE REEL : AUDIT DE PARCELLE
// ==========================================
class AuditScreen extends StatefulWidget {
  const AuditScreen({super.key});

  @override
  State<AuditScreen> createState() => _AuditScreenState();
}

class _AuditScreenState extends State<AuditScreen> {
  final _areaController = TextEditingController();
  String _selectedSol = 'Sableux';
  String _selectedCrop = 'Maïs';
  String _selectedIrrigation = 'Pluviale';

  void _calculateRealAudit() {
    double? area = double.tryParse(_areaController.text);
    if (area == null || area <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Veuillez entrer une superficie valide supérieure à 0.',
          ),
        ),
      );
      return;
    }

    int score = 85;
    List<String> alerts = [];

    if (_selectedSol == 'Sableux' && _selectedIrrigation == 'Pluviale') {
      score -= 30;
      alerts.add(
        '• Alerte Stress Hydrique : Votre sol sableux filtre l\'eau trop vite pour un régime purement pluvial.',
      );
    }
    if (_selectedCrop == 'Maïs' && _selectedSol == 'Sableux') {
      score -= 10;
      alerts.add(
        '• Sol inadapté : Le maïs est exigeant, privilégiez un sol limoneux ou amendez massivement.',
      );
    }
    if (_selectedIrrigation == 'Goutte-à-goutte') {
      score += 15;
    }

    if (score > 100) score = 100;
    if (score < 0) score = 12;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(
              Icons.analytics,
              color: score > 70 ? Colors.green : Colors.orange,
            ),
            const SizedBox(width: 10),
            const Text('Bilan Agro-Écologique'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Indice de robustesse : $score/100',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: score > 70 ? Colors.green : Colors.orange,
              ),
            ),
            const Divider(height: 20),
            if (alerts.isEmpty)
              const Text(
                '• Vos choix techniques sont optimaux pour cette parcelle. Continuez ainsi !',
              )
            else
              Column(
                children: alerts
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Text(e, style: const TextStyle(fontSize: 13)),
                      ),
                    )
                    .toList(),
              ),
            const SizedBox(height: 10),
            const Text(
              '• Conseil Intelligent : Intégrez un paillage ou une rotation avec le Niébé pour restructurer la couche arable.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Fermer',
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Audit Éco-Intelligent',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Évaluation de la Parcelle',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('1. Données Géométriques & Sol'),
            TextField(
              controller: _areaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Superficie (en Hectares)',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _selectedSol,
              decoration: const InputDecoration(
                labelText: 'Type de sol',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              items: [
                'Sableux',
                'Argileux',
                'Limoneux',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _selectedSol = v!),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('2. Spécification des Cultures'),
            DropdownButtonFormField<String>(
              initialValue: _selectedCrop,
              decoration: const InputDecoration(
                labelText: 'Espèce cultivée',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              items: [
                'Maïs',
                'Sorgho',
                'Manioc',
                'Niébé',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _selectedCrop = v!),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('3. Pratiques d\'Irrigation'),
            DropdownButtonFormField<String>(
              initialValue: _selectedIrrigation,
              decoration: const InputDecoration(
                labelText: 'Méthode d\'irrigation',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              items: [
                'Pluviale',
                'Goutte-à-goutte',
                'Puits',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _selectedIrrigation = v!),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _calculateRealAudit,
              child: const Text(
                'GÉNÉRER L\'AUDIT REEL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2E7D32),
        ),
      ),
    );
  }
}
