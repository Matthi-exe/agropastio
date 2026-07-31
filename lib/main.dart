import 'package:flutter/material.dart';
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

List<String> getProtocolActions(String detectedDisease) {
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
