import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

/// Off-Market Advisor consultation card matching native Android OffMarketAdvisorCard.kt.
class OffMarketAdvisorCard extends StatelessWidget {
  final VoidCallback onConsultClick;

  const OffMarketAdvisorCard({
    super.key,
    required this.onConsultClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Agent Avatar
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/agent.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.primary,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Title
          const Text(
            'Looking for off-market estates?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 6),

          // Description
          const Text(
            'Your dedicated Verdant Private Advisor is curating 4 unlisted private parcels matching your criteria.',
            style: TextStyle(
              fontSize: 12,
              height: 1.42,
              color: AppColors.outline,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // CTA Button: "Consult Private Advisor"
          FractionallySizedBox(
            widthFactor: 0.85,
            child: SizedBox(
              height: 46,
              child: ElevatedButton(
                onPressed: onConsultClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkFabBg,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Consult Private Advisor',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
