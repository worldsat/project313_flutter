import 'package:flutter/material.dart';
import '../../../models/estate.dart';
import '../../../theme/app_colors.dart';

/// Parallax hero header with edge-to-edge photography, navigation controls (Back, Save, Share),
/// and bottom status badges (Verified Luxury, Rating & Review Count).
/// Matches native Android Jetpack Compose DetailHeroHeader.kt.
class DetailHeroHeader extends StatelessWidget {
  final Estate estate;
  final bool isSaved;
  final VoidCallback onBackClick;
  final VoidCallback onToggleSave;
  final VoidCallback onShareClick;

  const DetailHeroHeader({
    super.key,
    required this.estate,
    required this.isSaved,
    required this.onBackClick,
    required this.onToggleSave,
    required this.onShareClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Hero Image
          Image.asset(
            estate.imageAsset,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppColors.primaryContainer,
              alignment: Alignment.center,
              child: const Icon(
                Icons.image_not_supported_outlined,
                color: Colors.white70,
                size: 48,
              ),
            ),
          ),

          // 2. Top Gradient Scrim for Controls
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 110,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.55),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 3. Bottom Gradient Scrim for Contrast
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.60),
                  ],
                ),
              ),
            ),
          ),

          // 4. Navigation & Action Controls Row
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Rounded Back Arrow Button
                _CircleBlurButton(
                  icon: Icons.arrow_back_rounded,
                  iconSize: 20,
                  tooltip: 'Navigate Back',
                  onTap: onBackClick,
                ),

                // Bookmark and Share Action Buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _CircleBlurButton(
                      icon: isSaved
                          ? Icons.favorite
                          : Icons.favorite_border_rounded,
                      iconColor: isSaved
                          ? const Color(0xFFD32F2F)
                          : AppColors.onSurface,
                      iconSize: 20,
                      tooltip: 'Save Estate',
                      onTap: onToggleSave,
                    ),
                    const SizedBox(width: 10),
                    _CircleBlurButton(
                      icon: Icons.share_outlined,
                      iconSize: 20,
                      tooltip: 'Share Estate',
                      onTap: onShareClick,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 5. Bottom Hero Badges Row
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Verified Luxury Pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF4EC).withOpacity(0.94),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        color: Color(0xFFAC7740),
                        size: 15,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Verified Luxury',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xFF6B4720),
                        ),
                      ),
                    ],
                  ),
                ),

                // Right: Rating Pill
                if (estate.rating != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.starGold,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${estate.rating}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        if (estate.reviewCount != null) ...[
                          const SizedBox(width: 4),
                          Text(
                            '(${estate.reviewCount})',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ],
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

class _CircleBlurButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final String tooltip;
  final VoidCallback onTap;

  const _CircleBlurButton({
    required this.icon,
    this.iconColor = AppColors.onSurface,
    this.iconSize = 20,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.88),
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.15),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

