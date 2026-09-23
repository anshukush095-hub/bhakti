import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class PujaBottomNavBar extends StatelessWidget {
  const PujaBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.isDarkMode;
    final selectedColor = isDark ? AppColors.primarySaffron : AppColors.primaryMaroon;
    final unselectedColor = isDark ? AppColors.textDarkSecondary : AppColors.textMedium;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDarkCard : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                index: 0,
                icon: Icons.home_rounded,
                label: 'होम',
                isSelected: appState.currentNavIndex == 0,
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
              _buildNavItem(
                context,
                index: 1,
                icon: Icons.self_improvement_rounded,
                label: 'पूजा विधि',
                isSelected: appState.currentNavIndex == 1,
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
              _buildNavItem(
                context,
                index: 2,
                icon: Icons.calendar_month_rounded,
                label: 'पंचांग',
                isSelected: appState.currentNavIndex == 2,
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
              _buildNavItem(
                context,
                index: 3,
                icon: Icons.receipt_long_rounded,
                label: 'मेरी सूची',
                isSelected: appState.currentNavIndex == 3,
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
              _buildNavItem(
                context,
                index: 4,
                icon: Icons.settings_rounded,
                label: 'सेटिंग्स',
                isSelected: appState.currentNavIndex == 4,
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    return InkWell(
      onTap: () {
        Provider.of<AppState>(context, listen: false).setNavIndex(index);
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? selectedColor : unselectedColor,
              size: 24,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? selectedColor : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
