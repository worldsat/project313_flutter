import 'package:flutter/material.dart';
import '../../../models/advisor.dart';
import '../../../theme/app_colors.dart';

/// Advisor card with 56dp circular avatar, title/division details,
/// and trailing quick-action buttons (Chat in secondaryContainer & Phone in primary).
/// Matches native Android Jetpack Compose AdvisorCard.kt.
class AdvisorCard extends StatelessWidget {
  final Advisor advisor;
  final VoidCallback onCallClick;
  final VoidCallback onChatClick;

  const AdvisorCard({
    super.key,
    required this.advisor,
    required this.onCallClick,
    required this.onChatClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Avatar (size 56dp)
          ClipOval(
            child: Image.asset(
              advisor.avatarAsset,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Text Column: Name, Role, Division
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  advisor.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  advisor.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  advisor.division,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.outline,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Trailing Actions: Chat and Call
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Chat Button
              Material(
                color: AppColors.secondaryContainer,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: onChatClick,
                  customBorder: const CircleBorder(),
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Phone Call Button
              Material(
                color: AppColors.primary,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: onCallClick,
                  customBorder: const CircleBorder(),
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.phone_outlined,
                      color: Colors.white,
                      size: 18,
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
}

