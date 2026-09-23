import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ad_service.dart';
import '../theme/app_theme.dart';

class AdBannerWidget extends StatefulWidget {
  final bool showPeacefulPlaceholder;

  const AdBannerWidget({
    super.key,
    this.showPeacefulPlaceholder = true,
  });

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) return;

    final unitId = AdService.bannerAdUnitId;
    if (unitId.isEmpty) return;

    _bannerAd = BannerAd(
      adUnitId: unitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
          if (mounted) {
            setState(() {
              _bannerAd = null;
              _isLoaded = false;
            });
          }
        },
      ),
    );

    _bannerAd!.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      if (!widget.showPeacefulPlaceholder) return const SizedBox.shrink();
      return _buildPeacefulBanner(context);
    }

    if (_isLoaded && _bannerAd != null) {
      return Container(
        width: double.infinity,
        alignment: Alignment.center,
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.bgDark
            : const Color(0xFFFAF6F0),
        child: SizedBox(
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd!),
        ),
      );
    }

    if (widget.showPeacefulPlaceholder) {
      return _buildPeacefulBanner(context);
    }

    return const SizedBox.shrink();
  }

  Widget _buildPeacefulBanner(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      color: isDark ? const Color(0xFF1E1815) : const Color(0xFFFBF4EB),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🌸', style: TextStyle(fontSize: 13)),
          const SizedBox(width: 8),
          Text(
            '॥ ॐ सर्वे भवन्तु सुखिनः सर्वे सन्तु निरामयाः ॥',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.primarySaffron : AppColors.primaryMaroon,
            ),
          ),
          const SizedBox(width: 8),
          const Text('🌸', style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
