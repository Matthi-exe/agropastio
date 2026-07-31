import 'package:flutter/material.dart';

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
    int? heads = int.tryParse(_headCountController.text);
    if (heads == null || heads <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez entrer un nombre d\'animaux valide.'),
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
        title: const Row(
          children: [
            Icon(Icons.shield_outlined, color: Colors.brown),
            SizedBox(width: 10),
            Text('Bilan Zootechnique'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Score de résilience : $resilienceScore/100',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: resilienceScore < 60 ? Colors.red : Colors.orange,
              ),
            ),
            const Divider(height: 20),
            Text('• Statut : $warning', style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 10),
            const Text(
              '• Conseil Aurora : Prévoyez la fabrication locale de blocs nutritionnels (UMNMB) pour soutenir l\'apport azoté.',
              style: TextStyle(
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
            child: const Text(
              'Fermer',
              style: TextStyle(
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Audit Troupeau',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFE65100),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Évaluation Éco-Pastorale',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('1. Structure du Cheptel'),
            TextField(
              controller: _headCountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nombre de têtes global',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _regime,
              decoration: const InputDecoration(
                labelText: 'Régime d\'exploitation',
                border: OutlineInputBorder(),
              ),
              items: [
                'Extensif',
                'Semi-stabulation',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _regime = v!),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('2. Accessibilité Hydrique'),
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
                'Distance moyenne du point d\'eau : $_distanceEau km',
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
              child: const Text(
                'LANCER L\'ANALYSE REELLE',
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
          color: Color(0xFFE65100),
        ),
      ),
    );
  }
}
