import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../data/festival_data.dart';
import '../models/festival.dart';
import '../models/puja_item.dart';
import '../models/vidhi_step.dart';

class DevotionalVoice {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final double pitch;
  final double rateFactor;
  final bool isMale;

  const DevotionalVoice({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.pitch,
    required this.rateFactor,
    required this.isMale,
  });
}

class AppState extends ChangeNotifier {
  // Navigation
  int _currentNavIndex = 0;
  int get currentNavIndex => _currentNavIndex;

  void setNavIndex(int index) {
    _currentNavIndex = index;
    notifyListeners();
  }

  // Theme & Language
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool dark) {
    _themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  String _language = 'hi'; // 'hi' or 'en'
  String get language => _language;

  void setLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }

  // 10 Devotional Voice Profiles (10 दिव्य स्वर विकल्प)
  static const List<DevotionalVoice> devotionalVoices = [
    DevotionalVoice(
      id: 'vedic_pandit',
      title: 'वैदिक पंडित जी',
      subtitle: 'गंभीर मंत्रोच्चार',
      description: 'गंभीर बेस, वैदिक गति एवं स्पष्ट संस्कृत उच्चारण',
      pitch: 0.76,
      rateFactor: 0.88,
      isMale: true,
    ),
    DevotionalVoice(
      id: 'shastri_ji',
      title: 'आचार्य / शास्त्री जी',
      subtitle: 'स्पष्ट एवं संतुलित पाठ',
      description: 'संतुलित सुर, नित्य पूजा व विधि पाठ हेतु सर्वश्रेष्ठ',
      pitch: 0.85,
      rateFactor: 0.95,
      isMale: true,
    ),
    DevotionalVoice(
      id: 'sadhvi_swar',
      title: 'साध्वी स्वर',
      subtitle: 'भक्तिमय एवं मधुर',
      description: 'मधुर, कोमल एवं भावपूर्ण देवी आराधना स्वर',
      pitch: 1.12,
      rateFactor: 0.92,
      isMale: false,
    ),
    DevotionalVoice(
      id: 'guru_vani',
      title: 'गुरुवाणी स्वर',
      subtitle: 'शांत व पावन',
      description: 'अति शांत, अंतर्मुखी व ध्यानस्थ दिव्य वाणी',
      pitch: 0.80,
      rateFactor: 0.82,
      isMale: true,
    ),
    DevotionalVoice(
      id: 'rishi_chintan',
      title: 'ऋषि वाणी',
      subtitle: 'धीमी एवं तपोमय',
      description: 'धीमी गति, गहन आध्यात्मिक प्रभाव एवं ध्यान साधना',
      pitch: 0.72,
      rateFactor: 0.78,
      isMale: true,
    ),
    DevotionalVoice(
      id: 'deva_swar',
      title: 'देववाणी स्वर',
      subtitle: 'तेजस्वी व ओजस्वी',
      description: 'ओजस्वी, ऊर्जावान एवं स्पष्ट श्लोक उच्चारण',
      pitch: 0.95,
      rateFactor: 1.0,
      isMale: true,
    ),
    DevotionalVoice(
      id: 'bal_bhakt',
      title: 'बाल भक्त',
      subtitle: 'सहज व पावन',
      description: 'निर्मल, सरल एवं बाल सुलभ पावन स्वर',
      pitch: 1.25,
      rateFactor: 1.05,
      isMale: false,
    ),
    DevotionalVoice(
      id: 'shanta_sandhya',
      title: 'शांत संध्या स्वर',
      subtitle: 'शीतल अमृत वेला',
      description: 'शीतल, मनमोहक एवं सांध्य ध्यान योग्य शांत स्वर',
      pitch: 0.92,
      rateFactor: 0.85,
      isMale: false,
    ),
    DevotionalVoice(
      id: 'anand_dhwani',
      title: 'आनंद ध्वनि',
      subtitle: 'प्रसन्नता व ऊर्जा',
      description: 'उत्साहवर्धक, कीर्तन व भजन वाचन के अनुकूल',
      pitch: 1.02,
      rateFactor: 1.06,
      isMale: true,
    ),
    DevotionalVoice(
      id: 'madhur_kanta',
      title: 'मधुर कंठ',
      subtitle: 'कोमल आरती स्वर',
      description: 'आरती व स्तुति गान हेतु अत्यंत सुरीला व कोमल स्वर',
      pitch: 1.18,
      rateFactor: 0.96,
      isMale: false,
    ),
  ];

  String _selectedVoice = 'vedic_pandit';
  String get selectedVoice => _selectedVoice;

  DevotionalVoice get currentVoiceConfig {
    return devotionalVoices.firstWhere(
      (v) => v.id == _selectedVoice,
      orElse: () => devotionalVoices[0],
    );
  }

  void setVoice(String voice) {
    _selectedVoice = voice;
    notifyListeners();
  }

  double _voiceSpeed = 1.0;
  double get voiceSpeed => _voiceSpeed;

  void setVoiceSpeed(double speed) {
    _voiceSpeed = speed;
    notifyListeners();
  }

  // Audio player state & TTS
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlayingAudio = false;
  bool get isPlayingAudio => _isPlayingAudio;

  bool _isPlayingMahamantra = false;
  bool get isPlayingMahamantra => _isPlayingMahamantra;

  void _initTts() {
    _flutterTts.setCompletionHandler(() {
      _isPlayingAudio = false;
      _isPlayingMahamantra = false;
      notifyListeners();
    });
    _flutterTts.setCancelHandler(() {
      _isPlayingAudio = false;
      _isPlayingMahamantra = false;
      notifyListeners();
    });
    _flutterTts.setErrorHandler((dynamic msg) {
      _isPlayingAudio = false;
      _isPlayingMahamantra = false;
      notifyListeners();
    });

    _configureNaturalVoiceEngine();
  }

  Future<void> _configureNaturalVoiceEngine() async {
    try {
      await _flutterTts.setEngine("com.google.android.tts");
      await _flutterTts.setLanguage("hi-IN");
      await _flutterTts.setVolume(1.0);
    } catch (_) {}
  }

  Future<void> _applyVoiceSettings([DevotionalVoice? specificVoice]) async {
    final cfg = specificVoice ?? currentVoiceConfig;
    if (_language == 'hi') {
      await _flutterTts.setLanguage("hi-IN");
    } else {
      await _flutterTts.setLanguage("en-US");
    }

    final computedRate = (_voiceSpeed * 0.42 * cfg.rateFactor).clamp(0.15, 1.0);
    await _flutterTts.setSpeechRate(computedRate);
    await _flutterTts.setPitch(cfg.pitch);
    await _flutterTts.setVolume(1.0);
  }

  // Live test preview of a voice in settings
  Future<void> previewVoice(String voiceId) async {
    try {
      await _flutterTts.stop();
      _isPlayingAudio = false;
      _isPlayingMahamantra = false;
      setVoice(voiceId);

      final voiceCfg = devotionalVoices.firstWhere((v) => v.id == voiceId);
      await _applyVoiceSettings(voiceCfg);

      _isPlayingAudio = true;
      notifyListeners();

      const sampleText = 'ॐ नमः शिवाय। आपका दिन शुभ और मंगलमय हो।';
      await _flutterTts.speak(sampleText);
    } catch (_) {
      _isPlayingAudio = false;
      notifyListeners();
    }
  }

  // Recite the Daily Mahamantra
  Future<void> speakMahamantra() async {
    try {
      if (_isPlayingMahamantra) {
        await stopAudio();
        return;
      }
      await _flutterTts.stop();
      _isPlayingAudio = false;

      await _applyVoiceSettings();

      _isPlayingMahamantra = true;
      notifyListeners();

      const mantra = 'ॐ नमः शिवाय। शुभं करोति कल्याणम् आरोग्यम् धनसंपदा। शत्रुबुद्धि विनाशाय दीपज्योतिर् नमोऽस्तु ते।';
      await _flutterTts.speak(mantra);
    } catch (_) {
      _isPlayingMahamantra = false;
      notifyListeners();
    }
  }

  Future<void> speakText(String text) async {
    try {
      await _flutterTts.stop();
      await _applyVoiceSettings();
      _isPlayingAudio = true;
      notifyListeners();
      await _flutterTts.speak(text);
    } catch (_) {
      _isPlayingAudio = false;
      notifyListeners();
    }
  }

  Future<void> toggleAudio() async {
    if (_isPlayingAudio) {
      await stopAudio();
    } else {
      await playCurrentStepAudio();
    }
  }

  Future<void> playCurrentStepAudio() async {
    try {
      await _flutterTts.stop();
      _isPlayingMahamantra = false;

      await _applyVoiceSettings();

      final step = currentStep;
      final textToSpeak = '${step.fullTitle}। ${step.instruction} ${step.mantra}';

      _isPlayingAudio = true;
      notifyListeners();

      await _flutterTts.speak(textToSpeak);
    } catch (e) {
      _isPlayingAudio = false;
      notifyListeners();
    }
  }

  Future<void> stopAudio() async {
    try {
      await _flutterTts.stop();
    } catch (_) {}
    _isPlayingAudio = false;
    _isPlayingMahamantra = false;
    notifyListeners();
  }

  // Active Festival
  late List<Festival> _festivals;
  List<Festival> get festivals => _festivals;

  late Festival _selectedFestival;
  Festival get selectedFestival => _selectedFestival;

  void selectFestival(Festival festival) {
    stopAudio();
    _selectedFestival = festival;
    _currentStepIndex = 0;
    notifyListeners();
  }

  // Search filter
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  void setSearchQuery(String q) {
    _searchQuery = q;
    notifyListeners();
  }

  List<Festival> get filteredFestivals {
    if (_searchQuery.trim().isEmpty) return _festivals;
    final q = _searchQuery.toLowerCase();
    return _festivals.where((f) {
      return f.nameHindi.contains(q) ||
          f.nameEnglish.toLowerCase().contains(q) ||
          f.dateHindi.contains(q);
    }).toList();
  }

  // Dynamic Checklist for Selected Festival
  List<PujaItem> get checklist => _selectedFestival.checklist;

  int get purchasedCount =>
      _selectedFestival.checklist.where((item) => item.isPurchased).length;
  int get totalCount => _selectedFestival.checklist.length;

  void toggleItemPurchased(String id) {
    final index = _selectedFestival.checklist.indexWhere((item) => item.id == id);
    if (index != -1) {
      _selectedFestival.checklist[index].isPurchased =
          !_selectedFestival.checklist[index].isPurchased;
      _selectedFestival.completedItems = purchasedCount;
      notifyListeners();
    }
  }

  // Dynamic Step-by-Step Vidhi for Selected Festival
  List<VidhiStep> get steps => _selectedFestival.steps;

  int _currentStepIndex = 0;
  int get currentStepIndex => _currentStepIndex;
  VidhiStep get currentStep => _selectedFestival.steps[_currentStepIndex];

  void nextStep() {
    if (_currentStepIndex < steps.length - 1) {
      stopAudio();
      _currentStepIndex++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStepIndex > 0) {
      stopAudio();
      _currentStepIndex--;
      notifyListeners();
    }
  }

  void goToStep(int index) {
    if (index >= 0 && index < steps.length) {
      stopAudio();
      _currentStepIndex = index;
      notifyListeners();
    }
  }

  // Saved list tab index (0: सामग्री सूची, 1: विधि, 2: पंचांग)
  int _savedListTab = 0;
  int get savedListTab => _savedListTab;

  void setSavedListTab(int index) {
    _savedListTab = index;
    notifyListeners();
  }

  // Remove festival from saved lists
  void removeSavedFestival(String id) {
    final index = _festivals.indexWhere((f) => f.id == id);
    if (index != -1) {
      notifyListeners();
    }
  }

  AppState() {
    _festivals = FestivalData.getFestivals();
    _selectedFestival = _festivals[0]; // Mahashivratri default
    _currentStepIndex = 1; // Default to step 2 for initial state
    _initTts();
  }
}
