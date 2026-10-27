import 'dart:ui';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../main_scaffold.dart';

class VerdantIntroScreen extends StatelessWidget {
  const VerdantIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Ambient Background Imagery with Evergreen Gradient Overlay
          Image.asset(
            'assets/architectural_photograph_of_the_glass.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.introGradientDark.withOpacity(0.88),
                  AppColors.introGradientMid.withOpacity(0.70),
                  AppColors.introGradientLight.withOpacity(0.85),
                  AppColors.introGradientDark.withOpacity(0.95),
                ],
                stops: const [0.0, 0.35, 0.70, 1.0],
              ),
            ),
          ),

          // 2. Safe Area Foreground Layout
          SafeArea(
            child: Column(
              children: [
                // Top Brand Badge
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.home_rounded,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Verdant Estates',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: AppColors.secondary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Austin, TX',
                              style: TextStyle(
                                color: AppColors.secondaryContainer,
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Center Glassmorphism Showcase Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.65),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tagline Badge
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryContainer,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Text(
                                    'SUSTAINABLE LUXURY',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.verified_rounded,
                                  color: AppColors.primary,
                                  size: 18,
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),

                            // Main Headline
                            const Text(
                              'Eco-Conscious Luxury Living in Austin',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: AppColors.onSurface,
                                height: 1.25,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Subtext Narrative
                            const Text(
                              'Discover unlisted private estates, net-zero architectural villas, and lakefront sanctuaries curated for refined living.',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.onSurfaceVariant,
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 22),

                            // Main CTA Button
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (_) => const MainScaffold(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                  shadowColor:
                                      AppColors.primary.withOpacity(0.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Explore Curated Estates',
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward_rounded, size: 18),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Bottom Auxiliary Actions Row
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => const MainScaffold(
                                          initialTab: 0,
                                        ),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  child: const Text(
                                    'Sign In to Portfolio',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => const MainScaffold(
                                          initialTab: 3, // Agent tab
                                        ),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  child: const Text(
                                    'Consult Advisor',
                                    style: TextStyle(
                                      color: AppColors.onSurfaceVariant,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Bottom Legal / LEED Certified Badge
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Verified Austin Real Estate • LEED Certified Portfolios',
                    style: TextStyle(
                      color: Color(0xFF8DA99A),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
