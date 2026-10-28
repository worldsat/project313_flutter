import 'package:flutter/material.dart';
import '../../../models/estate.dart';
import '../../../theme/app_colors.dart';
import 'spec_pill.dart';

class PopularSectionHeader extends StatelessWidget {
  final VoidCallback onViewAllClick;

  const PopularSectionHeader({
    super.key,
    required this.onViewAllClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular Near You',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: AppColors.onSurface,
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'High-demand properties across Central Texas',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.outline,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onViewAllClick,
            behavior: HitTestBehavior.opaque,
            child: const Row(
              children: [
                Text(
                  'View all',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PopularEstateCard extends StatelessWidget {
  final Estate estate;
  final bool isSaved;
  final ValueChanged<String> onEstateClick;
  final ValueChanged<String> onToggleSave;

  const PopularEstateCard({
    super.key,
    required this.estate,
    required this.isSaved,
    required this.onEstateClick,
    required this.onToggleSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () => onEstateClick(estate.id),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.outlineVariant.withOpacity(0.4),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with Badges & Carousel Dots
              SizedBox(
                height: 220,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      estate.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.surfaceVariant,
                        child: const Icon(
                          Icons.apartment,
                          size: 48,
                          color: AppColors.outline,
                        ),
                      ),
                    ),

                    // Top-Left Badges Row
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Row(
                        children: [
                          if (estate.statusTag != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                estate.statusTag!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                          ],
                          if (estate.areaTag != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                estate.areaTag!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Top-Right Wishlist Heart Button
                    Positioned(
                      top: 14,
                      right: 14,
                      child: GestureDetector(
                        onTap: () => onToggleSave(estate.id),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.88),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            isSaved
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isSaved
                                ? const Color(0xFFD32F2F)
                                : AppColors.onSurface,
                            size: 18,
                          ),
                        ),
                      ),
                    ),

                    // Bottom Center Carousel Dots Indicator
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(estate.photoCount, (index) {
                          final isActive = index == estate.activePhotoIndex;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            width: isActive ? 16 : 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              // Details below image
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          estate.formattedPrice,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: AppColors.onSurface,
                          ),
                        ),
                        Text(
                          estate.estimatedMonthly,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.outline,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Title
                    Text(
                      estate.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 3),

                    // Address
                    Text(
                      estate.address,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.outline,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Spec Pills
                    Row(
                      children: [
                        if (estate.beds != null)
                          SpecPill(
                            icon: Icons.single_bed_outlined,
                            text: '${estate.beds} Beds',
                          ),
                        if (estate.beds != null) const SizedBox(width: 8),
                        if (estate.baths != null)
                          SpecPill(
                            icon: Icons.bathtub_outlined,
                            text: '${estate.baths} Baths',
                          ),
                        if (estate.baths != null) const SizedBox(width: 8),
                        if (estate.sqft != null)
                          SpecPill(
                            icon: Icons.square_foot_outlined,
                            text: '${estate.sqft} sqft',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

