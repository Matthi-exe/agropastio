import 'package:flutter/material.dart';

import 'package:agropastio/l10n/app_localizations.dart';

// ==========================================
// 9. SOUS-MODULE REEL : AUDIT DE RÉSILIENCE BÉTAIL
// ==========================================
class LiveStockAuditScreen extends StatefulWidget {
  const LiveStockAuditScreen({super.key});

  @override
  State<LiveStockAuditScreen> createState() => _LiveStockAuditScreenState();
}

class _LiveStockAuditScreenState extends State<LiveStockAuditScreen> {
  final _headCountController = TextEditingController();
  String _regime = 'Extensif';
  double _distanceEau = 1.0;

  void _analyzeLivestockReal() {
    final loc = AppLocalizations.of(context);
    int? heads = int.tryParse(_headCountController.text);
    if (heads == null || heads <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.get('livestockHeadError')),
        ),
      );
      return;
    }

    int resilienceScore = 90;
    String warning = "Structure saine.";

    if (_regime == 'Extensif') {
      resilienceScore -= 20;
    }
    if (_distanceEau > 3.0) {
      resilienceScore -= 25;
      warning =
          "Risque critique de perte de poids de 15% en saison sèche en raison de l'effort d'accès à l'eau.";
    } else if (_regime == 'Extensif' && _distanceEau <= 3.0) {
      warning = "Vulnérabilité moyenne face aux aléas fourragers.";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.shield_outlined, color: Colors.brown),
            const SizedBox(width: 10),
            Text(loc.get('livestockResultTitleDialog')),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.get('livestockResultScore', params: {'score': resilienceScore.toString()}),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: resilienceScore < 60 ? Colors.red : Colors.orange,
              ),
            ),
            const Divider(height: 20),
            Text(
              loc.get('livestockResultStatus', params: {'status': warning}),
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 10),
            Text(
              loc.get('livestockAdvice'),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
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
                color: Colors.brown,
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
          loc.get('livestockAuditTitle'),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFE65100),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              loc.get('livestockAuditHeading'),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle(loc.get('livestockSection1')),
            TextField(
              controller: _headCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: loc.get('livestockHeadCount'),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _regime,
              decoration: InputDecoration(
                labelText: loc.get('livestockRegimeLabel'),
                border: const OutlineInputBorder(),
              ),
              items: [
                loc.get('livestockRegimeExtensif'),
                loc.get('livestockRegimeSemi'),
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _regime = v!),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(loc.get('livestockSection2')),
            Slider(
              value: _distanceEau,
              min: 0.5,
              max: 10.0,
              divisions: 19,
              activeColor: const Color(0xFFE65100),
              label: '$_distanceEau km',
              onChanged: (v) => setState(
                () => _distanceEau = double.parse(v.toStringAsFixed(1)),
              ),
            ),
            Center(
              child: Text(
                loc.get('livestockWaterDist', params: {'distance': _distanceEau.toStringAsFixed(1)}),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _analyzeLivestockReal,
              child: Text(
                loc.get('livestockAuditButton'),
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
          color: Color(0xFFE65100),
        ),
      ),
    );
  }
}
