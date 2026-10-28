import 'package:flutter/material.dart';
import '../../../models/estate.dart';
import '../../../theme/app_colors.dart';
import '../../explore/components/spec_pill.dart';

/// Card for saved estates with status badges, price strike-through, spec pills,
/// and action buttons (Book Tour / Backup Offer, Share, Notes).
/// Matches native Android Jetpack Compose SavedEstateCard.kt.
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
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Hero Photo with Badges
              SizedBox(
                height: 205,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      estate.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.surfaceContainer,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.outline,
                          size: 32,
                        ),
                      ),
                    ),

                    // Top-Left Badges Stack
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Price Drop Badge (Peach)
                          if (estate.priceDropNotice != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.ecoPillContainer,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                estate.priceDropNotice!,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.ecoPillText,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                          ],

                          // Open House Badge (Evergreen)
                          if (estate.openHouseNotice != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
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
                            const SizedBox(height: 6),
                          ],

                          // Availability Badge
                          if (estate.availabilityTag != null) ...[
                            _buildAvailabilityBadge(estate.availabilityTag!),
                          ],
                        ],
                      ),
                    ),

                    // Top-Right Favorite Heart (Always Red when saved)
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
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.favorite,
                            color: Color(0xFFD32F2F),
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Estate Details Below Image
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price Row (Current + Original Strikethrough)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          estate.formattedPrice,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        if (estate.originalPrice != null)
                          Text(
                            estate.originalPrice!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.outline,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Title
                    Text(
                      estate.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),

                    const SizedBox(height: 3),

                    // Address
                    Row(
                      children: [
                        const Icon(
                          Icons.near_me_outlined,
                          size: 12,
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

                    // Spec Pills Row
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

                    const SizedBox(height: 14),

                    // Action Buttons Row: "Book Tour" / "Backup Offer" + Share + Notes
                    Row(
                      children: [
                        // Primary Action: "Book Tour" or "Backup Offer"
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: estate.isUnderContract
                                ? Material(
                                    color: const Color(0xFFEBEFEA),
                                    borderRadius: BorderRadius.circular(50),
                                    child: InkWell(
                                      onTap: onBookTour,
                                      borderRadius: BorderRadius.circular(50),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.description_outlined,
                                            size: 16,
                                            color: AppColors.onSurface,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            'Backup Offer',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.onSurface,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: onBookTour,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.darkFabBg,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          'Book Tour',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Share Button
                        _ActionCircleButton(
                          icon: Icons.share_outlined,
                          iconSize: 18,
                          tooltip: 'Share',
                          onTap: onShare,
                        ),

                        const SizedBox(width: 8),

                        // Notes Button
                        _ActionCircleButton(
                          icon: Icons.edit_note_rounded,
                          iconSize: 20,
                          tooltip: 'Notes',
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

  Widget _buildAvailabilityBadge(String tag) {
    Color bgColor;
    Color textColor;
    IconData icon;

    switch (tag) {
      case 'Available':
        bgColor = AppColors.secondaryContainer;
        textColor = AppColors.primary;
        icon = Icons.check_circle_outline;
        break;
      case 'New Price':
        bgColor = AppColors.ecoPillContainer;
        textColor = AppColors.ecoPillText;
        icon = Icons.sell_outlined;
        break;
      case 'Under Contract':
      default:
        bgColor = Colors.white.withOpacity(0.95);
        textColor = AppColors.onSurface;
        icon = Icons.description_outlined;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            tag,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCircleButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String tooltip;
  final VoidCallback onTap;

  const _ActionCircleButton({
    required this.icon,
    this.iconSize = 18,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainerLow,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            icon,
            size: iconSize,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
