import 'package:flutter/material.dart';
import '../../../models/estate.dart';
import '../../../theme/app_colors.dart';

/// Property title, area badges, address, guide price, and monthly estimate header.
/// Matches native Android Jetpack Compose DetailPropertyHeader.kt.
class DetailPropertyHeader extends StatelessWidget {
  final Estate estate;

  const DetailPropertyHeader({
    super.key,
    required this.estate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status & Area Tags Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (estate.statusTag != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
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
              const SizedBox(width: 8),
            ],
            if (estate.areaTag != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  estate.areaTag!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ],
        ),

        const SizedBox(height: 10),

        // Estate Title
        Text(
          estate.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            height: 1.25,
            color: AppColors.onSurface,
          ),
        ),

        const SizedBox(height: 6),

        // Address Row
        Row(
          children: [
            const Icon(
              Icons.near_me_outlined,
              size: 14,
              color: AppColors.outline,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                estate.address,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.outline,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Price Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              estate.formattedPrice,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: AppColors.onSurface,
              ),
            ),
            Text(
              estate.estimatedMonthly,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.outline,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

