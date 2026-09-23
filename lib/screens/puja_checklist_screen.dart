import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/ad_banner_widget.dart';
import '../widgets/item_avatar.dart';
import 'puja_vidhi_screen.dart';

class PujaChecklistScreen extends StatelessWidget {
  const PujaChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final festival = appState.selectedFestival;
    final isDark = appState.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('पूजा सामग्री चेकलिस्ट'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note_rounded, size: 26),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('सामग्री सूची संपादन मोड सक्रिय है'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Festival Header Card
                  _buildFestivalHeaderCard(festival, isDark),
                  const SizedBox(height: 18),

                  // "आवश्यक सामग्री" section title
                  const Text(
                    'आवश्यक सामग्री',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Checklist items list
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: appState.checklist.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = appState.checklist[index];
                      return _buildChecklistItem(context, item, appState, isDark);
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Ad Banner + Bottom Sticky Bar
          const AdBannerWidget(),
          _buildBottomStickyBar(context, appState, isDark),
        ],
      ),
    );
  }

  Widget _buildFestivalHeaderCard(dynamic festival, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDarkCard : const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFF3E5D4),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Circular Avatar badge
          ClipOval(
            child: Image.asset(
              festival.id == 'shivratri'
                  ? 'assets/images/shiva_avatar.jpg'
                  : festival.imageAsset,
              width: 58,
              height: 58,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  festival.nameHindi,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  festival.fullDateHindi,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.textDarkSecondary : AppColors.textMedium,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'पूजा सामग्री की पूरी लिस्ट को टिक करें',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFC0392B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(
    BuildContext context,
    dynamic item,
    AppState appState,
    bool isDark,
  ) {
    final isChecked = item.isPurchased;

    return InkWell(
      onTap: () => appState.toggleItemPurchased(item.id),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? AppColors.bgDarkCard : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? AppColors.borderDark : const Color(0xFFEFE6D8),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Checkbox icon
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isChecked ? AppColors.primaryTeal : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isChecked ? AppColors.primaryTeal : const Color(0xFFBDB2A5),
                  width: 1.6,
                ),
              ),
              child: isChecked
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 14),

            // Item Thumbnail
            ItemAvatar(
              itemId: item.id,
              imageAsset: item.imageAsset,
              size: 42,
            ),
            const SizedBox(width: 14),

            // Name
            Expanded(
              child: Text(
                item.nameHindi,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                  color: isChecked
                      ? (isDark ? AppColors.textDarkSecondary : AppColors.textMuted)
                      : (isDark ? AppColors.textDarkPrimary : AppColors.textDark),
                ),
              ),
            ),

            // Quantity
            Text(
              item.quantity,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.textDarkSecondary : AppColors.textMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomStickyBar(BuildContext context, AppState appState, bool isDark) {
    final purchased = appState.purchasedCount;
    final total = appState.totalCount;
    final progress = total > 0 ? (purchased / total) : 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDarkCard : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : const Color(0xFFEFE6D8),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Left progress info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'सभी सामग्री खरीद ली गई?',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            backgroundColor: const Color(0xFFE0DDD5),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.primaryTeal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$purchased / $total',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryTeal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Right CTA button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PujaVidhiScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryTeal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'पूजा विधि पर जाएं',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, size: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
