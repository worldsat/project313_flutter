import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../controllers/estate_controller.dart';
import '../../data/mock_data.dart';
import '../../models/navigation_tab.dart';
import '../../theme/app_colors.dart';
import '../detail/estate_detail_screen.dart';
import 'components/list_view_fab.dart';
import 'components/map_estate_preview_sheet.dart';
import 'components/map_filter_chips_row.dart';
import 'components/map_search_bar.dart';
import 'components/map_top_bar.dart';
import 'components/real_interactive_map.dart';

class MapExplorerScreen extends StatefulWidget {
  final EstateController controller;

  const MapExplorerScreen({
    super.key,
    required this.controller,
  });

  @override
  State<MapExplorerScreen> createState() => _MapExplorerScreenState();
}

class _MapExplorerScreenState extends State<MapExplorerScreen> {
  final MapController _mapController = MapController();
  MapLayerType _currentLayerType = MapLayerType.street;

  void _openDetail(BuildContext context, String estateId) {
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
        shape: RoundedCornerShapeBorder(),
        backgroundColor: AppColors.darkFabBg,
      ),
    );
  }

  void _cycleLayer() {
    setState(() {
      _currentLayerType = switch (_currentLayerType) {
        MapLayerType.street => MapLayerType.topo,
        MapLayerType.topo => MapLayerType.satellite,
        MapLayerType.satellite => MapLayerType.street,
      };
    });
    _showFeedback('Switched to ${_currentLayerType.displayName}');
  }

  void _locateAustin() {
    _mapController.move(const LatLng(30.2780, -97.7780), 12.5);
    _showFeedback('Centered on Austin Hill Country reserve');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final selectedEstate = widget.controller.selectedMapEstate;
        final isSaved = widget.controller.isEstateSaved(selectedEstate.id);

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              // 1. Top Header Bar (Verdant Estates + Location + Notification + Avatar)
              MapTopBar(
                location: 'Austin, TX',
                unreadNotifications: 2,
                onNotificationsClick: () {
                  _showFeedback('2 new architectural reserves added today');
                },
                onProfileClick: () {
                  _showFeedback('Advisor Profile: Sarah Jenkins');
                },
              ),

              // 2. Map Canvas + Floating Overlays
              Expanded(
                child: Stack(
                  children: [
                    // A. Real Interactive Map (OpenStreetMap & Esri layers, Austin, TX)
                    Positioned.fill(
                      child: RealInteractiveMap(
                        pins: MockData.mapPins,
                        selectedEstateId: widget.controller.selectedMapEstateId,
                        layerType: _currentLayerType,
                        mapController: _mapController,
                        onPinSelected: (id) {
                          widget.controller.selectMapEstate(id);
                        },
                      ),
                    ),

                    // B. Top Floating Search & Filter Chips Row
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: MapSearchBar(
                              regionTitle: 'Travis County, Austin',
                              activeReservesCount: 28,
                              onSearchClick: () {
                                _showFeedback('Search Austin neighborhoods');
                              },
                              onLayersClick: _cycleLayer,
                              onLocateClick: _locateAustin,
                            ),
                          ),
                          const SizedBox(height: 10),
                          MapFilterChipsRow(
                            onFiltersClick: () {
                              _showFeedback('3 luxury filters active');
                            },
                            onPriceFilterClick: () {
                              _showFeedback('Price filter: \$1.5M - \$5M');
                            },
                            onBedsFilterClick: () {
                              _showFeedback('Filtered: 3+ Beds');
                            },
                          ),
                        ],
                      ),
                    ),

                    // C. Bottom Floating "List View" FAB + Estate Preview Sheet
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Floating "List View (28)" Pill Button
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0, bottom: 10.0),
                            child: ListViewFab(
                              count: 28,
                              onClick: () {
                                widget.controller.navigateToTab(NavigationTab.explore);
                              },
                            ),
                          ),

                          // Bottom Estate Preview Sheet
                          MapEstatePreviewSheet(
                            estate: selectedEstate,
                            isSaved: isSaved,
                            onToggleSave: () {
                              widget.controller.toggleSave(selectedEstate.id);
                            },
                            onDirectionsClick: () {
                              _showFeedback(
                                'Navigating to ${selectedEstate.address}...',
                              );
                            },
                            onViewDetailsClick: (id) {
                              _openDetail(context, id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RoundedCornerShapeBorder extends RoundedRectangleBorder {
  RoundedCornerShapeBorder()
      : super(
          borderRadius: BorderRadius.circular(12),
        );
}
