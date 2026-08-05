const Map<String, List<String>> _protocolesSanteFr = {
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

const Map<String, List<String>> _protocolesSanteMo = {
  "Mosaïque du Manioc": [
    "Yaar yi boŋ ka dɛɛrɛ ka ba yaam.",
    "Yambaarɛ ka yit teŋ teŋ kɔrɔ.",
    "Kaaŋa saŋa ka niébé zɛɛga ka laam.",
  ],
  "Rouille du Maïs": [
    "Feuilles dɛɛrɛ ka naŋ kiŋa.",
    "Bicarbonate solution ka yaar 5g/L walla neem decoction.",
    "Kaaŋa saŋa ka kɔrɔŋ toŋ.",
  ],
  "Saine (Aucune anomalie)": [
    "Feuille yaar ka zɛɛga.",
    "Yooma ka yaar ka zɛɛga.",
    "Kaaŋa ka baŋa laam.",
  ],
};

const List<String> _defaultProtocolActionsFr = [
  "Isoler immédiatement la zone affectée de la parcelle.",
  "Appliquer un traitement biologique préventif à base d'extraits végétaux locaux.",
  "Surveiller l'évolution des symptômes sous 48h.",
];

const List<String> _defaultProtocolActionsMo = [
  "Yaaŋa ka zɛɛga loore ka baŋ.",
  "Biologique traitement ka yaar ka zɛɛga.",
  "Symptoms ka yaar 48h pɛ.",
];

List<String> getProtocolActions(String detectedDisease, String languageCode) {
  final protocols = languageCode == 'mo'
      ? _protocolesSanteMo
      : _protocolesSanteFr;
  final defaults = languageCode == 'mo'
      ? _defaultProtocolActionsMo
      : _defaultProtocolActionsFr;

  return protocols[detectedDisease] ?? defaults;
}
