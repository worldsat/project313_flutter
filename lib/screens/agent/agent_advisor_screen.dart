import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_colors.dart';

class AgentAdvisorScreen extends StatelessWidget {
  const AgentAdvisorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Title
              const Text(
                'Private Advisory',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Dedicated bespoke consultation for private estate transactions',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.outline,
                ),
              ),
              const SizedBox(height: 24),

              // Advisor Profile Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.outlineVariant.withOpacity(0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.secondaryContainer,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          MockData.sarahJenkins.avatarAsset,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      MockData.sarahJenkins.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      MockData.sarahJenkins.title,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.outline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      MockData.sarahJenkins.division,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Quick Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Opening secure messaging...'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.chat_bubble_outline_rounded,
                                size: 16),
                            label: const Text('Message'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Calling +1 (512) 840-3130...'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.phone_outlined, size: 16),
                            label: const Text('Call Direct'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.onSurface,
                              side: BorderSide(
                                color:
                                    AppColors.outlineVariant.withOpacity(0.6),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Unlisted Off-Market Parcels Section
              const Text(
                'Exclusive Off-Market Access',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '4 Confidential Portfolios Available',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Access discreet off-market transactions in Westlake, Barton Creek, and Lake Austin before public offering.',
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.45,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
