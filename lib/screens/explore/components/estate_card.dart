import 'package:flutter/material.dart';
import '../../../models/estate.dart';
import '../../../theme/app_colors.dart';
import 'spec_pill.dart';

class EstateCard extends StatelessWidget {
  final Estate estate;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onToggleSave;

  const EstateCard({
    super.key,
    required this.estate,
    required this.isSaved,
    required this.onTap,
    required this.onToggleSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Photo Hero Container
              Stack(
                children: [
                  SizedBox(
                    height: 205,
                    width: double.infinity,
                    child: Image.asset(
                      estate.imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Top Left Badges
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (estate.verifiedLuxury)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.tertiaryContainer,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.shield_outlined,
                                  size: 13,
                                  color: AppColors.onTertiaryContainer,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Verified Luxury',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.onTertiaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else if (estate.statusTag != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryContainer,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              estate.statusTag!,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        if (estate.areaTag != null) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              estate.areaTag!,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Top Right Save Heart Button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: onToggleSave,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.88),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Icon(
                          isSaved
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: isSaved
                              ? const Color(0xFFD32F2F)
                              : AppColors.onSurfaceVariant,
                          size: 19,
                        ),
                      ),
                    ),
                  ),

                  // Rating Pill (Bottom Right Scrim)
                  if (estate.rating != null)
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 14,
                              color: AppColors.starGold,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${estate.rating}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 11.5,
                              ),
                            ),
                            if (estate.reviewCount != null) ...[
                              const SizedBox(width: 3),
                              Text(
                                '(${estate.reviewCount})',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 10.5,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              // 2. Info Details
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
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.onSurface,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          estate.estimatedMonthly,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.outline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Title
                    Text(
                      estate.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Address
                    Row(
                      children: [
                        const Icon(
                          Icons.near_me_outlined,
                          size: 13,
                          color: AppColors.outline,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            estate.address,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.outline,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Specs Pills Row
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        if (estate.beds != null)
                          SpecPill(
                            icon: Icons.bed_outlined,
                            text: '${estate.beds} Beds',
                          ),
                        if (estate.baths != null)
                          SpecPill(
                            icon: Icons.bathtub_outlined,
                            text: '${estate.baths} Baths',
                          ),
                        if (estate.sqft != null)
                          SpecPill(
                            icon: Icons.square_foot_rounded,
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
