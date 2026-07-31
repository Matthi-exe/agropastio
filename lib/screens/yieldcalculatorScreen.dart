import 'package:flutter/material.dart';

// ==========================================
// 6B. MODULE REEL : CALCULATEUR RENDEMENT
// ==========================================
class YieldCalculatorScreen extends StatefulWidget {
  const YieldCalculatorScreen({super.key});

  @override
  State<YieldCalculatorScreen> createState() => _YieldCalculatorScreenState();
}

class _YieldCalculatorScreenState extends State<YieldCalculatorScreen> {
  final _areaCalcController = TextEditingController();
  String _cropType = 'Maïs';
  double _calculatedYield = 0.0;
  bool _hasCalculated = false;

  void _computeYield() {
    double? area = double.tryParse(_areaCalcController.text);
    if (area == null || area <= 0) return;

    double baseYieldPerHectare = 1.2;
    if (_cropType == 'Sorgho') baseYieldPerHectare = 0.9;
    if (_cropType == 'Manioc') baseYieldPerHectare = 8.5;
    if (_cropType == 'Niébé') baseYieldPerHectare = 0.6;

    setState(() {
      _calculatedYield = area * baseYieldPerHectare;
      _hasCalculated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculateur de Rendement',
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
              'Estimation Prédictive de Récolte',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _areaCalcController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Superficie à exploiter (Hectares)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _cropType,
              decoration: const InputDecoration(
                labelText: 'Variété végétale',
                border: OutlineInputBorder(),
              ),
              items: [
                'Maïs',
                'Sorgho',
                'Manioc',
                'Niébé',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _cropType = v!),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _computeYield,
              child: const Text(
                'CALCULER',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (_hasCalculated) ...[
              const SizedBox(height: 30),
              Card(
                color: const Color(0xFFE8F5E9),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Volume de Récolte Estimé',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_calculatedYield.toStringAsFixed(2)} Tonnes',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Calcul basé sur la constante nationale pour le $_cropType.',
                        style: const TextStyle(
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
