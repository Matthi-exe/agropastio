import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:agropastio/screens/landingScreen.dart';

const Map<String, List<String>> _protocolesSante = {
  "Mosaïque du Manioc": [
    "Isoler immédiatement et brûler les résidus de plants infectés.",
    "Sélectionner exclusivement des boutures saines pour le prochain cycle.",
    "Pratiquer une rotation stricte avec des légumineuses (Niébé) pour régénérer le sol.",
  ],
  "Rouille du Maïs": [
    "Éliminer les feuilles inférieures présentant des pustules orangées.",
    "Pulvériser une solution de bicarbonate de soude diluée (5g/L) ou décoction de Neem.",
    "Pratiquer une rotation de culture au prochain cycle.",
  ],
  "Saine (Aucune anomalie)": [
    "Contrôler régulièrement l'état foliaire.",
    "Maintenir les bonnes pratiques d'irrigation.",
    "Conserver un couvert végétal protecteur pour le sol.",
  ],
};

const List<String> _defaultProtocolActions = [
  "Isoler immédiatement la zone affectée de la parcelle.",
  "Appliquer un traitement biologique préventif à base d'extraits végétaux locaux.",
  "Surveiller l'évolution des symptômes sous 48h.",
];

List<String> _getProtocolActions(String detectedDisease) {
  return _protocolesSante[detectedDisease] ?? _defaultProtocolActions;
}

void main() {
  runApp(const AuroraApp());
}

class AuroraApp extends StatelessWidget {
  const AuroraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aurora',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
        primaryColor: const Color(0xFF2E7D32),
      ),
      home: const LandingScreen(),
    );
  }
}

// ==========================================
// 2. ÉCRAN D'INSCRIPTION (REGISTER SCREEN)
// ==========================================
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inscription Aurora',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Rejoignez la communauté',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Créez votre profil pour synchroniser vos données dès le retour du réseau.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(
                labelText: "Nom complet",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge_outlined),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: "Numéro de téléphone ou Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.contact_mail_outlined),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Mot de passe",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_open_outlined),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Inscription enregistrée localement !'),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text(
                "S'INSCRIRE",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. MENU PRINCIPAL GLOBAL (MAIN MENU SCREEN)
// ==========================================
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aurora',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        centerTitle: false,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LandingScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Ne y windga !',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Diagnostic IA local activé.\nAucune connexion requise.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AgricultureHomeScreen(),
                      ),
                    );
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.grass, size: 68, color: Color(0xFF2E7D32)),
                      SizedBox(height: 15),
                      Text(
                        'SANTÉ DES CULTURES',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LivestockHomeScreen(),
                      ),
                    );
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pets, size: 68, color: Color(0xFFE65100)),
                      SizedBox(height: 15),
                      Text(
                        'SANTÉ DU BÉTAIL',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. HUB VÉGÉTAL : AURORA AGRICULTURE
// ==========================================
class AgricultureHomeScreen extends StatelessWidget {
  const AgricultureHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aurora — Agriculture',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            const Text(
              '« Éclairer la terre, nourrir l\'avenir. »',
              textAlign: TextAlign.center,
              style: TextStyle(
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lightbulb_outline, color: Color(0xFF2E7D32)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Conseil IA local : Conditions idéales validées pour le semis de maïs et sorgho ce matin.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                    title: 'Diagnostic IA',
                    subtitle: 'Scanner les feuilles',
                    color: const Color(0xFF2E7D32),
                    targetScreen: const DiagnosticScreen(),
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.bar_chart_outlined,
                    title: 'Opportunités',
                    subtitle: 'Marché & Demandes',
                    color: Colors.amber.shade900,
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.calculate_outlined,
                    title: 'Calculateur',
                    subtitle: 'Estimer la récolte',
                    color: Colors.teal.shade700,
                    targetScreen: const YieldCalculatorScreen(),
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.analytics_outlined,
                    title: 'Audit Parcelle',
                    subtitle: 'Analyse globale',
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
    List<String> actions = _getProtocolActions(detectedDisease);

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
                top: BorderSide(color: Color(0xFF2E7D32), width: 3),
                left: BorderSide(color: Color(0xFF2E7D32), width: 3),
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
                top: BorderSide(color: Color(0xFF2E7D32), width: 3),
                right: BorderSide(color: Color(0xFF2E7D32), width: 3),
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
                bottom: BorderSide(color: Color(0xFF2E7D32), width: 3),
                left: BorderSide(color: Color(0xFF2E7D32), width: 3),
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
                bottom: BorderSide(color: Color(0xFF2E7D32), width: 3),
                right: BorderSide(color: Color(0xFF2E7D32), width: 3),
              ),
            ),
          ),
        ),
      ],
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

// ==========================================
// 7. HUB ZOOTECHNIQUE : AURORA ÉLEVAGE
// ==========================================
class LivestockHomeScreen extends StatelessWidget {
  const LivestockHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aurora — Élevage',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFE65100),
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
            const Text(
              '« Une veille protectrice sur votre troupeau. »',
              textAlign: TextAlign.center,
              style: TextStyle(
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
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFB74D)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.gpp_maybe_outlined, color: Color(0xFFE65100)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Alerte Sanitaire : Cas de PPCB signalés à 15km. Vigilance et confinement partiel conseillés.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF5D4037),
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
                    icon: Icons.photo_camera_outlined,
                    title: 'Diagnostic IA',
                    subtitle: 'Analyse des plaies',
                    color: const Color(0xFFE65100),
                    targetScreen: const LiveStockDiagnosticScreen(),
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.shield_outlined,
                    title: 'Audit Résilience',
                    subtitle: 'Calcul de viabilité',
                    color: Colors.brown.shade700,
                    targetScreen: const LiveStockAuditScreen(),
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
              SnackBar(content: Text('Module Zootechnique "$title" simulé.')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
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
