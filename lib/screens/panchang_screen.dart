import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/panchang_2026_data.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class PanchangScreen extends StatefulWidget {
  final bool showBackButton;

  const PanchangScreen({super.key, this.showBackButton = false});

  @override
  State<PanchangScreen> createState() => _PanchangScreenState();
}

class _PanchangScreenState extends State<PanchangScreen> {
  // Current selected date in 2026 (Defaults to Mahashivratri: 15 Feb 2026)
  late DateTime _selectedDate;
  late int _selectedMonthIndex; // 0 = Jan, 1 = Feb, ... 11 = Dec
  bool _showCalendarGrid = true;
  int _chaughadiyaTab = 0; // 0 = Day, 1 = Night

  @override
  void initState() {
    super.initState();
    // Initialize to today's date if year 2026, otherwise Mahashivratri 2026 (Feb 15, 2026)
    final now = DateTime.now();
    if (now.year == 2026) {
      _selectedDate = DateTime(2026, now.month, now.day);
      _selectedMonthIndex = now.month - 1;
    } else {
      _selectedDate = DateTime(2026, 2, 15);
      _selectedMonthIndex = 1; // February
    }
  }

  PanchangDayData get _currentData {
    return Panchang2026Data.getPanchangForDate(_selectedDate);
  }

  MonthInfo get _currentMonthInfo {
    return Panchang2026Data.months2026[_selectedMonthIndex];
  }

  void _selectDate(DateTime dt) {
    setState(() {
      _selectedDate = dt;
      _selectedMonthIndex = dt.month - 1;
    });
  }

  void _selectMonth(int monthIdx) {
    setState(() {
      _selectedMonthIndex = monthIdx;
      final targetMonth = monthIdx + 1;
      final totalDays = Panchang2026Data.months2026[monthIdx].totalDays;
      final newDay = _selectedDate.day.clamp(1, totalDays);
      _selectedDate = DateTime(2026, targetMonth, newDay);
    });
  }

  void _stepDay(int delta) {
    final newDate = _selectedDate.add(Duration(days: delta));
    if (newDate.year == 2026) {
      _selectDate(newDate);
    }
  }

  void _goToToday() {
    final now = DateTime.now();
    if (now.year == 2026) {
      _selectDate(DateTime(2026, now.month, now.day));
    } else {
      _selectDate(DateTime(2026, 2, 15)); // Default to Mahashivratri 2026
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.isDarkMode;
    final data = _currentData;
    final monthInfo = _currentMonthInfo;

    return Scaffold(
      appBar: AppBar(
        leading: widget.showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => appState.setNavIndex(0),
              ),
        title: const Text('2026 संपूर्ण पंचांग कैलेंडर'),
        actions: [
          IconButton(
            tooltip: _showCalendarGrid ? 'मासिक ग्रिड छुपाएं' : 'मासिक ग्रिड देखें',
            icon: Icon(_showCalendarGrid ? Icons.calendar_month_rounded : Icons.calendar_today_outlined),
            onPressed: () => setState(() => _showCalendarGrid = !_showCalendarGrid),
          ),
          IconButton(
            tooltip: 'आज का दिन',
            icon: const Icon(Icons.today_rounded),
            onPressed: _goToToday,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. All 12 Months Horizontal Selector Bar (जनवरी से दिसंबर 2026)
            _buildYearMonthsScroll(isDark),
            const SizedBox(height: 10),

            // 2. Month Meta & Hindu Masa Banner (e.g. माघ - फाल्गुन)
            _buildMonthSummaryCard(monthInfo, isDark),
            const SizedBox(height: 10),

            // 3. Interactive Monthly Calendar Grid (if enabled)
            if (_showCalendarGrid) ...[
              _buildMonthlyCalendarGrid(monthInfo, isDark),
              const SizedBox(height: 12),
            ],

            // 4. Date Stepper Navigator ([◀ पिछला दिन] [तारीख] [अगला दिन ▶])
            _buildDateNavigator(data, isDark),
            const SizedBox(height: 14),

            // 5. Hindu Calendar Header (Samvat & Tithi)
            _buildHinduCalendarCard(data, isDark),
            const SizedBox(height: 14),

            // 6. Sun & Moon 4-Card Grid
            Row(
              children: [
                Expanded(
                  child: _buildTimeCard(
                    icon: Icons.wb_sunny_rounded,
                    iconColor: Colors.amber[700]!,
                    title: 'सूर्योदय',
                    time: data.sunrise,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTimeCard(
                    icon: Icons.wb_twilight_rounded,
                    iconColor: Colors.deepOrange[400]!,
                    title: 'सूर्यास्त',
                    time: data.sunset,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTimeCard(
                    icon: Icons.nightlight_round,
                    iconColor: Colors.lightBlue[400]!,
                    title: 'चंद्रोदय',
                    time: data.moonrise,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTimeCard(
                    icon: Icons.bedtime_outlined,
                    iconColor: Colors.blueGrey[300]!,
                    title: 'चंद्रास्त',
                    time: data.moonset,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // 7. Authentic Core Panchang Details (पञ्चाङ्ग के 5 अंग)
            _buildPanchangCoreDetails(data, isDark),
            const SizedBox(height: 18),

            // 8. "शुभ मुहूर्त" & "अशुभ काल (राहुकाल)"
            _buildMuhuratSection(data, isDark),
            const SizedBox(height: 20),

            // 9. Interactive सम्पूर्ण चौघड़िया (Day / Night tabs)
            _buildChaughadiyaSection(data, isDark),
            const SizedBox(height: 20),

            // 10. Month's Key Festivals & Vrats Card
            _buildMonthFestivalsList(monthInfo, isDark),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // 12 Months Horizontal Scroll Chips
  Widget _buildYearMonthsScroll(bool isDark) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: Panchang2026Data.months2026.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final m = Panchang2026Data.months2026[index];
          final isSelected = index == _selectedMonthIndex;
          return InkWell(
            onTap: () => _selectMonth(index),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryMaroon
                    : (isDark ? AppColors.bgDarkCard : Colors.white),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryMaroon
                      : (isDark ? AppColors.borderDark : const Color(0xFFE4D7C8)),
                  width: 1.2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primaryMaroon.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  m.nameHindi,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : (isDark ? Colors.white70 : AppColors.textDark),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Month Meta Banner
  Widget _buildMonthSummaryCard(MonthInfo m, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF261D17) : const Color(0xFFFBF4EB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF4A3425) : const Color(0xFFEADBCE),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.wb_sunny_rounded, color: AppColors.primarySaffron, size: 18),
              const SizedBox(width: 8),
              Text(
                'हिंदू मास: ${m.hinduMonths}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryMaroon,
                ),
              ),
            ],
          ),
          Text(
            'कुल दिन: ${m.totalDays}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white60 : AppColors.textMedium,
            ),
          ),
        ],
      ),
    );
  }

  // 7-Column Calendar Grid for the selected month
  Widget _buildMonthlyCalendarGrid(MonthInfo m, bool isDark) {
    const daysHeader = ['रवि', 'सोम', 'मंगल', 'बुध', 'गुरु', 'शुक्र', 'शनि'];
    final firstDayWeekday = DateTime(2026, m.monthNumber, 1).weekday; // 1=Mon, 7=Sun
    final startOffset = firstDayWeekday == 7 ? 0 : firstDayWeekday; // Sunday = 0

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDarkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEFE6D8),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Weekday Headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: daysHeader.map((d) {
              final isSun = d == 'रवि';
              return Expanded(
                child: Center(
                  child: Text(
                    d,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: isSun ? const Color(0xFFC0392B) : (isDark ? Colors.white60 : AppColors.textMedium),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, color: Color(0xFFEFE8DC)),
          const SizedBox(height: 8),

          // Day Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: startOffset + m.totalDays,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.05,
              crossAxisSpacing: 4,
              mainAxisSpacing: 6,
            ),
            itemBuilder: (context, index) {
              if (index < startOffset) {
                return const SizedBox.shrink(); // Empty space before 1st of month
              }
              final dayNum = index - startOffset + 1;
              final cellDate = DateTime(2026, m.monthNumber, dayNum);
              final isSelected = cellDate.year == _selectedDate.year &&
                  cellDate.month == _selectedDate.month &&
                  cellDate.day == _selectedDate.day;

              final badge = Panchang2026Data.getFestivalBadgeForDay(2026, m.monthNumber, dayNum);
              final isSunday = cellDate.weekday == 7;

              return InkWell(
                onTap: () => _selectDate(cellDate),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryMaroon
                        : (badge != null
                            ? (isDark ? const Color(0xFF382A1C) : const Color(0xFFFFF7EB))
                            : Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryMaroon
                          : (badge != null ? AppColors.primarySaffron.withValues(alpha: 0.5) : Colors.transparent),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$dayNum',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : (isSunday ? const Color(0xFFC0392B) : (isDark ? Colors.white : AppColors.textDark)),
                        ),
                      ),
                      if (badge != null)
                        Text(
                          badge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.amber[200] : AppColors.primaryMaroon,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Date Stepper Navigator
  Widget _buildDateNavigator(PanchangDayData data, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDarkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEFE6D8),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            tooltip: 'पिछला दिन',
            icon: const Icon(Icons.chevron_left_rounded, size: 28),
            onPressed: () => _stepDay(-1),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  data.dateHindi,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryTeal.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    data.tithi,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryTeal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'अगला दिन',
            icon: const Icon(Icons.chevron_right_rounded, size: 28),
            onPressed: () => _stepDay(1),
          ),
        ],
      ),
    );
  }

  Widget _buildHinduCalendarCard(PanchangDayData data, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF3A2B1E), const Color(0xFF281C13)]
              : [const Color(0xFFFFF8EE), const Color(0xFFFDECD4)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF5A412F) : const Color(0xFFEED0B0),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.stars_rounded, color: AppColors.primarySaffron, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  data.samvat,
                  style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            data.special,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: AppColors.primaryMaroon,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'तिथि: ${data.tithi}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : AppColors.textMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDarkCard : const Color(0xFFFFFBF6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEFE6D8),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textDarkSecondary : AppColors.textMedium,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            time,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanchangCoreDetails(PanchangDayData data, bool isDark) {
    final items = [
      {'name': 'नक्षत्र', 'val': data.nakshatra, 'icon': Icons.flare_rounded},
      {'name': 'योग', 'val': data.yoga, 'icon': Icons.all_inclusive_rounded},
      {'name': 'करण', 'val': data.karana, 'icon': Icons.donut_large_rounded},
      {'name': 'पक्ष', 'val': data.paksha, 'icon': Icons.brightness_6_rounded},
      {'name': 'वार', 'val': data.dayName, 'icon': Icons.calendar_today_rounded},
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDarkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEFE7DC),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_stories_rounded, color: AppColors.primaryTeal, size: 20),
              SizedBox(width: 8),
              Text(
                'पञ्चाङ्ग के मुख्य अंग',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map((it) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Icon(it['icon'] as IconData, size: 16, color: AppColors.primarySaffron),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 65,
                    child: Text(
                      it['name'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Text(' :  '),
                  Expanded(
                    child: Text(
                      it['val'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white70 : AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMuhuratSection(PanchangDayData data, bool isDark) {
    return Column(
      children: [
        // Shubh Muhurat Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF263326) : const Color(0xFFF3FAF3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? const Color(0xFF385238) : const Color(0xFFC7E7C7),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.verified_rounded, color: Color(0xFF2E7D32), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'शुभ मुहूर्त (Auspicious Timings)',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildMuhuratRow('अभिजीत मुहूर्त', data.abhijit, isDark),
              _buildMuhuratRow('अमृत काल', data.amrit, isDark),
              _buildMuhuratRow('ब्रह्म मुहूर्त', '05:12 AM – 06:02 AM', isDark),
              _buildMuhuratRow('विजय मुहूर्त', '02:29 PM – 03:15 PM', isDark),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Ashubh Kaal (Rahu Kaal) Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF362424) : const Color(0xFFFDF4F4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? const Color(0xFF5A3636) : const Color(0xFFF4C8C8),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Color(0xFFC0392B), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'अशुभ काल (वर्जित समय)',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFC0392B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildMuhuratRow('राहुकाल (शुभ कार्य वर्जित)', data.rahuKaal, isDark, isWarning: true),
              _buildMuhuratRow('यमगण्ड काल', data.yamaganda, isDark, isWarning: true),
              _buildMuhuratRow('गुलिक काल', '11:10 AM – 12:36 PM', isDark, isWarning: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMuhuratRow(String title, String time, bool isDark, {bool isWarning = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isWarning ? const Color(0xFFC0392B) : (isDark ? Colors.white70 : AppColors.textDark),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isWarning ? const Color(0xFFC0392B) : (isDark ? Colors.white : AppColors.textDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChaughadiyaSection(PanchangDayData data, bool isDark) {
    final list = _chaughadiyaTab == 0 ? data.dayChaughadiya : data.nightChaughadiya;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'सम्पूर्ण सक्रिय चौघड़िया',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: isDark ? AppColors.bgDarkCard : const Color(0xFFEDE7DD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => setState(() => _chaughadiyaTab = 0),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _chaughadiyaTab == 0 ? AppColors.primarySaffron : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '☀️ दिन',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _chaughadiyaTab == 0 ? Colors.white : AppColors.textMedium,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() => _chaughadiyaTab = 1),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _chaughadiyaTab == 1 ? AppColors.primaryTeal : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '🌙 रात',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _chaughadiyaTab == 1 ? Colors.white : AppColors.textMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Grid of 8 active chaughadiya periods
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.3,
          ),
          itemBuilder: (context, index) {
            final item = list[index];
            final name = item['name'] as String;
            final isGood = name == 'अमृत' || name == 'शुभ' || name == 'लाभ';
            final isBad = name == 'रोग' || name == 'काल';

            Color bgColor, txtColor;
            if (isGood) {
              bgColor = AppColors.chaughadiyaShubhBg;
              txtColor = AppColors.chaughadiyaShubhText;
            } else if (isBad) {
              bgColor = AppColors.chaughadiyaRogBg;
              txtColor = AppColors.chaughadiyaRogText;
            } else {
              bgColor = AppColors.chaughadiyaUdvegBg;
              txtColor = AppColors.chaughadiyaUdvegText;
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: txtColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: txtColor,
                        ),
                      ),
                      Text(
                        item['type'] as String,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: txtColor.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    item['time'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: txtColor,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // Month Key Festivals
  Widget _buildMonthFestivalsList(MonthInfo m, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDarkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEFE7DC),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.festival_rounded, color: AppColors.primaryMaroon, size: 20),
              const SizedBox(width: 8),
              Text(
                '${m.nameHindi} के प्रमुख व्रत एवं पर्व',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...m.keyFestivals.map((f) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primarySaffron.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      f['date']!,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryMaroon,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      f['event']!,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
