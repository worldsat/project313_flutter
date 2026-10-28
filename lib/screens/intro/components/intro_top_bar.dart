import 'dart:ui';
import 'package:flutter/material.dart';

/// Top bar with frosted "VERDANT ESTATES" badge and "Skip Tour" action button.
/// Matches native Android Jetpack Compose IntroTopBar.kt.
class IntroTopBar extends StatelessWidget {
  final VoidCallback onSkipClick;

  const IntroTopBar({
    super.key,
    required this.onSkipClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Frosted Glass Pill Brand Badge ("VERDANT ESTATES")
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 16.0,
                  top: 5.0,
                  bottom: 5.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x38D6EFE0), // rgba(214, 239, 224, 0.22)
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: const Color(0x40FFFFFF),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0F764C),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.spa_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 9),
                    const Text(
                      'VERDANT ESTATES',
                      style: TextStyle(
                        color: Color(0xFFE2F5EA),
                        fontWeight: FontWeight.bold,
                        fontSize: 11.5,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Right: "Skip Tour" Action Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onSkipClick,
              borderRadius: BorderRadius.circular(50),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text(
                  'Skip Tour',
                  style: TextStyle(
                    color: Color(0xFFC0E2D1),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
