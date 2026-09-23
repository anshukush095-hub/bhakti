import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/app_state.dart';
import '../services/ad_service.dart';
import '../theme/app_theme.dart';

class PujaVidhiScreen extends StatefulWidget {
  const PujaVidhiScreen({super.key});

  @override
  State<PujaVidhiScreen> createState() => _PujaVidhiScreenState();
}

class _PujaVidhiScreenState extends State<PujaVidhiScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  double _fontScale = 1.0;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  void _shareCurrentStep(AppState appState) {
    final step = appState.currentStep;
    final text =
        '🕉️ *${appState.selectedFestival.nameHindi} - ${step.fullTitle}*\n\n'
        '• विधि: ${step.instruction}\n\n'
        '• पावन मंत्र / आरती:\n${step.mantra}\n\n'
        '🚩 *पूजा विधि (Puja Vidhi)* ऐप डाउनलोड करें:\n'
        'https://play.google.com/store/apps/details?id=com.apratech.pujavidhi';
    Share.share(text, subject: '${appState.selectedFestival.nameHindi} पूजा विधि');
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.isDarkMode;
    final step = appState.currentStep;
    final currentIdx = appState.currentStepIndex;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            appState.stopAudio();
            Navigator.of(context).pop();
          },
        ),
        title: Text('पूजा विधि - ${appState.selectedFestival.nameHindi}'),
        actions: [
          IconButton(
            tooltip: 'फॉन्ट छोटा करें (A-)',
            icon: const Icon(Icons.text_decrease_rounded),
            onPressed: () {
              if (_fontScale > 0.85) setState(() => _fontScale -= 0.1);
            },
          ),
          IconButton(
            tooltip: 'फॉन्ट बड़ा करें (A+)',
            icon: const Icon(Icons.text_increase_rounded),
            onPressed: () {
              if (_fontScale < 1.45) setState(() => _fontScale += 0.1);
            },
          ),
          IconButton(
            tooltip: 'शेयर करें',
            icon: const Icon(Icons.share_rounded),
            onPressed: () => _shareCurrentStep(appState),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Stepper component
            _buildStepper(appState, isDark),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step number and title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'चरण ${step.stepNumber} / ${appState.steps.length}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primarySaffron,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            step.fullTitle,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primarySaffron.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.local_fire_department,
                          color: AppColors.primarySaffron,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Step detailed instructions
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.bgDarkCard : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.instruction,
                          style: TextStyle(
                            fontSize: 15 * _fontScale,
                            fontWeight: FontWeight.w500,
                            height: 1.55,
                            color: isDark ? AppColors.textDarkPrimary : AppColors.textDark,
                          ),
                        ),
                        if (step.mantra.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF2A211D)
                                  : (step.shortTitle == 'आरती'
                                      ? const Color(0xFFFFF6EE)
                                      : const Color(0xFFFFFBF0)),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: step.shortTitle == 'आरती'
                                    ? const Color(0xFFF5CBA7)
                                    : const Color(0xFFF3E1B9),
                                width: 1.2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (step.shortTitle == 'आरती') ...[
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.local_fire_department,
                                        color: Color(0xFFC0392B),
                                        size: 16,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'पावन आरती संग्रह',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFFC0392B),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                ],
                                Text(
                                  step.mantra,
                                  style: TextStyle(
                                    fontSize: (step.shortTitle == 'आरती' ? 14.5 : 14.0) * _fontScale,
                                    fontStyle: step.shortTitle == 'आरती'
                                        ? FontStyle.normal
                                        : FontStyle.italic,
                                    fontWeight: step.shortTitle == 'आरती'
                                        ? FontWeight.w600
                                        : FontWeight.w600,
                                    height: 1.55,
                                    color: step.shortTitle == 'आरती'
                                        ? (isDark ? const Color(0xFFFFD59E) : const Color(0xFF7A2E00))
                                        : const Color(0xFF8B4513),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Audio Card with Play Button & Waveform
                  _buildAudioPlayerCard(appState, step, isDark),
                  const SizedBox(height: 20),

                  // Prev / Next Navigation Buttons
                  Row(
                    children: [
                      // Prev Button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: currentIdx > 0
                              ? () => appState.previousStep()
                              : null,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: isDark ? Colors.white : AppColors.textDark,
                            side: BorderSide(
                              color: isDark ? AppColors.borderDark : const Color(0xFFD4CDC2),
                              width: 1.2,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chevron_left, size: 20),
                              SizedBox(width: 4),
                              Text(
                                'पिछला',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Next Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: currentIdx < appState.steps.length - 1
                              ? () => appState.nextStep()
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${appState.selectedFestival.nameHindi} की सम्पूर्ण पूजा विधि संपन्न हुई!'),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  AdService.instance.showMilestoneInterstitial();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryTeal,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currentIdx < appState.steps.length - 1
                                    ? 'अगला'
                                    : 'पूजा समाप्त',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_forward, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Bottom Deity Artwork
                  Center(
                    child: Container(
                      height: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        appState.selectedFestival.imageAsset,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper(AppState appState, bool isDark) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(appState.steps.length, (index) {
          final isCompleted = index < appState.currentStepIndex;
          final isCurrent = index == appState.currentStepIndex;
          final stepItem = appState.steps[index];

          return GestureDetector(
            onTap: () => appState.goToStep(index),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: (isCurrent || isCompleted)
                            ? AppColors.primaryTeal
                            : (isDark ? AppColors.bgDarkCard : const Color(0xFFEDE6DA)),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: (isCurrent || isCompleted)
                              ? AppColors.primaryTeal
                              : (isDark ? AppColors.borderDark : const Color(0xFFDCD4C7)),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: isCompleted
                            ? const Icon(Icons.check, size: 18, color: Colors.white)
                            : Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isCurrent
                                      ? Colors.white
                                      : (isDark ? Colors.white70 : AppColors.textMedium),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stepItem.shortTitle,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                        color: isCurrent
                            ? AppColors.primaryTeal
                            : (isDark ? AppColors.textDarkSecondary : AppColors.textMedium),
                      ),
                    ),
                  ],
                ),
                if (index < appState.steps.length - 1)
                  Container(
                    width: 30,
                    height: 2,
                    margin: const EdgeInsets.only(bottom: 16, left: 4, right: 4),
                    color: index < appState.currentStepIndex
                        ? AppColors.primaryTeal
                        : (isDark ? AppColors.borderDark : const Color(0xFFE2DAD0)),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAudioPlayerCard(AppState appState, dynamic step, bool isDark) {
    final isPlaying = appState.isPlayingAudio;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2F2E) : const Color(0xFFEDF7F6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF2C4C4A) : const Color(0xFFC7E7E5),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          // Play/Pause Button
          InkWell(
            onTap: () => appState.toggleAudio(),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.primaryTeal,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Waveform & Audio Label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated Waveform Bars
                AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return SizedBox(
                      height: 20,
                      child: Row(
                        children: List.generate(24, (barIdx) {
                          final h = isPlaying
                              ? (8 + 12 * ((barIdx * 0.2 + _waveController.value * 3) % 1.0))
                              : (4 + (barIdx % 3) * 4).toDouble();
                          return Container(
                            width: 3,
                            height: h,
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                            decoration: BoxDecoration(
                              color: AppColors.primaryTeal.withValues(
                                alpha: isPlaying ? 0.9 : 0.4,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  step.audioLabel,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryTeal,
                  ),
                ),
              ],
            ),
          ),

          // Speaker Icon
          IconButton(
            icon: Icon(
              isPlaying ? Icons.volume_up : Icons.volume_down_outlined,
              color: AppColors.primaryTeal,
              size: 22,
            ),
            onPressed: () => appState.toggleAudio(),
          ),
        ],
      ),
    );
  }
}
