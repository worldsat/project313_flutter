import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../main_scaffold.dart';
import 'components/intro_bottom_card.dart';
import 'components/intro_hero_visual.dart';
import 'components/intro_top_bar.dart';

/// Data class representing a curated intro slide highlight
class _IntroSlideData {
  final int curatedCount;
  final String leedRating;
  final String reserveCategory;
  final String reserveTitle;
  final String headline;
  final String description;

  const _IntroSlideData({
    required this.curatedCount,
    required this.leedRating,
    required this.reserveCategory,
    required this.reserveTitle,
    required this.headline,
    required this.description,
  });
}

/// VerdantIntroScreen: Pixel-perfect replica of native Android Compose VerdantIntroScreen.kt
/// Featuring deep evergreen gradient, radar rings, topographic contours, architectural emblem,
/// satellite badges, floating bottom card, and luxury typography.
class VerdantIntroScreen extends StatefulWidget {
  const VerdantIntroScreen({super.key});

  @override
  State<VerdantIntroScreen> createState() => _VerdantIntroScreenState();
}

class _VerdantIntroScreenState extends State<VerdantIntroScreen> {
  int _currentSlideIndex = 0;

  static const List<_IntroSlideData> _slides = [
    _IntroSlideData(
      curatedCount: 42,
      leedRating: 'LEED Platinum',
      reserveCategory: 'PRIVATE RESERVE',
      reserveTitle: 'Austin Enclaves',
      headline: "Discover Nature's Most\nRefined Living",
      description:
          'Immerse yourself in handpicked eco-luxury estates, architectural sanctuaries, and off-market Austin reserves designed in harmony with nature.',
    ),
    _IntroSlideData(
      curatedCount: 28,
      leedRating: 'Net-Zero Ready',
      reserveCategory: 'LAKEFRONT COLLECTION',
      reserveTitle: 'Lake Austin Sanctuaries',
      headline: 'Organic Modernism Along\nScenic Bluffs',
      description:
          'Panoramic waterside estates crafted from native Texas limestone, cantilevered glass walls, and regenerative geothermal microgrids.',
    ),
    _IntroSlideData(
      curatedCount: 15,
      leedRating: 'Living Building',
      reserveCategory: 'HILL COUNTRY ESTATES',
      reserveTitle: 'Barton Creek Crest',
      headline: 'Private Woodlands &\nVerdant Horizons',
      description:
          'Secluded modern sanctuaries buffered by protected canopy reserves, rainwater biopools, and private solar micro-grids.',
    ),
  ];

  void _navigateToExplore() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MainScaffold(initialTab: 0),
      ),
    );
  }

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeSlide = _slides[_currentSlideIndex];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.introGradientDark, // 0xFF071B12
              Color(0xFF09281C),
              AppColors.introGradientMid,  // 0xFF143828
              Color(0xFF0A2317),
            ],
            stops: [0.0, 0.35, 0.70, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 1. Top Bar: Frosted "VERDANT ESTATES" badge + "Skip Tour"
                      IntroTopBar(
                        onSkipClick: _navigateToExplore,
                      ),

                      // 2. Central Hero Visual: Concentric Resonant Rings, Squircle Emblem & Satellite Badges
                      GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity != null) {
                            if (details.primaryVelocity! < -200) {
                              // Swipe left -> Next slide
                              setState(() {
                                _currentSlideIndex =
                                    (_currentSlideIndex + 1) % _slides.length;
                              });
                            } else if (details.primaryVelocity! > 200) {
                              // Swipe right -> Prev slide
                              setState(() {
                                _currentSlideIndex =
                                    (_currentSlideIndex - 1 + _slides.length) %
                                        _slides.length;
                              });
                            }
                          }
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: IntroHeroVisual(
                            key: ValueKey<int>(_currentSlideIndex),
                            curatedCount: activeSlide.curatedCount,
                            leedRating: activeSlide.leedRating,
                            reserveCategory: activeSlide.reserveCategory,
                            reserveTitle: activeSlide.reserveTitle,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // 3. Floating Bottom Content Card
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: IntroBottomCard(
                          key: ValueKey<int>(_currentSlideIndex),
                          currentSlideIndex: _currentSlideIndex,
                          totalSlidesCount: _slides.length,
                          headline: activeSlide.headline,
                          description: activeSlide.description,
                          onExploreClick: _navigateToExplore,
                          onTalkToAdvisorClick: () {
                            _showFeedback(
                                'Connecting with Private Client Advisor Sarah Jenkins...');
                          },
                          onMemberSignInClick: () {
                            _showFeedback(
                                'Private Client Member Portal opening...');
                          },
                          onSlideSelected: (index) {
                            setState(() {
                              _currentSlideIndex = index;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 4. Footer Attribution Tagline
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 12.0,
                          left: 16.0,
                          right: 16.0,
                        ),
                        child: Text(
                          'Verdant Estates™ • Sustainable Luxury Living • Austin, TX',
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 0.3,
                            color: Color(0xFF7FA392),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
