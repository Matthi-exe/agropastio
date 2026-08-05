import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static final ValueNotifier<Locale> localeNotifier =
      ValueNotifier(const Locale('fr'));

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('fr'),
    Locale('mo'),
  ];

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static Locale get currentLocale => localeNotifier.value;

  static void setLocale(Locale locale) {
    if (supportedLocales.any((item) => item.languageCode == locale.languageCode)) {
      localeNotifier.value = locale;
    }
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'fr': {
      'appTitle': 'Aurora',
      'landingSubtitle': 'Des soins de pointe pour vos cultures et bétails',
      'userIdLabel': 'Identifiant (numéro de téléphone ou email)',
      'passwordLabel': 'Mot de passe',
      'connectButton': 'SE CONNECTER',
      'connectOffline': 'Mode en ligne indisponible sur ce prototype.',
      'offlineSwitch': 'PASSER EN MODE HORS-LIGNE',
      'createAccount': 'Créer un compte (Inscription)',
      'languageLabel': 'Langue',
      'languageFrench': 'Français',
      'languageMooré': 'Mooré',
      'registerTitle': 'Inscription Aurora',
      'registerHeading': 'Rejoignez la communauté',
      'registerSubtitle': 'Créez votre profil pour synchroniser vos données dès le retour du réseau.',
      'fullNameLabel': 'Nom complet',
      'phoneOrEmailLabel': 'Numéro de téléphone ou Email',
      'registerButton': "S'INSCRIRE",
      'registerSuccess': 'Inscription enregistrée localement !',
      'mainWelcome': 'Bienvenue !',
      'mainSubtitle': 'Diagnostic IA local activé.\nAucune connexion requise.',
      'mainMenuAgriculture': 'SANTÉ DES CULTURES',
      'mainMenuLivestock': 'SANTÉ DU BÉTAIL',
      'mainMenuLogout': 'Déconnexion',
      'landingLanguagePrompt': 'Choisissez votre langue',
      'agricultureTitle': 'Aurora — Agriculture',
      'agricultureSlogan': '« Éclairer la terre, nourrir l\'avenir. »',
      'agricultureAdvice': 'Conseil IA local : Conditions idéales validées pour le semis de maïs et sorgho ce matin.',
      'moduleDiagnostic': 'Diagnostic IA',
      'moduleOpportunities': 'Opportunités',
      'moduleCalculator': 'Calculateur',
      'moduleAudit': 'Audit Parcelle',
      'moduleSurvey': 'Marché & Demandes',
      'moduleOpportunitySubtitle': 'Marché & Demandes',
      'moduleCalculatorSubtitle': 'Estimer la récolte',
      'moduleAuditSubtitle': 'Analyse globale',
      'agriAuditTitle': 'Audit Éco-Intelligent',
      'agriAuditHeading': 'Évaluation de la Parcelle',
      'agriSection1': '1. Données Géométriques & Sol',
      'agriSection2': '2. Spécification des Cultures',
      'agriSection3': '3. Pratiques d\'Irrigation',
      'soilSableux': 'Sableux',
      'soilArgileux': 'Argileux',
      'soilLimoneux': 'Limoneux',
      'irrigationPluviale': 'Pluviale',
      'irrigationGoutte': 'Goutte-à-goutte',
      'irrigationPuits': 'Puits',
      'livestockRegimeExtensif': 'Extensif',
      'livestockRegimeSemi': 'Semi-stabulation',
      'livestockSection1': '1. Structure du Cheptel',
      'livestockSection2': '2. Accessibilité Hydrique',
      'moduleActiveBackground': 'Module "{title}" actif en arrière-plan simulé.',
      'moduleLivestockDiagnostic': 'Scanner le vivant',
      'moduleLivestockAudit': 'Audit Troupeau',
      'livestockTitle': 'Aurora — Élevage',
      'livestockSlogan': '« Éclairer la terre, nourrir l\'avenir. »',
      'scanPhytosanitary': 'Scanner Phytosanitaire',
      'scanInstructions': 'Positionnez la feuille malade dans le cadre',
      'cropConcerned': 'Culture concernée',
      'rectoFace': 'Face (recto)',
      'versoBack': 'Dos (verso)',
      'photoButton': 'Photo',
      'galleryButton': 'Galerie',
      'loadingModel': 'CHARGEMENT DU MODÈLE...',
      'analyzing': 'ANALYSE EN COURS...',
      'launchAnalysis': "LANCER L'ANALYSE LOCALE",
      'selectPhotoBoth': 'Veuillez prendre une photo du recto ET du verso.',
      'detectedDisease': '{disease} détectée',
      'certitudeIndex': 'Indice de certitude locale : {score}%',
      'protocolTitle': 'PROTOCOLE DE TRAITEMENT BIOLOGIQUE :',
      'livestockDiagnosticTitle': 'Analyse Épidermique',
      'livestockDiagnosticInstructions': 'Cadrez la zone cutanée affectée de l\'animal',
      'livestockAnalyze': 'ANALYSER LE VIVANT',
      'pickPhotoFirst': 'Veuillez d\'abord prendre ou sélectionner une photo.',
      'livestockResultTitle': 'Dermatose Nodulaire Suspectée',
      'livestockResultIndex': 'Indice de corrélation locale : 89%',
      'livestockProtocolTitle': 'PROTOCOLE BIOLOGIQUE D\'URGENCE :',
      'livestockProtocol': '1. Isoler immédiatement le sujet atteint pour stopper les vecteurs ailés.\n2. Désinfecter localement les nodules cutanés avec une solution saline purifiée.\n3. Alerter l\'auxiliaire d\'élevage ou vétérinaire local pour confirmation.',
      'yieldTitle': 'Calculateur de Rendement',
      'yieldHeading': 'Estimation Prédictive de Récolte',
      'yieldAreaLabel': 'Superficie à exploiter (Hectares)',
      'yieldCropLabel': 'Variété végétale',
      'yieldButton': 'CALCULER',
      'yieldVolume': 'Volume de Récolte Estimé',
      'yieldResult': '{yield} Tonnes',
      'yieldBaseLabel': 'Calcul basé sur la constante nationale pour le {crop}.',
      'auditTitle': 'Audit Éco-Intelligent',
      'auditHeading': 'Évaluation de la Parcelle',
      'auditAreaLabel': 'Superficie (en Hectares)',
      'auditSoilLabel': 'Type de sol',
      'auditCropLabel': 'Espèce cultivée',
      'auditIrrigationLabel': 'Méthode d\'irrigation',
      'auditButton': "GÉNÉRER L'AUDIT REEL",
      'auditInputError': 'Veuillez entrer une superficie valide supérieure à 0.',
      'auditResultTitle': 'Bilan Agro-Écologique',
      'auditRobustness': 'Indice de robustesse : {score}/100',
      'auditOptimal': '• Vos choix techniques sont optimaux pour cette parcelle. Continuez ainsi !',
      'auditCautionHydric': '• Alerte Stress Hydrique : Votre sol sableux filtre l\'eau trop vite pour un régime purement pluvial.',
      'auditSoilMismatch': '• Sol inadapté : Le maïs est exigeant, privilégiez un sol limoneux ou amendez massivement.',
      'auditAdvice': '• Conseil Intelligent : Intégrez un paillage ou une rotation avec le Niébé pour restructurer la couche arable.',
      'closeButton': 'Fermer',
      'livestockAuditTitle': 'Audit Troupeau',
      'livestockAuditHeading': 'Évaluation Éco-Pastorale',
      'livestockHeadCount': 'Nombre de têtes global',
      'livestockRegimeLabel': 'Régime d\'exploitation',
      'livestockWaterDist': 'Distance moyenne du point d\'eau : {distance} km',
      'livestockAuditButton': "LANCER L'ANALYSE REELLE",
      'livestockHeadError': 'Veuillez entrer un nombre d\'animaux valide.',
      'livestockResultScore': 'Score de résilience : {score}/100',
      'livestockResultStatus': '• Statut : {status}',
      'livestockAdvice': '• Conseil Aurora : Prévoyez la fabrication locale de blocs nutritionnels (UMNMB) pour soutenir l\'apport azoté.',
      'livestockResultTitleDialog': 'Bilan Zootechnique',
    },
    'mo': {
      'appTitle': 'Aurora',
      'landingSubtitle': 'Bɛɛr zɛndɛ ka laam yaga laɗɗoore',
      'userIdLabel': 'Yelgɛ (telefoon number walla email)',
      'passwordLabel': 'Sɔrdo',
      'connectButton': 'DƁAƊA',
      'connectOffline': 'Internet yoono ga naŋ wɛɛrɛ.',
      'offlineSwitch': 'TƎƎ PAAR A ZUƁA',
      'createAccount': 'Laaŋo koom (Registration)',
      'languageLabel': 'Kɔndaa',
      'languageFrench': 'Français',
      'languageMooré': 'Mooré',
      'registerTitle': 'Aurora registrasion',
      'registerHeading': 'Tɛɛrɛ ka tuuno',
      'registerSubtitle': 'Maaɲa laŋ kɛde yaar yaa wɛɛrɛ zɛɛga ka baŋ.',
      'fullNameLabel': 'Maa tɛmtɛ',
      'phoneOrEmailLabel': 'Telefoon number walla Email',
      'registerButton': 'REGISTRER',
      'registerSuccess': 'Registrasion ka veŋde local.',
      'mainWelcome': 'Barka !',
      'mainSubtitle': 'IA diagnostic ka doo.\nInternet tee ga.',
      'mainMenuAgriculture': 'KARAA KA ZENDAA',
      'mainMenuLivestock': 'SOORO KA ZENDAA',
      'mainMenuLogout': 'Bɛɛde',
      'landingLanguagePrompt': 'Kɔndaa yaar',
      'agricultureTitle': 'Aurora — Karaa',
      'agricultureSlogan': '« Saŋa laaɗde, naŋa tɩm. »',
      'agricultureAdvice': 'IA conseil : Saŋa deega ga pɛ hɛlɛ ka bɛɛ.',
      'moduleDiagnostic': 'IA Diagnostic',
      'moduleOpportunities': 'Bɛɛbɛr',
      'moduleCalculator': 'Kalkulateer',
      'moduleAudit': 'Parcelle audit',
      'moduleSurvey': 'Maraa & Yaar',
      'moduleOpportunitySubtitle': 'Maraa & Yaar',
      'moduleCalculatorSubtitle': 'Rendement yaar',
      'moduleAuditSubtitle': 'Analyse globale',
      'agriAuditTitle': 'Audit Eco',
      'agriAuditHeading': 'Parcelle evaluation',
      'agriSection1': '1. Geometrie data & soil',
      'agriSection2': '2. Crop specification',
      'agriSection3': '3. Irrigation methods',
      'soilSableux': 'Sableux',
      'soilArgileux': 'Argileux',
      'soilLimoneux': 'Limoneux',
      'irrigationPluviale': 'Pluviale',
      'irrigationGoutte': 'Goutte-à-goutte',
      'irrigationPuits': 'Puits',
      'livestockRegimeExtensif': 'Extensif',
      'livestockRegimeSemi': 'Semi-stabulation',
      'livestockSection1': '1. Cheptel structure',
      'livestockSection2': '2. Water accessibility',
      'moduleActiveBackground': 'Module "{title}" ka doo zaaŋa.',
      'moduleLivestockDiagnostic': 'Zanɛ ka yeene',
      'moduleLivestockAudit': 'Troupeau audit',
      'livestockTitle': 'Aurora — Sooro',
      'livestockSlogan': '« Saŋa laaɗde, naŋa tɩm. »',
      'scanPhytosanitary': 'Phytosanitary scan',
      'scanInstructions': 'Saŋa nyaŋa koore ka naŋ.',
      'cropConcerned': 'Karaa yaar',
      'rectoFace': 'Face (recto)',
      'versoBack': 'Dos (verso)',
      'photoButton': 'Foto',
      'galleryButton': 'Gallery',
      'loadingModel': 'MODEL KAA...',
      'analyzing': 'ANALYSE SƆƆN...',
      'launchAnalysis': 'ANALYSE KƆRƐ',
      'selectPhotoBoth': 'Foto recto walla verso ka yaar.',
      'detectedDisease': '{disease} yaar',
      'certitudeIndex': 'Certitude index : {score}%',
      'protocolTitle': 'PROTOCOLE DE TRAITEMENT BIOLOGIQUE :',
      'livestockDiagnosticTitle': 'Analyse epidermique',
      'livestockDiagnosticInstructions': 'Sooro ka gaande yaar',
      'livestockAnalyze': 'ZANƐ SOORO',
      'pickPhotoFirst': 'Foto yaar maŋ te mɛ.',
      'livestockResultTitle': 'Dermatose Nodulaire Suspectée',
      'livestockResultIndex': 'Correlation index : 89%',
      'livestockProtocolTitle': 'PROTOCOLE D\'URGENCE :',
      'livestockProtocol': '1. Sɔŋga ka yaar foogo to paam.\n2. Nodule ka salin la.\n3. Vétérinaire ka leesa.',
      'yieldTitle': 'Kalkulateur rendement',
      'yieldHeading': 'Rendement estimation',
      'yieldAreaLabel': 'Yaga superficie (Hectares)',
      'yieldCropLabel': 'Karaa yaar',
      'yieldButton': 'KALKULE',
      'yieldVolume': 'Rendement jara',
      'yieldResult': '{yield} Tonnes',
      'yieldBaseLabel': 'Kalkulation ka doo {crop} ka zɛ.',
      'auditTitle': 'Audit Eco',
      'auditHeading': 'Parcelle evaluation',
      'auditAreaLabel': 'Superficie (en Hectares)',
      'auditSoilLabel': 'Blaɲa kind',
      'auditCropLabel': 'Karaa kind',
      'auditIrrigationLabel': 'Water method',
      'auditButton': 'AUDIT KƆRƐ',
      'auditInputError': 'Yaga jaŋ noora no bɛɛ.',
      'auditResultTitle': 'Bilan Agro-Ecologique',
      'auditRobustness': 'Robustness index : {score}/100',
      'auditOptimal': '• Yaa jɛgɛri ka bɛɛ. Tɛ tɛɛrɛ.',
      'auditCautionHydric': '• Water stress alert : tɩ yaar zɛ.',
      'auditSoilMismatch': '• Blaagɛ yaar : maïs ka zɛ, limoneux yaar.',
      'auditAdvice': '• Conseil : paillage walla Niébé rotation.',
      'closeButton': 'Bɛɛde',
      'livestockAuditTitle': 'Troupeau audit',
      'livestockAuditHeading': 'Evaluation eco-pastorale',
      'livestockHeadCount': 'Sɔrɔŋ number',
      'livestockRegimeLabel': 'Exploitation regime',
      'livestockWaterDist': 'Water point distance : {distance} km',
      'livestockAuditButton': 'ANALYSE KƆRƐ',
      'livestockHeadError': 'Sooro number ga ka yaar.',
      'livestockResultScore': 'Resilience score : {score}/100',
      'livestockResultStatus': '• Status : {status}',
      'livestockAdvice': '• Conseil Aurora : Blocs nutritionnels ka tɩm.',
      'livestockResultTitleDialog': 'Bilan zootechnique',
    },
  };

  String get(String key, {Map<String, String>? params}) {
    final value = _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['fr']![key]!;
    if (params != null) {
      return value.replaceAllMapped(
        RegExp(r'\{([^}]+)\}'),
        (match) => params[match.group(1)] ?? match.group(0)!,
      );
    }
    return value;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales.any((l) => l.languageCode == locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
