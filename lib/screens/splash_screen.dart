import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'main_scaffold.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Om Mandala Logo - Prominent & Beautifully Filling the Space (Full Bleed)
            Center(
              child: Container(
                width: 236,
                height: 236,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primarySaffron.withValues(alpha: 0.40),
                      blurRadius: 32,
                      spreadRadius: 8,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.20),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color: AppColors.primarySaffron,
                    width: 3.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(34),
                  child: Image.asset(
                    'assets/images/om_logo.jpg',
                    width: 236,
                    height: 236,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Title "Puja Vidhi"
            const Text(
              'Puja Vidhi',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryMaroon,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            // Subtitle
            const Text(
              'हर पूजा बने आसान,\nहर मन हो प्रसन्न',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B4533),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 16),
            // Bottom illustration of Ganga Ghat and floating puja thali with "शुरू करें ->"
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/splash_bg.jpg',
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                  // Soft subtle top gradient for smooth blending
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFFFAF6F0),
                            const Color(0xFFFAF6F0).withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Floating button "शुरू करें ->"
                  Positioned(
                    bottom: 40,
                    left: 40,
                    right: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const MainScaffold(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryMaroon,
                        foregroundColor: Colors.white,
                        elevation: 6,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'शुरू करें',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
