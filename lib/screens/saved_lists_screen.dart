import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import 'puja_checklist_screen.dart';
import 'puja_vidhi_screen.dart';

class SavedListsScreen extends StatelessWidget {
  final bool showBackButton;

  const SavedListsScreen({super.key, this.showBackButton = false});

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
        title: const Text('मेरी सूची एवं बुकमार्क'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Segmented Control Tabs (सामग्री सूची, विधि बुकमार्क, पंचांग मुहूर्त)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.bgDarkCard : const Color(0xFFEDE7DD),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  _buildTabItem(context, 'सामग्री सूची', 0, appState, isDark),
                  _buildTabItem(context, 'विधि (आरती)', 1, appState, isDark),
                  _buildTabItem(context, 'पंचांग मुहूर्त', 2, appState, isDark),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Distinct Active Content for Each Tab
          Expanded(
            child: _buildCurrentTabContent(context, appState, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentTabContent(BuildContext context, AppState appState, bool isDark) {
    switch (appState.savedListTab) {
      case 0:
        return _buildSamagriTab(context, appState, isDark);
      case 1:
        return _buildVidhiTab(context, appState, isDark);
      case 2:
        return _buildPanchangTab(context, appState, isDark);
      default:
        return _buildSamagriTab(context, appState, isDark);
    }
  }

  // TAB 0: सामग्री सूची (Material Checklists)
  Widget _buildSamagriTab(BuildContext context, AppState appState, bool isDark) {
    final savedFestivals = appState.festivals.where((f) => f.isSaved).toList();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: savedFestivals.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final festival = savedFestivals[index];
        final completed = festival.checklist.where((i) => i.isPurchased).length;
        final total = festival.checklist.length;
        final progress = total > 0 ? (completed / total) : 0.0;

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.bgDarkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppColors.borderDark : const Color(0xFFEFE8DD),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Top row: Avatar, Info, and Trash icon
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      festival.id == 'shivratri'
                          ? 'assets/images/shiva_avatar.jpg'
                          : festival.imageAsset,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          festival.nameHindi,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          festival.dateHindi,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.textDarkSecondary
                                : AppColors.textMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Color(0xFFD9534F),
                      size: 22,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${festival.nameHindi} सामग्री सूची से हटाई गई'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Bottom row: Progress bar, ratio and "चेकलिस्ट खोलें ->"
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 7,
                        backgroundColor: const Color(0xFFE5DFD6),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryTeal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$completed / $total',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryTeal,
                    ),
                  ),
                  const SizedBox(width: 14),
                  InkWell(
                    onTap: () {
                      appState.selectFestival(festival);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PujaChecklistScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryTeal,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'चेकलिस्ट',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 3),
                          Icon(Icons.arrow_forward, size: 13, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // TAB 1: विधि एवं पावन आरती बुकमार्क (Saved Vidhis & Deity Aartis)
  Widget _buildVidhiTab(BuildContext context, AppState appState, bool isDark) {
    final festivals = appState.festivals;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: festivals.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final festival = festivals[index];
        final aartiStep = festival.steps.last;

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.bgDarkCard : const Color(0xFFFFFBF6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppColors.borderDark : const Color(0xFFF0E5D4),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      festival.imageAsset,
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${festival.nameHindi} - संपूर्ण विधि',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          aartiStep.fullTitle,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryMaroon,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.bookmark_rounded, color: AppColors.primarySaffron, size: 24),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF281E19) : const Color(0xFFFFF4EB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  aartiStep.mantra.split('।').first,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8A3B14),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Play Audio Button
                  OutlinedButton.icon(
                    onPressed: () {
                      appState.selectFestival(festival);
                      appState.goToStep(festival.steps.length - 1);
                      appState.toggleAudio();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${festival.nameHindi} की आरती बज रही है...'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.volume_up_rounded, size: 16),
                    label: const Text('आरती सुनें', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryTeal,
                      side: const BorderSide(color: AppColors.primaryTeal),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Read Vidhi Button
                  ElevatedButton(
                    onPressed: () {
                      appState.selectFestival(festival);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PujaVidhiScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryMaroon,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: const Text('विधि पढ़ें', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // TAB 2: सहेजे गए पंचांग व शुभ मुहूर्त (Saved Panchang & Auspicious Muhurats)
  Widget _buildPanchangTab(BuildContext context, AppState appState, bool isDark) {
    final muhurats = [
      {
        'title': 'महाशिवरात्रि निशीथ काल पूजा मुहूर्त',
        'date': '15 फरवरी 2026 (रविवार)',
        'time': '12:09 AM – 01:01 AM',
        'type': 'सर्वश्रेष्ठ शिव पूजा काल',
        'isSuper': true,
      },
      {
        'title': 'चैत्र नवरात्रि घटस्थापना मुहूर्त',
        'date': '19 मार्च 2026 (गुरुवार)',
        'time': '06:25 AM – 10:15 AM',
        'type': 'अमृत चौघड़िया मुहूर्त',
        'isSuper': false,
      },
      {
        'title': 'सत्यनारायण पूर्णिमा कथा मुहूर्त',
        'date': '2 अप्रैल 2026 (गुरुवार)',
        'time': 'शाम 05:15 बजे से रात्रि 08:30 तक',
        'type': 'शुभ वेला',
        'isSuper': false,
      },
      {
        'title': 'दीपावली लक्ष्मी पूजा प्रदोष काल',
        'date': '8 नवंबर 2026 (रविवार)',
        'time': '05:45 PM – 07:42 PM',
        'type': 'स्थिर लग्न मुहूर्त',
        'isSuper': true,
      },
      {
        'title': 'दैनिक अभिजीत मुहूर्त (नित्य शुभ काल)',
        'date': 'प्रतिदिन (सूर्य अनुसार)',
        'time': '12:13 PM – 12:58 PM',
        'type': 'सर्वकार्य सिद्धि',
        'isSuper': false,
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: muhurats.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final m = muhurats[index];
        final isSuper = m['isSuper'] as bool;

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.bgDarkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSuper
                  ? AppColors.primarySaffron
                  : (isDark ? AppColors.borderDark : const Color(0xFFEFE8DD)),
              width: isSuper ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSuper
                      ? AppColors.primarySaffron.withValues(alpha: 0.15)
                      : AppColors.primaryTeal.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSuper ? Icons.wb_sunny_rounded : Icons.access_time_filled_rounded,
                  color: isSuper ? AppColors.primarySaffron : AppColors.primaryTeal,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m['title'] as String,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      m['date'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppColors.textDarkSecondary : AppColors.textMedium,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'समय: ${m['time']}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryMaroon,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onPressed: () {
                  appState.setNavIndex(2); // Jump to Panchang screen
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabItem(
    BuildContext context,
    String label,
    int tabIndex,
    AppState appState,
    bool isDark,
  ) {
    final isSelected = appState.savedListTab == tabIndex;

    return Expanded(
      child: InkWell(
        onTap: () => appState.setSavedListTab(tabIndex),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? AppColors.bgDark : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected
                    ? (isDark ? Colors.white : AppColors.textDark)
                    : (isDark ? AppColors.textDarkSecondary : AppColors.textMedium),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
