// Protocol details (actions, recommended products, traditional remedies)
const Map<String, Map<String, dynamic>> _protocolDetailsFr = {
  "Sain": {
    "actions": [
      "Contrôler régulièrement l'état foliaire.",
      "Maintenir les bonnes pratiques d'irrigation.",
      "Conserver un couvert végétal protecteur pour le sol.",
    ],
    "products": [],
    "traditional": [
      "Surveiller et arroser de façon adaptée.",
      "Décoction de cendre pour nettoyer la base des feuilles si nécessaire.",
    ],
  },
  "Common Rust(rouille)": {
    "actions": [
      "Éliminer les feuilles fortement infectées.",
      "Favoriser l'aération du champ et réduire l'humidité de surface.",
    ],
    "products": [
      "Fongicide recommandé (ex: produit à base de triazole) - consulter fournisseur local",
    ],
    "traditional": [
      "Pulvériser une décoction de feuilles de Neem.",
      "Solution de bicarbonate de soude diluée (5g/L) en pulvérisation préventive.",
    ],
  },
  "Helminthosporiose(NLB)": {
    "actions": [
      "Retirer les plantes très atteintes.",
      "Appliquer des fongicides recommandés par le service agronomique local.",
    ],
    "products": [
      "Fongicide local recommandé (consulter fournisseur)",
    ],
    "traditional": [
      "Décoction de plantes amères et pulvérisation locale sur les parties infectées.",
    ],
  },
  "Tache Grise(GLS)": {
    "actions": [
      "Éliminer les feuilles atteintes et éviter l'excès d'azote.",
      "Favoriser la rotation culturale.",
    ],
    "products": [
      "Fongicide recommandé (consulter fournisseur local)",
    ],
    "traditional": [
      "Pulvérisation de décoction de Neem ou de cendre diluée.",
    ],
  },
  "Necrose Letale(MLN)": {
    "actions": [
      "Supprimer et détruire les plants infectés dès détection.",
      "Utiliser des semences certifiées et résistantes si disponibles.",
      "Contrôler les vecteurs (insectes) et pratiquer la rotation des cultures.",
    ],
    "products": [
      "Semences certifiées résistantes (si disponibles) et produits de lutte contre les vecteurs (insecticides recommandés)",
    ],
    "traditional": [
      "Retirer les plants malades et brûler les résidus. Utiliser décoction de Neem comme répulsif d'insectes.",
    ],
  },
  "Striures(MSV)": {
    "actions": [
      "Supprimer les plants infectés et réduire les populations d'insectes vecteurs.",
      "Utiliser des semences saines et pratiquer la rotation.",
    ],
    "products": [
      "Produits de lutte contre les insectes vecteurs (insecticides recommandés) et semences certifiées.",
    ],
    "traditional": [
      "Pulvérisations de décoction de Neem et plantations d'isolats pour réduire la propagation.",
    ],
  },
};

const Map<String, Map<String, dynamic>> _protocolDetailsMo = {
  "Sain": {
    "actions": [
      "Feuille yaar ka zɛɛga.",
      "Yooma ka yaar ka zɛɛga.",
      "Kaaŋa ka baŋa laam.",
    ],
    "products": [],
    "traditional": [
      "Yooma ka sɔgɔma la cendre ka yaar.",
    ],
  },
  "Common Rust(rouille)": {
    "actions": [
      "Feuille dɛɛrɛ ka naŋ kiŋa.",
      "Ka yooma ka laam ka zɛɛga.",
    ],
    "products": [
      "Fongicide biisa (triazole) - taaba ka wende ka bala.",
    ],
    "traditional": [
      "Neem decoction ka yaar.",
      "Bicarbonate 5g/L ka yaar.",
    ],
  },
  "Helminthosporiose(NLB)": {
    "actions": [
      "Plants ba yaar ka dɛɛrɛŋ.",
      "Fongicide ka yaar ka bala.",
    ],
    "products": [
      "Fongicide ka bala (taaba ka wende)",
    ],
    "traditional": [
      "Décoction ka yaar ka fa.",
    ],
  },
  "Tache Grise(GLS)": {
    "actions": [
      "Leaves ka dɛɛrɛŋ ka naŋ.",
      "Rotation ka laam.",
    ],
    "products": [
      "Fongicide ka bala (taaba ka wende)",
    ],
    "traditional": [
      "Neem decoction ka yaar.",
    ],
  },
  "Necrose Letale(MLN)": {
    "actions": [
      "Plants ka dɛɛrɛŋ ka yɛlɛŋ.",
      "Semences caafa ka yaar.",
      "Insectes ka dɛɛrɛŋ ka yaar.",
    ],
    "products": [
      "Semences caafa yaa (si disponible) et insecticide ka bala.",
    ],
    "traditional": [
      "Plants ba dɛɛrɛŋ ka sɛlɛ ka yaa, Neem decoction ka yaar.",
    ],
  },
  "Striures(MSV)": {
    "actions": [
      "Plants ba dɛɛrɛŋ ka sɛlɛ.",
      "Semences yaar ka laam.",
    ],
    "products": [
      "Insecticide ka bala et semences caafa.",
    ],
    "traditional": [
      "Neem decoction ka yaar.",
    ],
  },
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

Map<String, dynamic> getProtocolDetail(String detectedDisease, String languageCode) {
  final map = languageCode == 'mo' ? _protocolDetailsMo : _protocolDetailsFr;
  final defaults = languageCode == 'mo' ? _defaultProtocolActionsMo : _defaultProtocolActionsFr;

  final entry = map[detectedDisease];
  if (entry != null) {
    return entry;
  }

  return {
    'actions': defaults,
    'products': <String>[],
    'traditional': <String>[],
  };
}

List<String> getProtocolActions(String detectedDisease, String languageCode) {
  final detail = getProtocolDetail(detectedDisease, languageCode);
  return List<String>.from(detail['actions'] ?? []);
}
