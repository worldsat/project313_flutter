import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

/// Fixed bottom booking bar with guide price and "Schedule Tour" CTA button.
/// Matches native Android Jetpack Compose DetailBookingBottomBar.kt.
class DetailBookingBottomBar extends StatelessWidget {
  final String formattedPrice;
  final String estimatedMonthly;
  final VoidCallback onBookTourClick;

  const DetailBookingBottomBar({
    super.key,
    required this.formattedPrice,
    required this.estimatedMonthly,
    required this.onBookTourClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.outlineVariant.withOpacity(0.35),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Price & Monthly Estimate
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Guide Price',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.outline,
                    ),
                  ),
                  Text(
                    formattedPrice,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.onSurface,
                    ),
                  ),
                  Text(
                    estimatedMonthly,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.outline,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              // Right: Primary CTA Button (Height 52dp, Pill Shape)
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: onBookTourClick,
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Schedule Tour',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shadowColor: AppColors.primary.withOpacity(0.35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

