import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/app_state.dart';
import '../services/sound_service.dart';
import '../theme/app_theme.dart';
import '../data/panchang_2026_data.dart';
import 'puja_checklist_screen.dart';
import 'festival_list_screen.dart';
import 'japa_mala_screen.dart';
import 'chalisa_sangrah_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _ringTempleBell(BuildContext context) {
    SoundService.instance.playTempleBell();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF6B1D11),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: const Row(
          children: [
            Text('🔔', style: TextStyle(fontSize: 22)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'पावन मंदिर घंटी नाद (जय श्री राम)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5, color: Colors.white),
                  ),
                  Text(
                    'मंदिर की पवित्र ध्वनि से मन और घर शुद्ध होता है।',
                    style: TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _blowShankh(BuildContext context) {
    SoundService.instance.playShankh();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF0D4B48),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: const Row(
          children: [
            Text('🐚', style: TextStyle(fontSize: 22)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'पावन शंख ध्वनि (ॐ नाद)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5, color: Colors.white),
                  ),
                  Text(
                    'शंख ध्वनि सकारात्मक ऊर्जा और विजय का प्रतीक है।',
                    style: TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _shareApp(BuildContext context) {
    const shareText =
        '🕉️ *पूजा विधि (Puja Vidhi)* ऐप डाउनलोड करें!\n\n'
        '• सभी हिंदू त्योहारों की संपूर्ण एवं प्रामाणिक पूजा सामग्री\n'
        '• 5-चरणीय सरल विधि एवं पावन आरतियां (ध्वनि सहित)\n'
        '• 100% सटीक दैनिक पंचांग, शुभ मुहूर्त एवं चौघड़िया\n'
        '• 108 मनका डिजिटल जप माला एवं संपूर्ण चालीसा संग्रह\n\n'
        '📲 अभी गूगल प्ले स्टोर से डाउनलोड करें:\n'
        'https://play.google.com/store/apps/details?id=com.apratech.pujavidhi\n\n'
        'जय श्री राम! हर हर महादेव!';

    Share.share(shareText, subject: 'पूजा विधि - संपूर्ण सनातन पूजा एवं पंचांग');
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.isDarkMode;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'मेन्यू',
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primarySaffron.withValues(alpha: 0.35),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/om_logo.jpg',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text('पूजा विधि'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'मंदिर घंटी बजाएं',
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF6B1D11).withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Text('🔔', style: TextStyle(fontSize: 20)),
            ),
            onPressed: () => _ringTempleBell(context),
          ),
          IconButton(
            tooltip: 'पावन शंख बजाएं',
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF0D4B48).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Text('🐚', style: TextStyle(fontSize: 20)),
            ),
            onPressed: () => _blowShankh(context),
          ),
          IconButton(
            tooltip: 'ऐप शेयर करें',
            icon: const Icon(Icons.share_rounded),
            onPressed: () => _shareApp(context),
          ),
        ],
      ),
      drawer: _buildAppDrawer(context, appState),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. "आज का दिन" Divine Hero Card (Replacing Vishesh Parv with Aaj Ka Din)
            _buildAajKaDinCard(context, appState, isDark),
            const SizedBox(height: 16),

            // 2. Daily Shloka / Mantra Card
            _buildDailyMantraCard(context, appState, isDark),
            const SizedBox(height: 14),

            // 2.5 Sacred Instruments Bar (शंख नाद एवं मंदिर घंटी)
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _blowShankh(context),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDark
                              ? [const Color(0xFF1E3533), const Color(0xFF0F2422)]
                              : [const Color(0xFFE4F6F3), const Color(0xFFCCEFE8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF0D4B48).withValues(alpha: 0.3),
                          width: 1.3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0D4B48).withValues(alpha: 0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.85),
                              shape: BoxShape.circle,
                            ),
                            child: const Text('🐚', style: TextStyle(fontSize: 20)),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('पावन शंख', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                                Text('बजाने हेतु दबाएं', style: TextStyle(fontSize: 10.5, color: Color(0xFF0D4B48), fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () => _ringTempleBell(context),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDark
                              ? [const Color(0xFF381F15), const Color(0xFF26120B)]
                              : [const Color(0xFFFFF0EA), const Color(0xFFFFDDCF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF6B1D11).withValues(alpha: 0.3),
                          width: 1.3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6B1D11).withValues(alpha: 0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.85),
                              shape: BoxShape.circle,
                            ),
                            child: const Text('🔔', style: TextStyle(fontSize: 20)),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('मंदिर घंटी', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                                Text('नाद हेतु दबाएं', style: TextStyle(fontSize: 10.5, color: Color(0xFF6B1D11), fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // 3. Spiritual Daily Utilities Bar (जप माला & चालीसा संग्रह)
            Row(
              children: [
                Expanded(
                  child: _buildFeatureActionCard(
                    context: context,
                    title: 'डिजिटल जप माला',
                    subtitle: '108 मनका काउंटर',
                    icon: Icons.circle_outlined,
                    gradient: isDark
                        ? [const Color(0xFF381F15), const Color(0xFF26120B)]
                        : [const Color(0xFFFFECE5), const Color(0xFFFFD5C6)],
                    accentColor: const Color(0xFFC0392B),
                    badge: '108 जप',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const JapaMalaScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildFeatureActionCard(
                    context: context,
                    title: 'पावन चालीसा',
                    subtitle: 'हनुमान, शिव, दुर्गा',
                    icon: Icons.menu_book_rounded,
                    gradient: isDark
                        ? [const Color(0xFF1B2D26), const Color(0xFF10201A)]
                        : [const Color(0xFFE8F6F0), const Color(0xFFD0EFE2)],
                    accentColor: const Color(0xFF0F6E50),
                    badge: 'चालीसा संग्रह',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ChalisaSangrahScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 4. "प्रमुख त्योहार" Header with "सभी देखें ->"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.stars_rounded, color: AppColors.primarySaffron, size: 22),
                    SizedBox(width: 6),
                    Text(
                      'प्रमुख त्योहार एवं पर्व',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const FestivalListScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Row(
                      children: [
                        Text(
                          'सभी देखें',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryMaroon,
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: AppColors.primaryMaroon,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 5. Colorful & Large Festival Grid (2 Columns for rich big visual cards)
            _buildVibrantFestivalGrid(context, appState),
            const SizedBox(height: 20),

            // 6. "आज का पंचांग दर्शन" Expanded Rich Card
            _buildPanchangSummaryCard(context, appState, isDark),
            const SizedBox(height: 26),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
    required Color accentColor,
    required String badge,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withValues(alpha: 0.3),
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: accentColor, size: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAajKaDinCard(BuildContext context, AppState appState, bool isDark) {
    final now = DateTime.now();
    final todayData = Panchang2026Data.getPanchangForDate(now);

    String deityTitle;
    String deitySubtitle;
    String deityImage;

    switch (now.weekday) {
      case DateTime.monday:
        deityTitle = 'सोमवार • भगवान शिव पूजन';
        deitySubtitle = 'ॐ नमः शिवाय • महादेव की कृपा एवं आत्मशांति';
        deityImage = 'assets/images/shiva_avatar.jpg';
        break;
      case DateTime.tuesday:
        deityTitle = 'मंगलवार • श्री हनुमान पूजन';
        deitySubtitle = 'संकट मोचन महाबली हनुमान जी का पावन दिन';
        deityImage = 'assets/images/om_logo.jpg';
        break;
      case DateTime.wednesday:
        deityTitle = 'बुधवार • श्री गणेश पूजन';
        deitySubtitle = 'विघ्नहर्ता गणपति बाप्पा का मंगलमय दिन';
        deityImage = 'assets/images/festival_ganesha.jpg';
        break;
      case DateTime.thursday:
        deityTitle = 'गुरुवार • श्री हरि विष्णु पूजन';
        deitySubtitle = 'ॐ नमो भगवते वासुदेवाय • सुख-समृद्धि एवं ज्ञान';
        deityImage = 'assets/images/festival_satyanarayan.jpg';
        break;
      case DateTime.friday:
        deityTitle = 'शुक्रवार • माँ महालक्ष्मी पूजन';
        deitySubtitle = 'धन-धान्य, ऐश्वर्य एवं सौभाग्य दायिनी माँ';
        deityImage = 'assets/images/festival_deepawali.jpg';
        break;
      case DateTime.saturday:
        deityTitle = 'शनिवार • श्री शनि देव एवं हनुमान पूजन';
        deitySubtitle = 'न्यायप्रिय शनि देव एवं मारुति नंदन आराधना';
        deityImage = 'assets/images/om_logo.jpg';
        break;
      case DateTime.sunday:
      default:
        deityTitle = 'रविवार • भगवान सूर्य देव पूजन';
        deitySubtitle = 'ॐ सूर्याय नमः • तेज, आरोग्य एवं आत्मबल';
        deityImage = 'assets/images/om_logo.jpg';
        break;
    }

    if (todayData.festivalBadge != null && todayData.festivalBadge!.isNotEmpty) {
      deityTitle = '${todayData.dayName} • ${todayData.festivalBadge!}';
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF382318), const Color(0xFF221610)]
              : [const Color(0xFFFFF7ED), const Color(0xFFFDECD8)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xFF5A3E2D) : const Color(0xFFF0D4B8),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: "आज का दिन" Badge + Tithi/Date
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primarySaffron.withValues(alpha: isDark ? 0.25 : 0.18),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primarySaffron.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🕉️', style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 5),
                      Text(
                        'आज का दिन • ${todayData.dayName}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: isDark ? const Color(0xFFFFCC80) : const Color(0xFFB25E00),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  todayData.dateHindi,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : AppColors.textMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Middle Section: Deity Avatar + Deity Title & Daily Panchang highlights
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primarySaffron.withValues(alpha: 0.3),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      deityImage,
                      width: 82,
                      height: 82,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deityTitle,
                        style: const TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        deitySubtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: isDark ? Colors.white70 : AppColors.textMedium,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E2F2D)
                              : AppColors.lightTeal.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${todayData.paksha} • ${todayData.tithi}',
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryTeal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Mini stats bar: Sunrise, Sunset, Abhijit, RahuKaal (Robust 2x2 layout, zero overflow)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.25)
                    : Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.borderDark : const Color(0xFFEFE4D4),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildAajMiniStat(
                          icon: Icons.wb_sunny_rounded,
                          label: 'सूर्योदय',
                          val: todayData.sunrise,
                          color: Colors.amber.shade800,
                          isDark: isDark,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 24,
                        color: isDark ? AppColors.borderDark : const Color(0xFFEFE4D4),
                      ),
                      Expanded(
                        child: _buildAajMiniStat(
                          icon: Icons.wb_twilight_rounded,
                          label: 'सूर्यास्त',
                          val: todayData.sunset,
                          color: Colors.orange.shade700,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 12,
                    thickness: 0.8,
                    color: isDark ? AppColors.borderDark : const Color(0xFFEFE4D4),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAajMiniStat(
                          icon: Icons.check_circle_outline_rounded,
                          label: 'शुभ मुहूर्त',
                          val: todayData.abhijit.split(' - ').first,
                          color: Colors.green.shade700,
                          isDark: isDark,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 24,
                        color: isDark ? AppColors.borderDark : const Color(0xFFEFE4D4),
                      ),
                      Expanded(
                        child: _buildAajMiniStat(
                          icon: Icons.remove_circle_outline_rounded,
                          label: 'राहुकाल',
                          val: todayData.rahuKaal.split(' - ').first,
                          color: Colors.red.shade700,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Footer Button: View full panchang
            InkWell(
              onTap: () {
                appState.setNavIndex(2); // Jump to Panchang Tab
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primaryMaroon,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryMaroon.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month_rounded, size: 16, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      'आज का संपूर्ण पंचांग एवं चौघड़िया देखें',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_rounded, size: 14, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAajMiniStat({
    required IconData icon,
    required String label,
    required String val,
    required Color color,
    required bool isDark,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 6),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : AppColors.textMuted,
                ),
              ),
              Text(
                val,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDailyMantraCard(BuildContext context, AppState appState, bool isDark) {
    final isPlaying = appState.isPlayingMahamantra;
    return InkWell(
      onTap: () {
        appState.speakMahamantra();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF0D4B48),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: Row(
              children: [
                Icon(isPlaying ? Icons.stop_rounded : Icons.volume_up_rounded, color: Colors.white, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isPlaying
                        ? 'महामंत्र वाचन रोका गया।'
                        : 'ॐ नमः शिवाय। महामंत्र वाचन प्रारंभ...',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                  ),
                ),
              ],
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? (isPlaying
                    ? [const Color(0xFF1B3B38), const Color(0xFF0F2624)]
                    : [const Color(0xFF1E2E2D), const Color(0xFF162524)])
                : (isPlaying
                    ? [const Color(0xFFD7F5F0), const Color(0xFFBCEAE1)]
                    : [const Color(0xFFE8F6F4), const Color(0xFFD4EFEA)]),
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPlaying ? AppColors.primaryTeal : (isDark ? const Color(0xFF2E4E4C) : const Color(0xFFB5E2DC)),
            width: isPlaying ? 2.0 : 1.2,
          ),
          boxShadow: isPlaying
              ? [
                  BoxShadow(
                    color: AppColors.primaryTeal.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryTeal.withValues(alpha: isPlaying ? 0.3 : 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPlaying ? Icons.graphic_eq_rounded : Icons.self_improvement_rounded,
                color: AppColors.primaryTeal,
                size: 26,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'आज का महामंत्र',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryTeal,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: AppColors.primaryTeal.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isPlaying ? 'वाचन सक्रिय 🔊' : 'सुनने के लिए टैप करें ▶',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryTeal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'ॐ नमः शिवाय । शुभं करोति कल्याणम् ।',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isPlaying ? Icons.stop_circle_rounded : Icons.volume_up_rounded,
                color: AppColors.primaryTeal,
                size: 28,
              ),
              onPressed: () => appState.speakMahamantra(),
              tooltip: isPlaying ? 'रोकें' : 'महामंत्र सुनें',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVibrantFestivalGrid(BuildContext context, AppState appState) {
    final festivals = appState.festivals.take(6).toList();
    final isDark = appState.isDarkMode;

    final cardThemes = [
      {
        'gradient': [const Color(0xFFFFF7ED), const Color(0xFFFFECD2)],
        'darkGradient': [const Color(0xFF382B22), const Color(0xFF2C1F17)],
        'border': const Color(0xFFF7D9B8),
        'accent': const Color(0xFFC0392B),
      },
      {
        'gradient': [const Color(0xFFFDF2F4), const Color(0xFFFDE0E7)],
        'darkGradient': [const Color(0xFF3A2027), const Color(0xFF2A151B)],
        'border': const Color(0xFFF8B8C8),
        'accent': const Color(0xFFC2185B),
      },
      {
        'gradient': [const Color(0xFFFEFDE8), const Color(0xFFFFF8C5)],
        'darkGradient': [const Color(0xFF38351D), const Color(0xFF2A2814)],
        'border': const Color(0xFFF3E88E),
        'accent': const Color(0xFFD4AC0D),
      },
      {
        'gradient': [const Color(0xFFFFF6ED), const Color(0xFFFFE7D1)],
        'darkGradient': [const Color(0xFF38271C), const Color(0xFF281910)],
        'border': const Color(0xFFF8CDA6),
        'accent': const Color(0xFFE65100),
      },
      {
        'gradient': [const Color(0xFFFBF8E6), const Color(0xFFF7EEBD)],
        'darkGradient': [const Color(0xFF36321C), const Color(0xFF262312)],
        'border': const Color(0xFFECD883),
        'accent': const Color(0xFFB7950B),
      },
      {
        'gradient': [const Color(0xFFFDF5F8), const Color(0xFFFCE3EE)],
        'darkGradient': [const Color(0xFF361F2A), const Color(0xFF25131C)],
        'border': const Color(0xFFF3C0D6),
        'accent': const Color(0xFFAD1457),
      },
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: festivals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 14,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        final festival = festivals[index];
        final theme = cardThemes[index % cardThemes.length];
        final gradientColors = isDark
            ? (theme['darkGradient'] as List<Color>)
            : (theme['gradient'] as List<Color>);
        final borderColor = isDark ? const Color(0xFF4A3A30) : (theme['border'] as Color);

        return InkWell(
          onTap: () {
            appState.selectFestival(festival);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const PujaChecklistScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(18),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: borderColor, width: 1.4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Prominent Large Icon
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      festival.imageAsset,
                      width: 78,
                      height: 78,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Festival Name
                Text(
                  festival.nameHindi,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),

                // Date Chip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: (theme['accent'] as Color).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    festival.dateHindi,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: theme['accent'] as Color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPanchangSummaryCard(BuildContext context, AppState appState, bool isDark) {
    final todayData = Panchang2026Data.getPanchangForDate(DateTime.now());
    return InkWell(
      onTap: () {
        appState.setNavIndex(2); // Switch to Panchang screen
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.bgDarkCard : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark ? AppColors.borderDark : const Color(0xFFEFE4D4),
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primarySaffron.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.wb_sunny_rounded,
                    color: AppColors.primarySaffron,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'आज का पंचांग एवं शुभ मुहूर्त',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${todayData.dayName} • ${todayData.paksha} ${todayData.tithi} (${todayData.nakshatra} नक्षत्र)',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryTeal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.primaryMaroon,
                  size: 26,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFEFE8DC)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _PanchangMiniStat(
                    title: 'सूर्योदय',
                    value: todayData.sunrise,
                    icon: Icons.wb_sunny_outlined,
                  ),
                ),
                Expanded(
                  child: _PanchangMiniStat(
                    title: 'सूर्यास्त',
                    value: todayData.sunset,
                    icon: Icons.wb_twilight_outlined,
                  ),
                ),
                Expanded(
                  child: _PanchangMiniStat(
                    title: 'अभिजीत',
                    value: todayData.abhijit.split(' - ').first,
                    icon: Icons.access_time_rounded,
                  ),
                ),
                Expanded(
                  child: _PanchangMiniStat(
                    title: 'राहुकाल',
                    value: todayData.rahuKaal.split(' - ').first,
                    icon: Icons.block_flipped,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppDrawer(BuildContext context, AppState appState) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Edge-to-Edge Full View Icon Header (Zero overflow)
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2A0802),
                  AppColors.primaryMaroon,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: topPadding),
                // Full View Edge-to-Edge App Icon
                Container(
                  width: double.infinity,
                  color: Colors.black26,
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Image.asset(
                      'assets/images/om_logo.jpg',
                      fit: BoxFit.contain, // Full view icon, nothing cropped or hidden!
                    ),
                  ),
                ),
                // Title and Subtitle Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'पूजा विधि (Puja Vidhi)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primarySaffron.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.primarySaffron, width: 1),
                            ),
                            child: const Text(
                              '॥ ॐ ॥',
                              style: TextStyle(
                                color: AppColors.primarySaffron,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'संपूर्ण सनातन पूजा, पंचांग, चालीसा एवं जप माला',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('होम (मुख्य पृष्ठ)'),
            onTap: () {
              Navigator.pop(context);
              appState.setNavIndex(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.circle_outlined, color: Color(0xFFC0392B)),
            title: const Text('डिजिटल जप माला (108 Japa)'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const JapaMalaScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu_book_rounded, color: Color(0xFF0F6E50)),
            title: const Text('पावन चालीसा संग्रह'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChalisaSangrahScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.self_improvement_outlined),
            title: const Text('पूजा विधि एवं आरती'),
            onTap: () {
              Navigator.pop(context);
              appState.setNavIndex(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text('दैनिक पंचांग व मुहूर्त'),
            onTap: () {
              Navigator.pop(context);
              appState.setNavIndex(2);
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist_outlined),
            title: const Text('सामग्री चेकलिस्ट'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PujaChecklistScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long_outlined),
            title: const Text('मेरी सूची (बुकमार्क)'),
            onTap: () {
              Navigator.pop(context);
              appState.setNavIndex(3);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('सेटिंग्स एवं नियम'),
            onTap: () {
              Navigator.pop(context);
              appState.setNavIndex(4);
            },
          ),
        ],
      ),
    );
  }
}

class _PanchangMiniStat extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _PanchangMiniStat({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 16, color: AppColors.primaryTeal),
        const SizedBox(height: 3),
        Text(
          title,
          style: const TextStyle(fontSize: 10.5, color: AppColors.textMedium, fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
