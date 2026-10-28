import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

/// Narrative text description with Architectural Overview title and eco-feature highlight pills.
/// Matches native Android Jetpack Compose DetailNarrativeSection.kt.
class DetailNarrativeSection extends StatelessWidget {
  final String narrative;

  const DetailNarrativeSection({
    super.key,
    required this.narrative,
  });

  static const List<String> _highlights = [
    'Passive Solar Design',
    'Rainwater Harvesting',
    'Quarried Limestone',
    'Infinity Edge Pool',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Architectural Overview',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.onSurface,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          narrative,
          style: const TextStyle(
            fontSize: 15,
            height: 1.53,
            color: AppColors.onSurfaceVariant,
          ),
        ),

        const SizedBox(height: 14),

        // Architectural Features Wrap
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _highlights.map((highlight) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondaryContainer.withOpacity(0.6),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                highlight,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.primary,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

