import 'package:flutter/material.dart';
import '../../controllers/estate_controller.dart';
import '../../data/mock_data.dart';
import '../../theme/app_colors.dart';
import 'components/advisor_card.dart';
import 'components/detail_booking_bottom_bar.dart';
import 'components/detail_hero_header.dart';
import 'components/detail_narrative_section.dart';
import 'components/detail_photo_grid.dart';
import 'components/detail_property_header.dart';
import 'components/detail_specs_bar.dart';

/// EstateDetailScreen: Pixel-perfect replica of native Android Compose EstateDetailScreen.kt
/// Featuring edge-to-edge hero photography, rating & verified badges, property headers,
/// horizontal specs bar, architectural narrative & features, gallery grid, listing advisor card,
/// and fixed booking bottom bar.
class EstateDetailScreen extends StatelessWidget {
  final String estateId;
  final EstateController controller;

  const EstateDetailScreen({
    super.key,
    required this.estateId,
    required this.controller,
  });

  void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final estate = MockData.getEstateById(estateId);
        final isSaved = controller.isEstateSaved(estate.id);
        final advisor = estate.advisor ?? MockData.sarahJenkins;
        final narrativeText = estate.narrative ??
            estate.description ??
            'Perched dramatically above Lake Austin, this architectural sanctuary embodies modern transparency, sustainable craftsmanship, and harmonious integration with the surrounding Texas Hill Country landscape.';

        return Scaffold(
          backgroundColor: AppColors.background,
          bottomNavigationBar: DetailBookingBottomBar(
            formattedPrice: estate.formattedPrice,
            estimatedMonthly: estate.estimatedMonthly,
            onBookTourClick: () {
              _showFeedback(context, 'Private viewing consultation requested');
            },
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Edge-to-Edge Parallax Hero Header with Navigation Controls
                DetailHeroHeader(
                  estate: estate,
                  isSaved: isSaved,
                  onBackClick: () => Navigator.of(context).pop(),
                  onToggleSave: () {
                    controller.toggleSave(estate.id);
                    _showFeedback(
                      context,
                      isSaved
                          ? 'Removed from saved shortlist'
                          : 'Saved to private shortlist',
                    );
                  },
                  onShareClick: () {
                    _showFeedback(context, 'Listing link copied to clipboard');
                  },
                ),

                // Content Container with 16dp Horizontal Gutter
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2. Property Header (Tags, Title, Address, Price)
                      DetailPropertyHeader(estate: estate),

                      const SizedBox(height: 18),

                      // 3. Floating Specs Bar (Beds, Baths, Sqft, Lot, Eco)
                      DetailSpecsBar(estate: estate),

                      const SizedBox(height: 26),

                      // 4. Architectural Overview & Narrative
                      DetailNarrativeSection(narrative: narrativeText),

                      const SizedBox(height: 26),

                      // 5. Curated Property Photo Gallery Grid
                      DetailPhotoGrid(estate: estate),

                      const SizedBox(height: 26),

                      // 6. Dedicated Listing Advisor Representation Card (Sarah Jenkins)
                      const Text(
                        'Listing Representation',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 12),
                      AdvisorCard(
                        advisor: advisor,
                        onCallClick: () {
                          _showFeedback(
                            context,
                            'Connecting with advisor ${advisor.name}...',
                          );
                        },
                        onChatClick: () {
                          _showFeedback(
                            context,
                            'Starting private chat with ${advisor.name}...',
                          );
                        },
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
