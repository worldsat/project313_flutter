import 'package:flutter/material.dart';
import '../../controllers/estate_controller.dart';
import '../../models/navigation_tab.dart';
import '../../theme/app_colors.dart';
import '../detail/estate_detail_screen.dart';
import 'components/curated_collections_row.dart';
import 'components/off_market_advisor_card.dart';
import 'components/portfolio_card.dart';
import 'components/saved_estate_card.dart';
import 'components/saved_top_bar.dart';

class SavedPropertiesScreen extends StatefulWidget {
  final EstateController controller;

  const SavedPropertiesScreen({
    super.key,
    required this.controller,
  });

  @override
  State<SavedPropertiesScreen> createState() => _SavedPropertiesScreenState();
}

class _SavedPropertiesScreenState extends State<SavedPropertiesScreen> {
  int _selectedTab = 0; // 0: All, 1: Collections, 2: Alerts

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
        final savedList = widget.controller.savedEstates;
        final totalCount = widget.controller.totalSavedCount;
        final isEmpty = totalCount == 0;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                // 1. Top App Bar
                SliverToBoxAdapter(
                  child: SavedTopBar(
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

                // 2. Title + Count Badge + Sort Button (also acts as Preview Empty State toggle on tap)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Saved Estates',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: AppColors.onSurface,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                widget.controller.toggleEmptySavedState();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: isEmpty
                                      ? AppColors.surfaceContainerLow
                                      : AppColors.secondaryContainer,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  '$totalCount Properties',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: isEmpty
                                        ? AppColors.outline
                                        : AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: AppColors.surfaceContainerLow,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.swap_vert_rounded,
                              size: 20,
                              color: AppColors.onSurface,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sorted by: Price (High to Low)'),
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

                // 3. Segmented Pill Tab Bar (All, Collections, Alerts)
                SliverToBoxAdapter(
                  child: Container(
                    height: 44,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        _SegmentedTab(
                          label: 'All ($totalCount)',
                          isSelected: _selectedTab == 0,
                          onTap: () => setState(() => _selectedTab = 0),
                        ),
                        _SegmentedTab(
                          label: isEmpty ? 'Collections (0)' : 'Collections (3)',
                          isSelected: _selectedTab == 1,
                          onTap: () => setState(() => _selectedTab = 1),
                        ),
                        _SegmentedTab(
                          label: 'Alerts',
                          isSelected: _selectedTab == 2,
                          hasBadge: !isEmpty,
                          onTap: () => setState(() => _selectedTab = 2),
                        ),
                      ],
                    ),
                  ),
                ),

                // 4. If Empty State
                if (isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                color: AppColors.secondaryContainer,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.bookmark_border_rounded,
                                size: 36,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'No Saved Estates Yet',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Explore our handpicked eco-luxury portfolio and tap the heart icon on any estate to curate your private collection.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.5,
                                height: 1.45,
                                color: AppColors.outline,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                widget.controller
                                    .navigateToTab(NavigationTab.explore);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 14),
                              ),
                              child: const Text(
                                'Explore Curated Estates',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                  )
                else ...[
                  // 5. Curated Collections Horizontal Carousel
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: CuratedCollectionsRow(
                        onNewCollectionClick: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Create collection dialog'),
                              duration: Duration(milliseconds: 800),
                            ),
                          );
                        },
                        onCollectionClick: (name) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Filtered by $name'),
                              duration: const Duration(milliseconds: 800),
                            ),
                          );
                        },
                        onViewAllClick: () {},
                      ),
                    ),
                  ),

                  // 6. Portfolio Intelligence Card
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 14.0, bottom: 6.0),
                      child: PortfolioCard(),
                    ),
                  ),

                  // 7. Saved Estate Cards List
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final estate = savedList[index];
                        return SavedEstateCard(
                          estate: estate,
                          onTap: () => _openDetail(estate.id),
                          onToggleSave: () {
                            widget.controller.toggleSave(estate.id);
                          },
                          onBookTour: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Tour request initiated for ${estate.title}'),
                              ),
                            );
                          },
                          onShare: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Link copied to clipboard'),
                                duration: Duration(milliseconds: 800),
                              ),
                            );
                          },
                          onNotes: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Private notes opened'),
                                duration: Duration(milliseconds: 800),
                              ),
                            );
                          },
                        );
                      },
                      childCount: savedList.length,
                    ),
                  ),

                  // 8. Off-Market Advisor Consultation Card
                  SliverToBoxAdapter(
                    child: OffMarketAdvisorCard(
                      onConsultClick: () {
                        widget.controller.navigateToTab(NavigationTab.agent);
                      },
                    ),
                  ),

                  const SliverToBoxAdapter(
                    child: SizedBox(height: 80),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SegmentedTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool hasBadge;
  final VoidCallback onTap;

  const _SegmentedTab({
    required this.label,
    required this.isSelected,
    this.hasBadge = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? AppColors.onSurface
                      : AppColors.onSurfaceVariant,
                ),
              ),
              if (hasBadge) ...[
                const SizedBox(width: 4),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.tertiary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
