import 'package:flutter/material.dart';
import '../../controllers/estate_controller.dart';
import '../../models/estate.dart';
import '../../models/navigation_tab.dart';
import '../../theme/app_colors.dart';
import '../detail/estate_detail_screen.dart';
import 'components/curated_collections_row.dart';
import 'components/off_market_advisor_card.dart';
import 'components/portfolio_card.dart';
import 'components/saved_estate_card.dart';
import 'components/saved_header_and_filter_bar.dart';
import 'components/saved_top_bar.dart';

/// SavedPropertiesScreen: Pixel-perfect replica of native Android Compose SavedPropertiesScreen.kt
/// Featuring top bar with unread notifications badge, segmented tab control ("All", "Collections", "Alerts"),
/// curated collections carousel, portfolio intelligence card, saved estate cards list,
/// off-market advisor card, and full empty state support.
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
  SavedTab _selectedTab = SavedTab.all;
  String? _selectedCollection;
  bool _isReversedSort = false;
  int _unreadNotificationsCount = 1;

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
        duration: const Duration(milliseconds: 1400),
      ),
    );
  }

  List<Estate> _filterEstates(List<Estate> allSaved) {
    List<Estate> list;

    if (_selectedCollection != null) {
      if (_selectedCollection == 'Lakefront Living') {
        list = allSaved.where((e) => e.address.contains('Westlake') || e.address.contains('Rainey') || e.id == 'the-glass-pavilions').toList();
      } else if (_selectedCollection == 'Hill Country') {
        list = allSaved.where((e) => e.address.contains('Barton Creek') || e.address.contains('Tarrytown') || e.id == 'emerald-grove-residence').toList();
      } else {
        list = allSaved;
      }
    } else {
      switch (_selectedTab) {
        case SavedTab.all:
          list = List.from(allSaved);
          break;
        case SavedTab.collections:
          list = allSaved.take(3).toList();
          break;
        case SavedTab.alerts:
          list = allSaved.where((e) {
            return e.priceDropNotice != null ||
                e.openHouseNotice != null ||
                e.availabilityTag != null;
          }).toList();
          break;
      }
    }

    if (_isReversedSort) {
      list = list.reversed.toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final totalCount = widget.controller.totalSavedCount;
        final isEmpty = totalCount == 0;
        final displayedEstates = _filterEstates(widget.controller.savedEstates);

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            bottom: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // 1. Saved Top Bar
                SliverToBoxAdapter(
                  child: SavedTopBar(
                    unreadNotifications: _unreadNotificationsCount,
                    onNotificationsClick: () {
                      setState(() {
                        _unreadNotificationsCount = 0;
                      });
                      _showFeedback('Notifications marked as read');
                    },
                    onProfileClick: () {
                      widget.controller.navigateToTab(NavigationTab.agent);
                    },
                  ),
                ),

                // 2. Saved Header & Filter Bar ("Saved Estates" + Count Badge + Sort + Segmented Tab Control)
                SliverToBoxAdapter(
                  child: GestureDetector(
                    onDoubleTap: () {
                      // Developer quick-toggle to test Empty State
                      widget.controller.toggleEmptySavedState();
                    },
                    child: SavedHeaderAndFilterBar(
                      selectedTab: _selectedTab,
                      propertiesCount: totalCount,
                      onTabSelected: (tab) {
                        setState(() {
                          _selectedTab = tab;
                          _selectedCollection = null;
                        });
                      },
                      onSortClick: () {
                        setState(() {
                          _isReversedSort = !_isReversedSort;
                        });
                        _showFeedback('Sorted saved properties');
                      },
                    ),
                  ),
                ),

                // 3. Conditional Content: Empty State OR Full Saved Screen Content
                if (isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 80x80 Circle Icon Bubble
                            Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                color: AppColors.secondaryContainer,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.bookmark_border_rounded,
                                size: 36,
                                color: AppColors.primary,
                              ),
                            ),

                            const SizedBox(height: 22),

                            // Heading
                            const Text(
                              'No Saved Estates Yet',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onSurface,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Description
                            const SizedBox(
                              width: 290,
                              child: Text(
                                'Explore our handpicked eco-luxury portfolio and tap the heart icon on any estate to curate your private collection.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  height: 1.48,
                                  color: AppColors.outline,
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Primary CTA Button
                            SizedBox(
                              width: 220,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  widget.controller
                                      .navigateToTab(NavigationTab.explore);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 3,
                                  shadowColor:
                                      AppColors.primary.withOpacity(0.25),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: const Text(
                                  'Explore Curated Estates',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ),
                  )
                else ...[
                  // 4. Curated Collections Carousel
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: CuratedCollectionsRow(
                        onNewCollectionClick: () {
                          _showFeedback('Create collection dialog opened');
                        },
                        onCollectionClick: (name) {
                          setState(() {
                            if (_selectedCollection == name) {
                              _selectedCollection = null;
                              _showFeedback('Cleared filter');
                            } else {
                              _selectedCollection = name;
                              _showFeedback('Filtered by $name');
                            }
                          });
                        },
                        onViewAllClick: () {
                          _showFeedback('Viewing all curated collections');
                        },
                      ),
                    ),
                  ),

                  // 5. Portfolio Intelligence Card (+2.4% metric)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 14.0),
                      child: PortfolioCard(),
                    ),
                  ),

                  // 6. Saved Estate Cards List
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 8),
                  ),

                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final estate = displayedEstates[index];
                        return SavedEstateCard(
                          estate: estate,
                          onTap: () => _openDetail(estate.id),
                          onToggleSave: () {
                            widget.controller.toggleSave(estate.id);
                            _showFeedback('Removed from saved shortlist');
                          },
                          onBookTour: () {
                            if (estate.isUnderContract) {
                              _showFeedback(
                                  'Backup offer requested for ${estate.title}');
                            } else {
                              _showFeedback(
                                  'Viewing tour requested for ${estate.title}');
                            }
                          },
                          onShare: () {
                            _showFeedback('Estate link copied to clipboard');
                          },
                          onNotes: () {
                            _showFeedback('Opening private notes');
                          },
                        );
                      },
                      childCount: displayedEstates.length,
                    ),
                  ),

                  // 7. Off-Market Advisor Consultation Card
                  SliverToBoxAdapter(
                    child: OffMarketAdvisorCard(
                      onConsultClick: () {
                        widget.controller.navigateToTab(NavigationTab.agent);
                        _showFeedback(
                            'Connecting with private advisor Sarah Jenkins');
                      },
                    ),
                  ),

                  // Bottom padding for bottom navigation bar clearance
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 24),
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
