import 'package:flutter/material.dart';
import '../../../models/estate.dart';
import '../../../theme/app_colors.dart';

/// Floating specs bar displaying Beds, Baths, Living Space, Lot Size, and Eco Rating.
/// Matches native Android Jetpack Compose DetailSpecsBar.kt.
class DetailSpecsBar extends StatelessWidget {
  final Estate estate;

  const DetailSpecsBar({
    super.key,
    required this.estate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (estate.beds != null) ...[
              _DetailSpecItem(
                icon: Icons.bed_outlined,
                label: 'Beds',
                value: '${estate.beds}',
              ),
              const SizedBox(width: 24),
            ],
            if (estate.baths != null) ...[
              _DetailSpecItem(
                icon: Icons.bathtub_outlined,
                label: 'Baths',
                value: '${estate.baths}',
              ),
              const SizedBox(width: 24),
            ],
            if (estate.sqft != null) ...[
              _DetailSpecItem(
                icon: Icons.square_foot_rounded,
                label: 'Living Space',
                value: '${estate.sqft} sqft',
              ),
              const SizedBox(width: 24),
            ],
            if (estate.acreage != null) ...[
              _DetailSpecItem(
                icon: Icons.landscape_outlined,
                label: 'Lot Size',
                value: estate.acreage!,
              ),
              const SizedBox(width: 24),
            ],
            if (estate.leedRating != null) ...[
              _DetailSpecItem(
                icon: Icons.energy_savings_leaf_outlined,
                label: 'Eco Rating',
                value: estate.leedRating!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailSpecItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailSpecItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: AppColors.onSurface,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.outline,
          ),
        ),
      ],
    );
  }
}

