import 'package:flutter/material.dart';
import '../../../models/filter_category.dart';
import '../../../theme/app_colors.dart';

class FilterChipRow extends StatelessWidget {
  final FilterCategory selectedCategory;
  final ValueChanged<FilterCategory> onCategorySelect;

  const FilterChipRow({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelect,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: FilterCategory.values.map((category) {
          final isSelected = category == selectedCategory;
          final isEco = category.isEco;

          Color bgColor;
          Color textColor;
          Border? border;

          if (isEco) {
            bgColor = isSelected
                ? AppColors.ecoPillContainer
                : AppColors.ecoPillContainer.withOpacity(0.7);
            textColor = AppColors.ecoPillText;
            border = Border.all(
              color: AppColors.ecoPillBorder,
              width: 1,
            );
          } else if (isSelected) {
            bgColor = AppColors.secondaryContainer;
            textColor = AppColors.primary;
            border = null;
          } else {
            bgColor = AppColors.surfaceContainerLow;
            textColor = AppColors.onSurfaceVariant;
            border = null;
          }

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => onCategorySelect(category),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(50),
                  border: border,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected && !isEco) ...[
                      const Icon(
                        Icons.check,
                        size: 15,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 5),
                    ] else if (isEco) ...[
                      const Icon(
                        Icons.eco_outlined,
                        size: 15,
                        color: AppColors.ecoPillText,
                      ),
                      const SizedBox(width: 5),
                    ],
                    Text(
                      category == FilterCategory.all ? 'All' : category.label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: (isSelected || isEco)
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

