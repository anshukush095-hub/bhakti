import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../services/ad_service.dart';
import '../services/sound_service.dart';
import '../theme/app_theme.dart';
import '../widgets/ad_banner_widget.dart';

class JapaMalaScreen extends StatefulWidget {
  const JapaMalaScreen({super.key});

  @override
  State<JapaMalaScreen> createState() => _JapaMalaScreenState();
}

class _JapaMalaScreenState extends State<JapaMalaScreen> with SingleTickerProviderStateMixin {
  int _count = 0;
  int _malas = 0;
  late AnimationController _animController;
  late FlutterTts _tts;
  bool _isPlayingAudio = false;

  final List<Map<String, String>> _mantras = [
    {
      'name': 'गायत्री मंत्र (Gayatri Mantra)',
      'deity': 'मां गायत्री',
      'text': 'ॐ भूर्भुवः स्वः तत्सवितुर्वरेण्यं भर्गो देवस्य धीमहि धियो यो नः प्रचोदयात्॥',
    },
    {
      'name': 'महामृत्युंजय मंत्र (Maha Mrityunjaya)',
      'deity': 'भगवान शिव',
      'text': 'ॐ त्र्यम्बकं यजामहे सुगन्धिं पुष्टिवर्धनम्। उर्वारुकमिव बन्धनान्मृत्योर्मुक्षीय मामृतात्॥',
    },
    {
      'name': 'शिव पंचाक्षर मंत्र (Shiva Mantra)',
      'deity': 'महादेव',
      'text': 'ॐ नमः शिवाय',
    },
    {
      'name': 'महामंत्र (Hare Krishna)',
      'deity': 'भगवान श्री कृष्ण',
      'text': 'हरे कृष्ण हरे कृष्ण कृष्ण कृष्ण हरे हरे। हरे राम हरे राम राम राम हरे हरे॥',
    },
    {
      'name': 'गणेश मंत्र (Ganesh Mantra)',
      'deity': 'भगवान गणेश',
      'text': 'ॐ गं गणपतये नमः',
    },
    {
      'name': 'हनुमान मंत्र (Hanuman Mantra)',
      'deity': 'बजरंगबली',
      'text': 'ॐ श्री हनुमते नमः',
    },
    {
      'name': 'श्री राम तारक मंत्र (Ram Mantra)',
      'deity': 'प्रभु श्री राम',
      'text': 'श्री राम जय राम जय जय राम',
    },
  ];

  int _selectedMantraIndex = 0;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      lowerBound: 0.92,
      upperBound: 1.0,
      value: 1.0,
    );
    _initTts();
  }

  void _initTts() {
    _tts = FlutterTts();
    _tts.setLanguage('hi-IN');
    _tts.setSpeechRate(0.45);
    _tts.setCompletionHandler(() {
      if (mounted) setState(() => _isPlayingAudio = false);
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _tts.stop();
    super.dispose();
  }

  void _incrementCounter() {
    SoundService.instance.playJapaBead();
    _animController.reverse().then((_) => _animController.forward());

    setState(() {
      _count++;
      if (_count >= 108) {
        _count = 0;
        _malas++;
        SoundService.instance.playTempleBell();
        _showMalaCompletedDialog();
      }
    });
  }

  void _resetCounter() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('जप रीसेट करें?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('क्या आप वर्तमान जप माला की गणना शून्य (0) करना चाहते हैं?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('नहीं')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryMaroon),
            onPressed: () {
              setState(() {
                _count = 0;
              });
              Navigator.pop(ctx);
            },
            child: const Text('हाँ, रीसेट करें', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showMalaCompletedDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Text('🌸', style: TextStyle(fontSize: 26)),
            SizedBox(width: 8),
            Text('108 जप पूर्ण!', style: TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '॥ ॐ शांतिः शांतिः शांतिः ॥\n\n'
              'आपकी 1 संपूर्ण माला (108 जप) सफलतापूर्वक संपन्न हुई। प्रभु की कृपा आप पर सदा बनी रहे।',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.accentGold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'कुल पूर्ण माला: $_malas',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primaryMaroon),
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryMaroon,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                AdService.instance.showMilestoneInterstitial();
              },
              child: const Text('अगली माला आरंभ करें', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleAudio() async {
    if (_isPlayingAudio) {
      await _tts.stop();
      setState(() => _isPlayingAudio = false);
    } else {
      final currentMantra = _mantras[_selectedMantraIndex];
      setState(() => _isPlayingAudio = true);
      await _tts.speak(currentMantra['text']!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.isDarkMode;
    final currentMantra = _mantras[_selectedMantraIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('डिजिटल 108 जप माला'),
        actions: [
          IconButton(
            tooltip: 'रीसेट करें',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _resetCounter,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // 1. Mantra Selector Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF2C241B), const Color(0xFF1E1A16)]
                        : [const Color(0xFFFFF8F0), const Color(0xFFFFEED9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primarySaffron.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('🕉️', style: TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            Text(
                              currentMantra['deity']!,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.primarySaffron : AppColors.primaryMaroon,
                              ),
                            ),
                          ],
                        ),
                        PopupMenuButton<int>(
                          initialValue: _selectedMantraIndex,
                          icon: const Icon(Icons.swap_horiz_rounded, color: AppColors.primarySaffron),
                          tooltip: 'मंत्र बदलें',
                          onSelected: (idx) {
                            setState(() {
                              _selectedMantraIndex = idx;
                            });
                          },
                          itemBuilder: (context) => List.generate(
                            _mantras.length,
                            (index) => PopupMenuItem(
                              value: index,
                              child: Text(
                                _mantras[index]['name']!,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      currentMantra['text']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : AppColors.primaryMaroon,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? AppColors.bgDarkCard : Colors.white,
                            foregroundColor: AppColors.primaryMaroon,
                            elevation: 1,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          ),
                          onPressed: _toggleAudio,
                          icon: Icon(
                            _isPlayingAudio ? Icons.pause_circle_filled : Icons.volume_up_rounded,
                            size: 18,
                            color: AppColors.primarySaffron,
                          ),
                          label: Text(
                            _isPlayingAudio ? 'रोकें' : 'मंत्र श्रवण',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 2. Mala Stats (Mala Count & Beads Left)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatBadge(
                    label: 'पूर्ण माला',
                    value: '$_malas',
                    icon: Icons.workspace_premium_rounded,
                    isDark: isDark,
                  ),
                  _buildStatBadge(
                    label: 'शेष मनके',
                    value: '${108 - _count}',
                    icon: Icons.hourglass_bottom_rounded,
                    isDark: isDark,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // 3. Interactive Mala Bead Touch Target
              ScaleTransition(
                scale: _animController,
                child: GestureDetector(
                  onTap: _incrementCounter,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: isDark
                            ? [const Color(0xFF6B2D26), const Color(0xFF2A110E)]
                            : [const Color(0xFFE55A43), const Color(0xFF8B2515)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryMaroon.withValues(alpha: 0.35),
                          blurRadius: 28,
                          spreadRadius: 6,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Circular progress beads border
                        SizedBox(
                          width: 235,
                          height: 235,
                          child: CircularProgressIndicator(
                            value: _count / 108,
                            strokeWidth: 8,
                            backgroundColor: Colors.white.withValues(alpha: 0.15),
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentGold),
                          ),
                        ),

                        // Center content
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'मनका',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$_count',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 62,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1,
                              ),
                            ),
                            const Text(
                              '/ 108',
                              style: TextStyle(
                                color: AppColors.accentGold,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'स्पर्श करें (Tap)',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Instructions / Devotional guidance
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.bgDarkCard : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.primaryTeal, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'प्रत्येक मंत्र उच्चारण के उपरांत चक्र पर स्पर्श करें। 108 मनके पूर्ण होने पर माला की गणना स्वतः जुड़ जाएगी।',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: isDark ? AppColors.textDarkSecondary : AppColors.textMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AdBannerWidget(),
    );
  }

  Widget _buildStatBadge({
    required String label,
    required String value,
    required IconData icon,
    required bool isDark,
  }) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDarkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primarySaffron, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? AppColors.textDarkSecondary : AppColors.textMedium,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryMaroon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
