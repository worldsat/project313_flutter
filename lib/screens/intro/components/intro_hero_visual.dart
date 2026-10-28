import 'package:flutter/material.dart';

/// Central Hero Visual with Concentric Resonant Rings, Topographic Contours,
/// Squircle Emblem with Architectural Villa Vector, and Floating Satellite Badges.
/// Matches native Android Jetpack Compose IntroHeroVisual.kt.
class IntroHeroVisual extends StatelessWidget {
  final int curatedCount;
  final String leedRating;
  final String reserveCategory;
  final String reserveTitle;

  const IntroHeroVisual({
    super.key,
    this.curatedCount = 42,
    this.leedRating = 'LEED Platinum',
    this.reserveCategory = 'PRIVATE RESERVE',
    this.reserveTitle = 'Austin Enclaves',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // 1. Organic Undulating Topographic Landscape Waves & Resonant Radar Rings
          Positioned.fill(
            child: CustomPaint(
              painter: _HeroRadarCanvasPainter(),
            ),
          ),

          // 2. Central Sanctuary Card ("PRIVATE RESERVE" + "Austin Enclaves")
          Transform.translate(
            offset: const Offset(0, 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Modern Architecture Villa Icon Squircle
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF6ED998),
                        Color(0xFF45A86E),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: CustomPaint(
                    size: const Size(26, 26),
                    painter: _ArchitecturalVillaPainter(),
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  reserveCategory,
                  style: const TextStyle(
                    color: Color(0xFFAFE4C7),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1.4,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  reserveTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'serif',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),

          // 3. Top-Right Satellite Pill: "• 42 Curated Homes"
          Transform.translate(
            offset: const Offset(68, -78),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFD6E4DB),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF008955),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Text(
                    '$curatedCount Curated Homes',
                    style: const TextStyle(
                      color: Color(0xFF133627),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Bottom-Left Satellite Pill: "LEED Platinum"
          Transform.translate(
            offset: const Offset(-82, 72),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFD6E4DB),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.energy_savings_leaf_outlined,
                    color: Color(0xFF008955),
                    size: 15,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    leedRating,
                    style: const TextStyle(
                      color: Color(0xFF133627),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Canvas painter for topographic background waves & resonant radar rings
class _HeroRadarCanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final canvasWidth = size.width;
    final canvasHeight = size.height;
    final centerX = canvasWidth / 2.0;
    final centerY = canvasHeight / 2.0 + 10.0;
    final center = Offset(centerX, centerY);

    // Background subtle topographic contour curve 1
    final path1 = Path()
      ..moveTo(0, canvasHeight * 0.22)
      ..cubicTo(
        canvasWidth * 0.35, canvasHeight * 0.12,
        canvasWidth * 0.65, canvasHeight * 0.32,
        canvasWidth, canvasHeight * 0.18,
      )
      ..lineTo(canvasWidth, canvasHeight)
      ..lineTo(0, canvasHeight)
      ..close();
    canvas.drawPath(path1, Paint()..color = const Color(0x18164E35));

    // Background subtle topographic contour curve 2
    final path2 = Path()
      ..moveTo(0, canvasHeight * 0.52)
      ..cubicTo(
        canvasWidth * 0.30, canvasHeight * 0.42,
        canvasWidth * 0.70, canvasHeight * 0.62,
        canvasWidth, canvasHeight * 0.48,
      )
      ..lineTo(canvasWidth, canvasHeight)
      ..lineTo(0, canvasHeight)
      ..close();
    canvas.drawPath(path2, Paint()..color = const Color(0x2213422C));

    // Outer resonant ring
    final outerRingPaint = Paint()
      ..color = const Color(0x247ED4A2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, 152.0, outerRingPaint);

    // Middle resonant ring
    final midRingPaint = Paint()
      ..color = const Color(0x3B7ED4A2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawCircle(center, 120.0, midRingPaint);

    // Inner glowing disc background
    final glowPaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0x4C327855),
          Color(0x2E14422C),
          Color(0x140B2B1B),
        ],
        stops: [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: 90.0));
    canvas.drawCircle(center, 88.0, glowPaint);

    // Inner disc border
    final discBorderPaint = Paint()
      ..color = const Color(0x608ADBB0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, 88.0, discBorderPaint);
  }

  @override
  bool shouldRepaint(covariant _HeroRadarCanvasPainter oldDelegate) => false;
}

/// Vector graphic painter for the Modern Architectural Villa emblem
class _ArchitecturalVillaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    const darkGreen = Color(0xFF0C2C1C);

    final outlinePaint = Paint()
      ..color = darkGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final housePath = Path()
      // Left tall block
      ..moveTo(w * 0.18, h * 0.28)
      ..lineTo(w * 0.52, h * 0.28)
      ..lineTo(w * 0.52, h * 0.82)
      ..lineTo(w * 0.18, h * 0.82)
      ..close()
      // Right lower cantilevered block
      ..moveTo(w * 0.52, h * 0.44)
      ..lineTo(w * 0.82, h * 0.44)
      ..lineTo(w * 0.82, h * 0.82)
      ..lineTo(w * 0.52, h * 0.82)
      ..close();

    canvas.drawPath(housePath, outlinePaint);

    final windowPaint = Paint()
      ..color = darkGreen
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(w * 0.28, h * 0.42),
      Offset(w * 0.42, h * 0.42),
      windowPaint,
    );
    canvas.drawLine(
      Offset(w * 0.62, h * 0.58),
      Offset(w * 0.74, h * 0.58),
      windowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ArchitecturalVillaPainter oldDelegate) => false;
}
