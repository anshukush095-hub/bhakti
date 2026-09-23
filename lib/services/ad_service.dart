import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  AdService._();
  static final AdService instance = AdService._();

  bool _isInitialized = false;
  InterstitialAd? _interstitialAd;
  bool _isInterstitialLoading = false;
  DateTime? _lastInterstitialShownTime;

  // Live Production AdMob IDs activated
  static const bool useTestAds = false;

  // Real Production Ad Unit IDs
  static const String _prodBannerAndroid = 'ca-app-pub-4392359096361213/8641763494';
  static const String _prodInterstitialAndroid = 'ca-app-pub-4392359096361213/3776360338';

  // Official Google AdMob Test Ad Unit IDs (Safe for testing and development)
  static const String _testBannerAndroid = 'ca-app-pub-3940256099942544/6300978111';
  static const String _testInterstitialAndroid = 'ca-app-pub-3940256099942544/1033173712';

  static String get bannerAdUnitId {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) return '';
    return useTestAds ? _testBannerAndroid : _prodBannerAndroid;
  }

  static String get interstitialAdUnitId {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) return '';
    return useTestAds ? _testInterstitialAndroid : _prodInterstitialAndroid;
  }

  /// Initialize Mobile Ads SDK safely
  Future<void> initialize() async {
    if (_isInitialized) return;
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      _isInitialized = true;
      return;
    }

    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
      loadInterstitialAd();
    } catch (e) {
      debugPrint('AdService initialization error: $e');
    }
  }

  /// Pre-load next Interstitial Ad
  void loadInterstitialAd() {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) return;
    if (_interstitialAd != null || _isInterstitialLoading) return;

    _isInterstitialLoading = true;
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialLoading = false;
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _interstitialAd = null;
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial failed to load: $error');
          _interstitialAd = null;
          _isInterstitialLoading = false;
        },
      ),
    );
  }

  /// Show Interstitial Ad ONLY at natural milestones (e.g. Puja finished, 108 Japa completed)
  /// Enforces cooldown period (minimum 3 minutes) so user is never distracted or annoyed.
  void showMilestoneInterstitial({VoidCallback? onComplete}) {
    // Check cooldown to protect user experience
    if (_lastInterstitialShownTime != null) {
      final difference = DateTime.now().difference(_lastInterstitialShownTime!);
      if (difference.inSeconds < 180) {
        // Less than 3 minutes since last ad, skip to maintain serenity
        onComplete?.call();
        return;
      }
    }

    if (_interstitialAd != null) {
      _lastInterstitialShownTime = DateTime.now();
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _interstitialAd = null;
          onComplete?.call();
          loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _interstitialAd = null;
          onComplete?.call();
          loadInterstitialAd();
        },
      );
      _interstitialAd!.show();
    } else {
      // Ad not ready or unavailable, proceed smoothly without delaying the user
      onComplete?.call();
      loadInterstitialAd();
    }
  }
}
