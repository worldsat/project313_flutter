import 'package:flutter/material.dart';
import '../controllers/estate_controller.dart';
import '../data/mock_data.dart';
import '../models/navigation_tab.dart';
import '../theme/app_colors.dart';
import 'agent/agent_advisor_screen.dart';
import 'explore/explore_estates_screen.dart';
import 'map/map_explorer_screen.dart';
import 'saved/saved_properties_screen.dart';

class MainScaffold extends StatefulWidget {
  final int initialTab;

  const MainScaffold({super.key, this.initialTab = 0});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late final EstateController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EstateController();
    if (widget.initialTab >= 0 &&
        widget.initialTab < NavigationTab.values.length) {
      _controller.navigateToTab(NavigationTab.values[widget.initialTab]);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final currentTabIndex = _controller.currentTab.index;

        return Scaffold(
          body: IndexedStack(
            index: currentTabIndex,
            children: [
              ExploreEstatesScreen(controller: _controller),
              MapExplorerScreen(controller: _controller),
              SavedPropertiesScreen(controller: _controller),
              const AgentAdvisorScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: AppColors.outlineVariant.withOpacity(0.35),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: NavigationBar(
              selectedIndex: currentTabIndex,
              onDestinationSelected: (index) {
                _controller.navigateToTab(NavigationTab.values[index]);
              },
              backgroundColor: Colors.white,
              indicatorColor: AppColors.secondaryContainer,
              elevation: 0,
              height: 64,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon:
                      Icon(Icons.explore, color: AppColors.primary),
                  label: 'Explore',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.map_outlined),
                  selectedIcon: Icon(Icons.map, color: AppColors.primary),
                  label: 'Map',
                ),
                NavigationDestination(
                  icon: Badge(
                    label: Text('${_controller.totalSavedCount}'),
                    isLabelVisible: _controller.totalSavedCount > 0,
                    backgroundColor: AppColors.primary,
                    child: const Icon(Icons.bookmark_border_rounded),
                  ),
                  selectedIcon: Badge(
                    label: Text('${_controller.totalSavedCount}'),
                    isLabelVisible: _controller.totalSavedCount > 0,
                    backgroundColor: AppColors.primary,
                    child: const Icon(Icons.bookmark_rounded,
                        color: AppColors.primary),
                  ),
                  label: 'Saved',
                ),
                NavigationDestination(
                  icon: ClipOval(
                    child: Image.asset(
                      MockData.sarahJenkins.avatarAsset,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                  selectedIcon: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        MockData.sarahJenkins.avatarAsset,
                        width: 22,
                        height: 22,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  label: 'Agent',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
