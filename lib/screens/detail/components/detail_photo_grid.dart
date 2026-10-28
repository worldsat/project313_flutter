import 'package:flutter/material.dart';
import '../../../models/estate.dart';
import '../../../theme/app_colors.dart';

/// Property Gallery photo showcase grid matching native Android DetailPhotoGrid.kt.
class DetailPhotoGrid extends StatelessWidget {
  final Estate estate;

  const DetailPhotoGrid({
    super.key,
    required this.estate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Gallery Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Property Gallery',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.onSurface,
              ),
            ),
            Text(
              '${estate.photoCount} Photos',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: AppColors.outline,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Main Showcase Tile
        Container(
          width: double.infinity,
          height: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.outlineVariant.withOpacity(0.5),
              width: 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            estate.imageAsset,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppColors.surfaceContainer,
              alignment: Alignment.center,
              child: const Icon(
                Icons.image_outlined,
                color: AppColors.outline,
                size: 36,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Gallery Secondary Row
        Row(
          children: [
            // Perspective Tile 1: South Elevation
            Expanded(
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.outlineVariant.withOpacity(0.4),
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'South Elevation',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Perspective Tile 2: Pavilion Terrace
            Expanded(
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.outlineVariant.withOpacity(0.4),
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Pavilion Terrace',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

