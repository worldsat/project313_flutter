import 'package:flutter/material.dart';
import '../../../models/estate.dart';
import '../../../theme/app_colors.dart';
import 'spec_pill.dart';

class FeaturedEstateSection extends StatelessWidget {
  final Estate estate;
  final bool isSaved;
  final ValueChanged<String> onEstateClick;
  final ValueChanged<String> onToggleSave;

  const FeaturedEstateSection({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'FEATURED ESTATE',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      fontSize: 13,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              const Text(
                'Updated today',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Featured Card
          GestureDetector(
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
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Image Container with Badges
                  SizedBox(
                    height: 230,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          estate.imageAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: AppColors.surfaceVariant,
                            child: const Icon(
                              Icons.apartment,
                              size: 48,
                              color: AppColors.outline,
                            ),
                          ),
                        ),

                        // Top Gradient Scrim
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: 80,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.35),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Bottom Gradient Scrim
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 80,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.45),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Top-Left: "Verified Luxury" Warm Frosted Pill
                        Positioned(
                          top: 14,
                          left: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
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
                                  size: 14,
                                  color: Color(0xFFAC7740),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Verified Luxury',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: Color(0xFF6B4720),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Top-Right: Translucent Wishlist Heart Button
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

                        // Bottom-Left: Rating Pill
                        Positioned(
                          bottom: 14,
                          left: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
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
                                  size: 13,
                                  color: AppColors.starGold,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${estate.rating ?? 4.95}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '(${estate.reviewCount ?? 38} reviews)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Estate Details Below Image
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
                                fontSize: 23,
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
                        const SizedBox(height: 14),

                        // Spec Pills Row
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
        ],
      ),
    );
  }
}

