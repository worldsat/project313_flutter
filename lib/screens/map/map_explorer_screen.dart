import 'package:flutter/material.dart';
import '../../controllers/estate_controller.dart';
import '../../data/mock_data.dart';
import '../../theme/app_colors.dart';
import '../detail/estate_detail_screen.dart';
import 'components/architectural_map_canvas.dart';

class MapExplorerScreen extends StatelessWidget {
  final EstateController controller;

  const MapExplorerScreen({
    super.key,
    required this.controller,
  });

  void _openDetail(BuildContext context, String estateId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EstateDetailScreen(
          estateId: estateId,
          controller: controller,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final selectedEstate = controller.selectedMapEstate;

        return Scaffold(
          body: Stack(
            children: [
              // 1. Vector Map Canvas Background
              Positioned.fill(
                child: ArchitecturalMapCanvas(
                  pins: MockData.mapPins,
                  selectedEstateId: controller.selectedMapEstateId,
                  onPinSelected: (id) => controller.selectMapEstate(id),
                ),
              ),

              // 2. Floating Top Search & Filter Bar
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: AppColors.outlineVariant.withOpacity(0.4),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: AppColors.primary,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Search Austin neighborhoods...',
                            style: TextStyle(
                              color: AppColors.outline,
                              fontSize: 13.5,
                            ),
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.layers_outlined,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 3. Bottom Preview Card (Interactive Bottom Sheet Card)
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.outlineVariant.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Drag Handle Indicator
                      Container(
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.outlineVariant,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Card Content
                      Row(
                        children: [
                          // Thumbnail Photo
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              selectedEstate.imageAsset,
                              width: 82,
                              height: 82,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Text Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedEstate.formattedPrice,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.onSurface,
                                      ),
                                    ),
                                    if (selectedEstate.statusTag != null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          selectedEstate.statusTag!,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  selectedEstate.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.onSurface,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  selectedEstate.address,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    color: AppColors.outline,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${selectedEstate.beds ?? 4} Beds • ${selectedEstate.baths ?? 4} Baths • ${selectedEstate.sqft ?? 3900} sqft',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // CTA Button: View Estate
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () =>
                              _openDetail(context, selectedEstate.id),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkFabBg,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Text(
                            'View Estate Details',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
