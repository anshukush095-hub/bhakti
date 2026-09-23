import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  final bool showBackButton;

  const SettingsScreen({super.key, this.showBackButton = false});

  Future<void> _rateAppOnPlayStore(BuildContext context) async {
    final marketUri = Uri.parse('market://details?id=com.apratech.pujavidhi');
    final webUri = Uri.parse('https://play.google.com/store/apps/details?id=com.apratech.pujavidhi');

    try {
      if (await canLaunchUrl(marketUri)) {
        await launchUrl(marketUri, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Play Store उपलब्ध नहीं है (https://play.google.com/store/apps/details?id=com.apratech.pujavidhi)'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('रेटिंग खोलने में त्रुटि: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _shareAppWithFamily(BuildContext context) async {
    const shareText =
        '🕉️ *पूजा विधि (Puja Vidhi)* ऐप डाउनलोड करें!\n\n'
        '• सभी हिंदू त्योहारों की संपूर्ण एवं प्रामाणिक पूजा सामग्री\n'
        '• 5-चरणीय सरल विधि एवं पावन आरतियां (ध्वनि सहित)\n'
        '• 100% सटीक दैनिक पंचांग, शुभ मुहूर्त एवं चौघड़िया\n'
        '• 108 मनका डिजिटल जप माला एवं संपूर्ण चालीसा संग्रह\n\n'
        '📲 अभी गूगल प्ले स्टोर से डाउनलोड करें:\n'
        'https://play.google.com/store/apps/details?id=com.apratech.pujavidhi\n\n'
        'जय श्री राम! हर हर महादेव!';

    try {
      final box = context.findRenderObject() as RenderBox?;
      await Share.share(
        shareText,
        subject: 'पूजा विधि (Puja Vidhi) - संपूर्ण सनातन पूजा एवं पंचांग',
        sharePositionOrigin: box != null ? box.localToGlobal(Offset.zero) & box.size : null,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('शेयर करने में त्रुटि: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => appState.setNavIndex(0),
              ),
        title: const Text('सेटिंग्स एवं नियम'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. भाषा (केवल हिंदी)
            const Text(
              'भाषा',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: _cardBoxDecoration(isDark),
              child: ListTile(
                leading: const Text('🇮🇳', style: TextStyle(fontSize: 24)),
                title: const Text(
                  'हिंदी',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  'डिफ़ॉल्ट भाषा (सक्रिय)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.primarySaffron : AppColors.primaryTeal,
                  ),
                ),
                trailing: Icon(
                  Icons.check_circle_rounded,
                  color: isDark ? AppColors.primarySaffron : AppColors.primaryTeal,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. आवाज़ (Text-to-Speech) - 10 दिव्य स्वर विकल्प
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'आवाज़ (मंत्र एवं आरती वाचन)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryTeal.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '10 दिव्य स्वर उपलब्ध',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primaryTeal),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              decoration: _cardBoxDecoration(isDark),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // List of 10 Devotional Voices
                  ...AppState.devotionalVoices.map((voice) {
                    final isSelected = voice.id == appState.selectedVoice;
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark ? const Color(0xFF1E3734) : const Color(0xFFE8F6F3))
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.primaryTeal : Colors.transparent,
                          width: 1.2,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        onTap: () => appState.setVoice(voice.id),
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundColor: isSelected
                              ? AppColors.primaryTeal
                              : (isDark ? const Color(0xFF33271F) : const Color(0xFFF3ECE1)),
                          child: Icon(
                            voice.isMale ? Icons.person_rounded : Icons.face_3_rounded,
                            color: isSelected ? Colors.white : AppColors.primaryMaroon,
                            size: 20,
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              voice.title,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                color: isSelected
                                    ? (isDark ? Colors.white : AppColors.primaryTeal)
                                    : (isDark ? Colors.white70 : AppColors.textDark),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppColors.primaryTeal.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                voice.subtitle,
                                style: const TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryTeal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            voice.description,
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white54 : AppColors.textMedium,
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Test/Preview audio button
                            IconButton(
                              icon: const Icon(Icons.play_circle_fill_rounded, color: AppColors.primaryTeal, size: 28),
                              tooltip: 'सुनें (Preview)',
                              onPressed: () => appState.previewVoice(voice.id),
                            ),
                            _buildCustomRadio(isSelected),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Color(0xFFEFE8DC)),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      'आवाज़ की गति (${appState.voiceSpeed.toStringAsFixed(1)}x)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.textDarkSecondary : AppColors.textMedium,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.volume_down_rounded,
                          size: 20,
                          color: isDark ? AppColors.textDarkSecondary : AppColors.textMedium,
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: AppColors.primaryTeal,
                              inactiveTrackColor: const Color(0xFFDDD5C8),
                              thumbColor: AppColors.primaryTeal,
                              trackHeight: 4,
                            ),
                            child: Slider(
                              value: appState.voiceSpeed,
                              min: 0.5,
                              max: 2.0,
                              onChanged: (val) => appState.setVoiceSpeed(val),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.volume_up_rounded,
                          size: 20,
                          color: isDark ? AppColors.textDarkSecondary : AppColors.textMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. ऐप थीम
            const Text(
              'ऐप थीम',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: _cardBoxDecoration(isDark),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => appState.toggleTheme(false),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: !isDark ? const Color(0xFFF3EFE9) : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.wb_sunny_outlined, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'लाइट',
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () => appState.toggleTheme(true),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.bgDark : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.nightlight_round, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'डार्क',
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4. App Sharing & Rating (Direct & Active)
            const Text(
              'ऐप शेयर एवं रेटिंग',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: _cardBoxDecoration(isDark),
              child: Column(
                children: [
                  _buildSettingRow(
                    icon: Icons.star_rate_rounded,
                    iconColor: Colors.amber.shade700,
                    title: 'प्ले स्टोर पर 5 स्टार रेटिंग दें (Rate Us)',
                    subtitle: 'गूगल प्ले स्टोर पर अपनी समीक्षा देकर प्रोत्साहित करें',
                    onTap: () => _rateAppOnPlayStore(context),
                    isDark: isDark,
                  ),
                  Divider(height: 1, color: isDark ? AppColors.borderDark : AppColors.borderSubtle),
                  _buildSettingRow(
                    icon: Icons.share_rounded,
                    iconColor: AppColors.primaryTeal,
                    title: 'मित्रों और परिवार के साथ साझा करें',
                    subtitle: 'व्हाट्सएप एवं सोशल मीडिया पर सनातनी ज्ञान साझा करें',
                    onTap: () => _shareAppWithFamily(context),
                    isDark: isDark,
                  ),
                  Divider(height: 1, color: isDark ? AppColors.borderDark : AppColors.borderSubtle),
                  _buildSettingRow(
                    icon: Icons.info_outline_rounded,
                    title: 'ऐप विवरण एवं बिल्ड',
                    subtitle: 'Puja Vidhi v1.0.0 (Target Android API 36)',
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Puja Vidhi (पूजा विधि)',
                        applicationVersion: '1.0.0+1 (com.apratech.pujavidhi)',
                        applicationIcon: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset('assets/images/om_logo.jpg', width: 48, height: 48),
                        ),
                        applicationLegalese:
                            '© 2026 Apratech. सर्वाधिकार सुरक्षित। Google Play Console स्वीकृत।',
                      );
                    },
                    isDark: isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 5. Google Play Console Compliance & Policies (Clean & Compliant, Developer section removed)
            const Text(
              'कानूनी एवं प्ले स्टोर नियम (Play Store Compliance)',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: _cardBoxDecoration(isDark),
              child: Column(
                children: [
                  _buildSettingRow(
                    icon: Icons.security_rounded,
                    title: 'डेटा सुरक्षा प्रकटीकरण (Data Safety)',
                    subtitle: 'कोई व्यक्तिगत डेटा एकत्र नहीं किया जाता है',
                    onTap: () => _showDataSafetyDialog(context),
                    isDark: isDark,
                  ),
                  Divider(height: 1, color: isDark ? AppColors.borderDark : AppColors.borderSubtle),
                  _buildSettingRow(
                    icon: Icons.privacy_tip_outlined,
                    title: 'गोपनीयता नीति (Privacy Policy)',
                    subtitle: 'Google Play नीतियों के अनुरूप नीति',
                    onTap: () => _showPrivacyPolicyDialog(context),
                    isDark: isDark,
                  ),
                  Divider(height: 1, color: isDark ? AppColors.borderDark : AppColors.borderSubtle),
                  _buildSettingRow(
                    icon: Icons.gavel_rounded,
                    title: 'सेवा की शर्तें (Terms of Service)',
                    subtitle: 'उपयोग की शर्तें और डिस्क्लेमर',
                    onTap: () => _showTermsDialog(context),
                    isDark: isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _showDataSafetyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.security, color: AppColors.primaryTeal),
            SizedBox(width: 8),
            Text('डेटा सुरक्षा प्रकटीकरण', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          ],
        ),
        content: const SingleChildScrollView(
          child: Text(
            'Google Play Console Data Safety घोषणा:\n\n'
            '• कोई डेटा एकत्र नहीं किया जाता: यह ऐप उपयोगकर्ता का कोई भी व्यक्तिगत डेटा (नाम, ईमेल, फोन, स्थान या डिवाइस आईडी) एकत्र या ट्रैक नहीं करता है।\n\n'
            '• कोई डेटा साझा नहीं किया जाता: किसी भी तीसरे पक्ष (Third Party) के साथ कोई डेटा साझा नहीं किया जाता है।\n\n'
            '• पूर्णतः ऑफलाइन संचालन: चेकलिस्ट और सेटिंग्स का डेटा आपके मोबाइल में ही सुरक्षित रहता है।\n\n'
            '• बाल सुरक्षा: यह ऐप सभी आयु वर्ग के लिए सुरक्षित एवं विज्ञापन-मुक्त है।',
            style: TextStyle(fontSize: 13.5, height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('समझ गया', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.privacy_tip, color: AppColors.primaryMaroon),
            SizedBox(width: 8),
            Text('गोपनीयता नीति (Privacy)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          ],
        ),
        content: const SingleChildScrollView(
          child: Text(
            'पूजा विधि (Puja Vidhi) गोपनीयता नीति:\n\n'
            'प्रभावी तिथि: 2026 (Package: com.apratech.pujavidhi)\n\n'
            '1. जानकारी संग्रह:\n'
            'हम आपकी गोपनीयता का पूर्ण सम्मान करते हैं। हमारा ऐप किसी भी प्रकार का व्यक्तिगत डेटा एकत्र नहीं करता है।\n\n'
            '2. अनुमतियाँ:\n'
            'ऐप को किसी संवेदनशील अनुमति (कैमरा, संपर्क, स्थान आदि) की आवश्यकता नहीं है। केवल मंत्र वाचन हेतु टेक्स्ट-टू-स्पीच का उपयोग किया जाता है।\n\n'
            '3. सुरक्षा:\n'
            'आपकी चेकलिस्ट और सेटिंग्स स्थानीय डिवाइस में सुरक्षित रहती हैं।\n\n'
            '4. बाल सुरक्षा:\n'
            'यह ऐप बच्चों और वयस्कों सभी के लिए सुरक्षित है।',
            style: TextStyle(fontSize: 13.5, height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('स्वीकार करें', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('सेवा की शर्तें (Terms of Use)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        content: const SingleChildScrollView(
          child: Text(
            'पूजा विधि (Puja Vidhi) ऐप के उपयोग के नियम:\n\n'
            '1. यह ऐप सनातन हिंदू धर्म के पावन पर्वों, पूजा विधियों, पंचांग एवं आरतियों की धार्मिक जानकारी प्रदान करने के लिए बनाया गया है।\n\n'
            '2. पंचांग एवं मुहूर्त की गणना भारतीय ज्योतिषीय पंचांग परंपरा के आधार पर की गई है।\n\n'
            '3. ऐप की संपूर्ण सामग्री धार्मिक आस्था एवं ज्ञानवर्धन हेतु है।',
            style: TextStyle(fontSize: 13.5, height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('ठीक है', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardBoxDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark ? AppColors.bgDarkCard : Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
        width: 1,
      ),
    );
  }


  Widget _buildCustomRadio(bool isSelected) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primaryTeal : const Color(0xFFBDB2A5),
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryTeal,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildSettingRow({
    required IconData icon,
    Color? iconColor,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 22,
        color: iconColor ?? (isDark ? AppColors.textDarkSecondary : AppColors.primaryMaroon),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.textDarkSecondary : AppColors.textMedium,
              ),
            )
          : null,
      trailing: Icon(
        Icons.chevron_right,
        size: 20,
        color: isDark ? AppColors.textDarkSecondary : AppColors.textMuted,
      ),
    );
  }
}
