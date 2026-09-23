import 'package:flutter/material.dart';

class ItemAvatar extends StatelessWidget {
  final String itemId;
  final String imageAsset;
  final double size;

  const ItemAvatar({
    super.key,
    required this.itemId,
    required this.imageAsset,
    this.size = 46,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFFBF7F0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEFE6D8), width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildItemContent(context),
    );
  }

  Widget _buildItemContent(BuildContext context) {
    switch (itemId) {
      case 'roli':
        return Image.asset(
          'assets/images/item_roli.jpg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildPlaceholder(const Color(0xFFC0392B), Icons.lens),
        );
      case 'akshat':
        return Image.asset(
          'assets/images/item_akshat.jpg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildPlaceholder(const Color(0xFFE5B25D), Icons.grain),
        );
      case 'kalawa':
        return Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [Color(0xFFFFDF79), Color(0xFFE74C3C)],
              radius: 0.8,
            ),
          ),
          child: const Center(
            child: Icon(Icons.fiber_manual_record, color: Color(0xFFFFF2D6), size: 24),
          ),
        );
      case 'belpatra':
        return Container(
          color: const Color(0xFFEAF5EA),
          child: const Center(
            child: Icon(Icons.eco, color: Color(0xFF2E7D32), size: 26),
          ),
        );
      case 'milk':
        return Container(
          color: const Color(0xFFF3F5F7),
          child: const Center(
            child: Icon(Icons.local_drink, color: Color(0xFF90A4AE), size: 24),
          ),
        );
      case 'curd':
        return Container(
          color: const Color(0xFFFFFDF5),
          child: const Center(
            child: Icon(Icons.rice_bowl, color: Color(0xFFB08968), size: 24),
          ),
        );
      case 'honey':
        return Container(
          color: const Color(0xFFFEF9E7),
          child: const Center(
            child: Icon(Icons.water_drop, color: Color(0xFFF39C12), size: 24),
          ),
        );
      case 'modak':
        return Container(
          color: const Color(0xFFFFF8E1),
          child: const Center(
            child: Icon(Icons.bakery_dining, color: Color(0xFFFFA000), size: 26),
          ),
        );
      case 'durva':
        return Container(
          color: const Color(0xFFE8F5E9),
          child: const Center(
            child: Icon(Icons.grass, color: Color(0xFF388E3C), size: 26),
          ),
        );
      case 'chunri':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
            ),
          ),
          child: const Center(
            child: Icon(Icons.dry_cleaning, color: Colors.white, size: 24),
          ),
        );
      case 'lotus':
        return Container(
          color: const Color(0xFFFCE4EC),
          child: const Center(
            child: Icon(Icons.local_florist, color: Color(0xFFE91E63), size: 24),
          ),
        );
      case 'diya':
        return Container(
          color: const Color(0xFFFFF3E0),
          child: const Center(
            child: Icon(Icons.lightbulb_circle, color: Color(0xFFE65100), size: 26),
          ),
        );
      case 'chalni':
        return Container(
          color: const Color(0xFFFFF8E1),
          child: const Center(
            child: Icon(Icons.filter_tilt_shift, color: Color(0xFFF57F17), size: 26),
          ),
        );
      case 'panchamrit':
        return Container(
          color: const Color(0xFFFFFDE7),
          child: const Center(
            child: Icon(Icons.liquor, color: Color(0xFFFBC02D), size: 24),
          ),
        );
      case 'tulsi':
        return Container(
          color: const Color(0xFFE8F8F5),
          child: const Center(
            child: Icon(Icons.park, color: Color(0xFF16A085), size: 24),
          ),
        );
      case 'banana':
        return Container(
          color: const Color(0xFFFFFDE7),
          child: const Center(
            child: Icon(Icons.eco, color: Color(0xFFF1C40F), size: 24),
          ),
        );
      case 'sindoor':
        return Container(
          color: const Color(0xFFFFEBEE),
          child: const Center(
            child: Icon(Icons.circle, color: Color(0xFFD32F2F), size: 22),
          ),
        );
      case 'kapoor':
        return Container(
          color: const Color(0xFFF4F6F7),
          child: const Center(
            child: Icon(Icons.square, color: Color(0xFFBDC3C7), size: 20),
          ),
        );
      default:
        return Container(
          color: const Color(0xFFFFF5EB),
          child: const Center(
            child: Icon(Icons.spa, color: Color(0xFFC0392B), size: 22),
          ),
        );
    }
  }

  Widget _buildPlaceholder(Color color, IconData icon) {
    return Container(
      color: color.withValues(alpha: 0.15),
      child: Center(
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }
}
