import 'package:flutter/material.dart';

import 'package:agropastio/l10n/app_localizations.dart';
import 'package:agropastio/screens/auditScreen.dart';
import 'package:agropastio/screens/diagnosticScreen.dart';
import 'package:agropastio/screens/yieldcalculatorScreen.dart';

// ==========================================
// 4. HUB VÉGÉTAL : AURORA AGRICULTURE
// ==========================================
class AgricultureHomeScreen extends StatelessWidget {
  const AgricultureHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.get('agricultureTitle'),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Text(
              loc.get('agricultureSlogan'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF81C784)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lightbulb_outline, color: Color(0xFF2E7D32)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      loc.get('agricultureAdvice'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1B5E20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                children: [
                  _buildMenuCard(
                    context,
                    icon: Icons.center_focus_strong,
                    title: loc.get('moduleDiagnostic'),
                    subtitle: loc.get('scanInstructions'),
                    color: const Color(0xFF2E7D32),
                    targetScreen: const DiagnosticScreen(),
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.bar_chart_outlined,
                    title: loc.get('moduleOpportunities'),
                    subtitle: loc.get('moduleOpportunitySubtitle'),
                    color: Colors.amber.shade900,
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.calculate_outlined,
                    title: loc.get('moduleCalculator'),
                    subtitle: loc.get('moduleCalculatorSubtitle'),
                    color: Colors.teal.shade700,
                    targetScreen: const YieldCalculatorScreen(),
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.analytics_outlined,
                    title: loc.get('moduleAudit'),
                    subtitle: loc.get('moduleAuditSubtitle'),
                    color: Colors.purple.shade700,
                    targetScreen: const AuditScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    Widget? targetScreen,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          if (targetScreen != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetScreen),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Module "$title" actif en arrière-plan simulé.'),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 11, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
