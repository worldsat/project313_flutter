import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class ListViewFab extends StatelessWidget {
  final int count;
  final VoidCallback onClick;

  const ListViewFab({
    super.key,
    this.count = 28,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.darkFabBg,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkFabBg.withOpacity(0.4),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.format_list_bulleted,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              'List View ($count)',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

