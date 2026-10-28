import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

/// Floating bottom card with Architectural Excellence pill, progress indicator dots,
/// luxury serif headline, narrative description, "Explore Estates" primary CTA,
/// and secondary actions ("Talk to Advisor" & "Member Sign In").
/// Matches native Android Jetpack Compose IntroBottomCard.kt.
class IntroBottomCard extends StatelessWidget {
  final int currentSlideIndex;
  final int totalSlidesCount;
  final String headline;
  final String description;
  final VoidCallback onExploreClick;
  final VoidCallback onTalkToAdvisorClick;
  final VoidCallback onMemberSignInClick;
  final ValueChanged<int>? onSlideSelected;

  const IntroBottomCard({
    super.key,
    this.currentSlideIndex = 0,
    this.totalSlidesCount = 3,
    this.headline = "Discover Nature's Most\nRefined Living",
    this.description =
        'Immerse yourself in handpicked eco-luxury estates, architectural sanctuaries, and off-market Austin reserves designed in harmony with nature.',
    required this.onExploreClick,
    required this.onTalkToAdvisorClick,
    required this.onMemberSignInClick,
    this.onSlideSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFD6E1DB),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 36,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Row: "ARCHITECTURAL EXCELLENCE" Badge + Stepper Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Architectural Excellence Pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC3D5CA),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: Color(0xFF194935),
                        size: 13,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'ARCHITECTURAL EXCELLENCE',
                        style: TextStyle(
                          color: Color(0xFF194935),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Stepper / Progress Indicators (Active Pill + Inactive Dots)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(totalSlidesCount, (index) {
                    final isActive = index == currentSlideIndex;
                    return GestureDetector(
                      onTap: () => onSlideSelected?.call(index),
                      child: Container(
                        margin: EdgeInsets.only(
                          right: index < totalSlidesCount - 1 ? 5.0 : 0,
                        ),
                        width: isActive ? 22 : 5,
                        height: isActive ? 4 : 5,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primary
                              : const Color(0xFF88D8AC),
                          borderRadius: BorderRadius.circular(50),
                          shape: isActive
                              ? BoxShape.rectangle
                              : BoxShape.rectangle,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // 2. Headline Title (Luxury Serif Typography)
            Text(
              headline,
              style: const TextStyle(
                fontFamily: 'serif',
                fontWeight: FontWeight.bold,
                fontSize: 26,
                height: 1.30,
                color: Color(0xFF132B20),
              ),
            ),

            const SizedBox(height: 10),

            // 3. Narrative Description
            Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                height: 1.46,
                fontWeight: FontWeight.normal,
                color: Color(0xFF456052),
              ),
            ),

            const SizedBox(height: 20),

            // 4. Primary CTA: "Explore Estates ->" Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: onExploreClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: AppColors.primary.withOpacity(0.35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Explore Estates',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // 5. Secondary Actions: "Talk to Advisor" and "Member Sign In"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTalkToAdvisorClick,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 4.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/agent.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Talk to Advisor',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onMemberSignInClick,
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 4.0,
                      ),
                      child: Text(
                        'Member Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
