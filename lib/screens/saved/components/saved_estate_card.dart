import 'package:flutter/material.dart';
import '../../../models/estate.dart';
import '../../../theme/app_colors.dart';
import '../../explore/components/spec_pill.dart';

class SavedEstateCard extends StatelessWidget {
  final Estate estate;
  final VoidCallback onTap;
  final VoidCallback onToggleSave;
  final VoidCallback onBookTour;
  final VoidCallback onShare;
  final VoidCallback onNotes;

  const SavedEstateCard({
    super.key,
    required this.estate,
    required this.onTap,
    required this.onToggleSave,
    required this.onBookTour,
    required this.onShare,
    required this.onNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.4),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo Header
              Stack(
                children: [
                  SizedBox(
                    height: 205,
                    width: double.infinity,
                    child: Image.asset(
                      estate.imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Top Left Badges Stack
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (estate.priceDropNotice != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.ecoPillContainer,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              estate.priceDropNotice!,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.ecoPillText,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                        if (estate.openHouseNotice != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.darkFabBg,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  estate.openHouseNotice!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                        if (estate.availabilityTag != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: estate.availabilityTag == 'Available'
                                  ? AppColors.secondaryContainer
                                  : estate.availabilityTag == 'New Price'
                                      ? AppColors.ecoPillContainer
                                      : Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  estate.availabilityTag == 'Available'
                                      ? Icons.check_circle_outline
                                      : Icons.description_outlined,
                                  size: 12,
                                  color: estate.availabilityTag == 'Available'
                                      ? AppColors.primary
                                      : estate.availabilityTag == 'New Price'
                                          ? AppColors.ecoPillText
                                          : AppColors.onSurface,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  estate.availabilityTag!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: estate.availabilityTag == 'Available'
                                        ? AppColors.primary
                                        : estate.availabilityTag == 'New Price'
                                            ? AppColors.ecoPillText
                                            : AppColors.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Top Right Favorite Heart (Red Saved Fill)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: onToggleSave,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.88),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Color(0xFFD32F2F),
                          size: 19,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Info & Actions Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price Row with optional Strikethrough
                    Row(
                      children: [
                        Text(
                          estate.formattedPrice,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.onSurface,
                          ),
                        ),
                        if (estate.originalPrice != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            estate.originalPrice!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.outline,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),

                    // Title
                    Text(
                      estate.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Address
                    Row(
                      children: [
                        const Icon(
                          Icons.near_me_outlined,
                          size: 13,
                          color: AppColors.outline,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            estate.address,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.outline,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Specs Pills
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        if (estate.beds != null)
                          SpecPill(
                            icon: Icons.bed_outlined,
                            text: '${estate.beds} Beds',
                          ),
                        if (estate.baths != null)
                          SpecPill(
                            icon: Icons.bathtub_outlined,
                            text: '${estate.baths} Baths',
                          ),
                        if (estate.sqft != null)
                          SpecPill(
                            icon: Icons.square_foot_rounded,
                            text: '${estate.sqft} sqft',
                          ),
                        if (estate.terraceSpec != null)
                          SpecPill(
                            icon: Icons.deck_outlined,
                            text: estate.terraceSpec!,
                          ),
                        if (estate.acreage != null)
                          SpecPill(
                            icon: Icons.landscape_outlined,
                            text: estate.acreage!,
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Action Buttons Row: Book Tour / Backup Offer + Share + Notes
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: ElevatedButton.icon(
                              onPressed: onBookTour,
                              icon: Icon(
                                estate.isUnderContract
                                    ? Icons.description_outlined
                                    : Icons.calendar_month_outlined,
                                size: 16,
                              ),
                              label: Text(
                                estate.isUnderContract
                                    ? 'Backup Offer'
                                    : 'Book Tour',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: estate.isUnderContract
                                    ? const Color(0xFFEBEFEA)
                                    : AppColors.darkFabBg,
                                foregroundColor: estate.isUnderContract
                                    ? AppColors.onSurface
                                    : Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Share Button
                        _ActionCircleButton(
                          icon: Icons.share_outlined,
                          onTap: onShare,
                        ),
                        const SizedBox(width: 8),

                        // Notes Button
                        _ActionCircleButton(
                          icon: Icons.edit_note_rounded,
                          onTap: onNotes,
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
    );
  }
}

class _ActionCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionCircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: AppColors.surfaceContainerLow,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 19,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}
