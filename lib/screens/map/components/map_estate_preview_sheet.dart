import 'package:flutter/material.dart';
import '../../../models/estate.dart';
import '../../../theme/app_colors.dart';

class MapEstatePreviewSheet extends StatelessWidget {
  final Estate estate;
  final bool isSaved;
  final VoidCallback onToggleSave;
  final VoidCallback onDirectionsClick;
  final ValueChanged<String> onViewDetailsClick;

  const MapEstatePreviewSheet({
    super.key,
    required this.estate,
    required this.isSaved,
    required this.onToggleSave,
    required this.onDirectionsClick,
    required this.onViewDetailsClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBF8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.35),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 38,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.outlineVariant,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          const SizedBox(height: 10),

          // Header Row: Featured Reserve badge + Selected on Map + Heart Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified_user_outlined,
                          size: 13,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          estate.statusTag ?? 'Featured Reserve',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Selected on Map',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onToggleSave,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.outlineVariant.withOpacity(0.35),
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    isSaved ? Icons.favorite : Icons.favorite_border,
                    color: isSaved
                        ? const Color(0xFFD32F2F)
                        : AppColors.onSurface,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // White Estate Card
          GestureDetector(
            onTap: () => onViewDetailsClick(estate.id),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.outlineVariant.withOpacity(0.35),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Property Thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Stack(
                      children: [
                        Image.asset(
                          estate.imageAsset,
                          width: 100,
                          height: 92,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 100,
                            height: 92,
                            color: AppColors.surfaceVariant,
                            child: const Icon(
                              Icons.apartment,
                              color: AppColors.outline,
                              size: 32,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          left: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '16:10 Arch',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Details Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          estate.formattedPrice,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          estate.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.place_outlined,
                              size: 12,
                              color: AppColors.outline,
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                '${estate.areaTag ?? "Westlake Hills"}, Austin TX',
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: AppColors.outline,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.single_bed_outlined,
                              size: 13,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${estate.beds ?? 4} Beds',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            const Text(
                              ' • ',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.outlineVariant,
                              ),
                            ),
                            const Icon(
                              Icons.bathtub_outlined,
                              size: 13,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${estate.baths ?? 4} Baths',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            const Text(
                              ' • ',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.outlineVariant,
                              ),
                            ),
                            const Icon(
                              Icons.square_foot_outlined,
                              size: 13,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${estate.sqft ?? 4800} sqft',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.onSurfaceVariant,
                              ),
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
          const SizedBox(height: 10),

          // Feature Badges Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildFeatureBadge(
                  icon: Icons.pool_outlined,
                  label: 'Private Infinity Pool',
                  bg: AppColors.surfaceContainerLow,
                  color: AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                _buildFeatureBadge(
                  icon: Icons.solar_power_outlined,
                  label: 'Solar Net-Zero',
                  bg: AppColors.surfaceContainerLow,
                  color: AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                _buildFeatureBadge(
                  icon: Icons.energy_savings_leaf_outlined,
                  label: 'LEED Platinum',
                  bg: AppColors.secondaryContainer,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Action Buttons: Directions & View Details
          Row(
            children: [
              // Directions Button
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: onDirectionsClick,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEBEFEA),
                      foregroundColor: AppColors.onSurface,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_outlined,
                          size: 17,
                          color: AppColors.onSurface,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Directions',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // View Details Button
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => onViewDetailsClick(estate.id),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkFabBg,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View Details',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBadge({
    required IconData icon,
    required String label,
    required Color bg,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
