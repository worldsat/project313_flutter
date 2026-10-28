import 'package:flutter/material.dart';
import '../../controllers/estate_controller.dart';
import '../../models/estate.dart';
import '../../models/filter_category.dart';
import '../../models/navigation_tab.dart';
import '../../theme/app_colors.dart';
import '../detail/estate_detail_screen.dart';
import 'components/eco_luxury_banner_card.dart';
import 'components/explore_search_bar.dart';
import 'components/explore_top_bar.dart';
import 'components/featured_estate_card.dart';
import 'components/filter_chip_row.dart';
import 'components/map_view_fab.dart';
import 'components/popular_estate_card.dart';

class ExploreEstatesScreen extends StatefulWidget {
  final EstateController controller;

  const ExploreEstatesScreen({
    super.key,
    required this.controller,
  });

  @override
  State<ExploreEstatesScreen> createState() => _ExploreEstatesScreenState();
}

class _ExploreEstatesScreenState extends State<ExploreEstatesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openDetail(String estateId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EstateDetailScreen(
          estateId: estateId,
          controller: widget.controller,
        ),
      ),
    );
  }

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: AppColors.darkFabBg,
      ),
    );
  }

  List<Estate> _filterEstates(List<Estate> list, FilterCategory category, String query) {
    var result = list;

    // Filter by Category
    if (category != FilterCategory.all) {
      result = result.where((e) => e.category == category).toList();
    }

    // Filter by Search Query
    if (query.trim().isNotEmpty) {
      final q = query.trim().toLowerCase();
      result = result.where((e) {
        final matchesTitle = e.title.toLowerCase().contains(q);
        final matchesAddress = e.address.toLowerCase().contains(q);
        final matchesArea = (e.areaTag ?? '').toLowerCase().contains(q);
        final matchesStatus = (e.statusTag ?? '').toLowerCase().contains(q);
        return matchesTitle || matchesAddress || matchesArea || matchesStatus;
      }).toList();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final selectedCategory = widget.controller.selectedCategory;
        final featured = widget.controller.featuredEstate;
        final isFeaturedSaved = widget.controller.isEstateSaved(featured.id);

        final filteredPopular = _filterEstates(
          widget.controller.popularEstates,
          selectedCategory,
          _searchQuery,
        );

        final showFeatured = _searchQuery.isEmpty &&
            (selectedCategory == FilterCategory.all ||
                featured.category == selectedCategory);

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // 1. Top Header Bar
                  SliverToBoxAdapter(
                    child: ExploreTopBar(
                      location: 'Austin, TX',
                      unreadNotifications: 2,
                      onNotificationsClick: () {
                        _showFeedback('2 new architectural reserves added today');
                      },
                      onProfileClick: () {
                        widget.controller.navigateToTab(NavigationTab.agent);
                      },
                    ),
                  ),

                  // 2. Search Bar with Filter Button
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                      child: ExploreSearchBar(
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val;
                          });
                        },
                        onFilterClick: () {
                          _showFeedback('Filter settings: Price & Bedrooms');
                        },
                      ),
                    ),
                  ),

                  // 3. Filter Category Chips Carousel
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: FilterChipRow(
                        selectedCategory: selectedCategory,
                        onCategorySelect: (cat) {
                          widget.controller.selectCategory(cat);
                        },
                      ),
                    ),
                  ),

                  // 4. Featured Estate Section (The Glass Pavilions)
                  if (showFeatured)
                    SliverToBoxAdapter(
                      child: FeaturedEstateSection(
                        estate: featured,
                        isSaved: isFeaturedSaved,
                        onEstateClick: (id) => _openDetail(id),
                        onToggleSave: (id) => widget.controller.toggleSave(id),
                      ),
                    ),

                  // 5. Curated Eco-Luxury Living Banner Card
                  if (_searchQuery.isEmpty)
                    const SliverToBoxAdapter(
                      child: EcoLuxuryBannerCard(),
                    ),

                  // 6. Popular Near You Header
                  SliverToBoxAdapter(
                    child: PopularSectionHeader(
                      onViewAllClick: () {
                        widget.controller.selectCategory(FilterCategory.all);
                      },
                    ),
                  ),

                  // 7. Popular Estates Vertical List
                  if (filteredPopular.isNotEmpty)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final estate = filteredPopular[index];
                          return PopularEstateCard(
                            estate: estate,
                            isSaved: widget.controller.isEstateSaved(estate.id),
                            onEstateClick: (id) => _openDetail(id),
                            onToggleSave: (id) => widget.controller.toggleSave(id),
                          );
                        },
                        childCount: filteredPopular.length,
                      ),
                    )
                  else
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 40.0,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: 48,
                                color: AppColors.outline.withOpacity(0.5),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'No matching estates found',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Bottom spacer for clearance above FAB and Navigation Bar
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 80),
                  ),
                ],
              ),

              // 8. Floating Action Button: Map View (Pill aligned to Bottom-Right)
              Positioned(
                bottom: 16,
                right: 16,
                child: MapViewFab(
                  onClick: () {
                    widget.controller.navigateToTab(NavigationTab.map);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
