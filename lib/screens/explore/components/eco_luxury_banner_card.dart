import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class EcoLuxuryBannerCard extends StatelessWidget {
  const EcoLuxuryBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.introGradientDark,
              AppColors.introGradientMid,
              AppColors.introGradientLight,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.introGradientDark.withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Badge: "Net-Zero Certified"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF285640).withOpacity(0.85),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: AppColors.secondaryContainer.withOpacity(0.35),
                  width: 1,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.energy_savings_leaf_outlined,
                    size: 14,
                    color: AppColors.secondaryContainer,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Net-Zero Certified',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: AppColors.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Headline
            const Text(
              'Curated Eco-Luxury Living',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 21,
                color: Colors.white,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 6),

            // Subtitle
            Text(
              'Homes architected with passive solar design, rain harvesting systems, and natural...',
              style: TextStyle(
                fontSize: 13,
                height: 1.35,
                color: AppColors.onPrimaryContainer.withOpacity(0.82),
              ),
            ),
            const SizedBox(height: 18),

            // Stats Row: 100% Solar | A+ Water Efficacy
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.solar_power_outlined,
                        size: 16,
                        color: AppColors.secondaryContainer,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '100% Solar',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Text(
                  '|',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.35),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.water_drop_outlined,
                        size: 16,
                        color: AppColors.secondaryContainer,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'A+ Water Efficacy',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

