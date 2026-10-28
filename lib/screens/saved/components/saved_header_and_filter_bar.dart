import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

enum SavedTab {
  all,
  collections,
  alerts,
}

/// Header with "Saved Estates" title, count pill, sort icon,
/// and 3-way Segmented Pill tab bar ("All (count)", "Collections (3)", "Alerts •").
/// Matches native Android Jetpack Compose SavedHeaderAndFilterBar.kt.
class SavedHeaderAndFilterBar extends StatelessWidget {
  final SavedTab selectedTab;
  final ValueChanged<SavedTab> onTabSelected;
  final VoidCallback onSortClick;
  final int propertiesCount;

  const SavedHeaderAndFilterBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    required this.onSortClick,
    this.propertiesCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    final isZero = propertiesCount == 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: "Saved Estates" + Count Badge + Sort Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Saved Estates',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isZero
                          ? AppColors.surfaceContainerLow
                          : AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      '$propertiesCount Properties',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isZero ? AppColors.outline : AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onSortClick,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.swap_vert_rounded,
                      size: 20,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Row 2: Segmented Pill Tab Bar ("All (count)", "Collections (3)", "Alerts •")
          Container(
            height: 46,
            width: double.infinity,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFFECEFEA),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                _buildSegment(
                  tab: SavedTab.all,
                  label: 'All ($propertiesCount)',
                ),
                _buildSegment(
                  tab: SavedTab.collections,
                  label: isZero ? 'Collections (0)' : 'Collections (3)',
                ),
                _buildSegment(
                  tab: SavedTab.alerts,
                  label: 'Alerts',
                  hasDot: !isZero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegment({
    required SavedTab tab,
    required String label,
    bool hasDot = false,
  }) {
    final isSelected = tab == selectedTab;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(tab),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? AppColors.onSurface
                      : AppColors.onSurfaceVariant,
                ),
              ),
              if (hasDot) ...[
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

