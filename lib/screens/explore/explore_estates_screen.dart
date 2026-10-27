import 'package:flutter/material.dart';
import '../../controllers/estate_controller.dart';
import '../../models/filter_category.dart';
import '../../models/navigation_tab.dart';
import '../../theme/app_colors.dart';
import '../detail/estate_detail_screen.dart';
import 'components/estate_card.dart';
import 'components/explore_top_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final currentCategory = widget.controller.selectedCategory;

        final popularList = currentCategory == FilterCategory.all
            ? widget.controller.popularEstates
            : widget.controller.popularEstates
                .where((e) => e.category == currentCategory)
                .toList();

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                // Scrollable Feed
                CustomScrollView(
                  slivers: [
                    // 1. Top App Bar
                    SliverToBoxAdapter(
                      child: ExploreTopBar(
                        onNotificationClick: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No new notifications'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        onProfileClick: () {
                          widget.controller.navigateToTab(NavigationTab.agent);
                        },
                      ),
                    ),

                    // 2. Search Bar
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceContainerLow,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: AppColors.outline,
                                      size: 22,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
                                        controller: _searchController,
                                        style: const TextStyle(
                                          fontSize: 13.5,
                                          color: AppColors.onSurface,
                                        ),
                                        decoration: const InputDecoration(
                                          hintText:
                                              'Search Austin villas, Barton Creek...',
                                          hintStyle: TextStyle(
                                            color: AppColors.outline,
                                            fontSize: 13,
                                          ),
                                          border: InputBorder.none,
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Filter Button
                            Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.tune_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Filter settings opened'),
                                      duration: Duration(milliseconds: 800),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 3. Category Filter Chips (Horizontal List)
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 52,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          scrollDirection: Axis.horizontal,
                          itemCount: FilterCategory.values.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final cat = FilterCategory.values[index];
                            final isSelected = cat == currentCategory;

                            return GestureDetector(
                              onTap: () => widget.controller.selectCategory(cat),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.outlineVariant
                                            .withOpacity(0.6),
                                    width: 1,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: AppColors.primary
                                                .withOpacity(0.25),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    cat.label,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.onSurface,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 6)),

                    // 4. Featured Estate Card (The Glass Pavilions)
                    SliverToBoxAdapter(
                      child: EstateCard(
                        estate: widget.controller.featuredEstate,
                        isSaved: widget.controller.isEstateSaved(
                          widget.controller.featuredEstate.id,
                        ),
                        onTap: () =>
                            _openDetail(widget.controller.featuredEstate.id),
                        onToggleSave: () {
                          widget.controller.toggleSave(
                            widget.controller.featuredEstate.id,
                          );
                        },
                      ),
                    ),

                    // 5. Popular Section Title
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Popular Near You',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.onSurface,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'High-demand properties across Central Texas',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.outline,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    size: 18,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 6. Popular Estates List
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final estate = popularList[index];
                          return EstateCard(
                            estate: estate,
                            isSaved: widget.controller.isEstateSaved(estate.id),
                            onTap: () => _openDetail(estate.id),
                            onToggleSave: () {
                              widget.controller.toggleSave(estate.id);
                            },
                          );
                        },
                        childCount: popularList.length,
                      ),
                    ),

                    // Extra Bottom Clearance for FAB & Navigation Bar
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 90),
                    ),
                  ],
                ),

                // Floating Action Button: Map View
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        widget.controller.navigateToTab(NavigationTab.map);
                      },
                      icon: const Icon(Icons.map_outlined, size: 18),
                      label: const Text(
                        'Map View',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkFabBg,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: Colors.black.withOpacity(0.4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
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
