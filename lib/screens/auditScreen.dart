import 'package:flutter/material.dart';

import 'package:agropastio/l10n/app_localizations.dart';

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
    final loc = AppLocalizations.of(context);
    double? area = double.tryParse(_areaController.text);
    if (area == null || area <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.get('auditInputError')),
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
            Text(loc.get('auditResultTitle')),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.get('auditRobustness', params: {'score': score.toString()}),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: score > 70 ? Colors.green : Colors.orange,
              ),
            ),
            const Divider(height: 20),
            if (alerts.isEmpty)
              Text(loc.get('auditOptimal'))
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
            Text(
              loc.get('auditAdvice'),
              style: const TextStyle(
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
            child: Text(
              loc.get('closeButton'),
              style: const TextStyle(
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
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.get('agriAuditTitle'),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              loc.get('agriAuditHeading'),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle(loc.get('agriSection1')),
            TextField(
              controller: _areaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: loc.get('auditAreaLabel'),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _selectedSol,
              decoration: InputDecoration(
                labelText: loc.get('auditSoilLabel'),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              items: [
                loc.get('soilSableux'),
                loc.get('soilArgileux'),
                loc.get('soilLimoneux'),
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _selectedSol = v!),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(loc.get('agriSection2')),
            DropdownButtonFormField<String>(
              initialValue: _selectedCrop,
              decoration: InputDecoration(
                labelText: loc.get('auditCropLabel'),
                border: const OutlineInputBorder(),
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
            _buildSectionTitle(loc.get('agriSection3')),
            DropdownButtonFormField<String>(
              initialValue: _selectedIrrigation,
              decoration: InputDecoration(
                labelText: loc.get('auditIrrigationLabel'),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              items: [
                loc.get('irrigationPluviale'),
                loc.get('irrigationGoutte'),
                loc.get('irrigationPuits'),
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
              child: Text(
                loc.get('auditButton'),
                style: const TextStyle(fontWeight: FontWeight.bold),
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
