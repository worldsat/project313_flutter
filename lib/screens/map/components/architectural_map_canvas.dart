import 'package:flutter/material.dart';
import '../../../models/map_pin.dart';
import '../../../theme/app_colors.dart';

class ArchitecturalMapCanvas extends StatelessWidget {
  final List<MapPin> pins;
  final String selectedEstateId;
  final ValueChanged<String> onPinSelected;

  const ArchitecturalMapCanvas({
    super.key,
    required this.pins,
    required this.selectedEstateId,
    required this.onPinSelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Stack(
          children: [
            // 1. Vector Map Background Custom Painter matching preview_map.html
            Positioned.fill(
              child: CustomPaint(
                size: Size(width, height),
                painter: _ArchitecturalMapPainter(),
              ),
            ),

            // 2. Interactive Map Pins with exact tip alignment
            ...pins.map((pin) {
              final isSelected = pin.estateId == selectedEstateId;
              final posX = pin.xPercent * width;
              final posY = pin.yPercent * height;

              return Positioned(
                left: posX,
                top: posY,
                child: FractionalTranslation(
                  translation: const Offset(-0.5, -1.0),
                  child: GestureDetector(
                    onTap: () => onPinSelected(pin.estateId),
                    behavior: HitTestBehavior.opaque,
                    child: _MapPinBubble(
                      priceLabel: pin.priceLabel,
                      isSelected: isSelected,
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class _MapPinBubble extends StatelessWidget {
  final String priceLabel;
  final bool isSelected;

  const _MapPinBubble({
    required this.priceLabel,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Pill Box
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 12 : 10,
            vertical: isSelected ? 6 : 5,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.darkFabBg : Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: isSelected
                ? Border.all(color: const Color(0xFF52B788), width: 1.5)
                : Border.all(
                    color: AppColors.outlineVariant.withOpacity(0.4),
                    width: 1,
                  ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? AppColors.darkFabBg.withOpacity(0.45)
                    : Colors.black.withOpacity(0.14),
                blurRadius: isSelected ? 16 : 8,
                offset: Offset(0, isSelected ? 6 : 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: const BoxDecoration(
                    color: Color(0xFF52B788),
                    shape: BoxShape.circle,
                  ),
                ),
                const Icon(
                  Icons.home_rounded,
                  color: Colors.white,
                  size: 13,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                priceLabel,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                  fontSize: isSelected ? 13 : 12,
                ),
              ),
            ],
          ),
        ),

        // Downward Pointer Triangle
        CustomPaint(
          size: const Size(10, 6),
          painter: _TrianglePainter(
            color: isSelected ? AppColors.darkFabBg : Colors.white,
          ),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter oldDelegate) =>
      oldDelegate.color != color;
}

class _ArchitecturalMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double refW = 390.0;
    const double refH = 844.0;
    final double sx = size.width / refW;
    final double sy = size.height / refH;

    double x(double v) => v * sx;
    double y(double v) => v * sy;

    const canvasBg = Color(0xFFE6EFE4);
    const riverColor = Color(0xFFBADBC5);
    const parkGreen = Color(0xFFD6EBD7);
    const parkStroke = Color(0xFFD3E2D1);
    const roadColor = Colors.white;
    const roadBorder = Color(0xFFD0DDD0);
    const gridColor = Color(0xFFD9E6D8);

    // 1. Base Canvas
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = canvasBg,
    );

    // 2. Architectural Grid
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (double gx = 0; gx < size.width; gx += 70 * sx) {
      canvas.drawLine(Offset(gx, 0), Offset(gx, size.height), gridPaint);
    }
    for (double gy = 0; gy < size.height; gy += 70 * sy) {
      canvas.drawLine(Offset(0, gy), Offset(size.width, gy), gridPaint);
    }

    // 3. Green Nature Parks / Reserves (exact curves from preview_map.html SVG)
    final parkPaint = Paint()
      ..color = parkGreen
      ..style = PaintingStyle.fill;
    final parkStrokePaint = Paint()
      ..color = parkStroke
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Park 1: Northwest Westlake Reserve
    final p1 = Path()
      ..moveTo(x(40), y(180))
      ..quadraticBezierTo(x(120), y(160), x(180), y(210))
      ..quadraticBezierTo(x(210), y(270), x(140), y(320))
      ..quadraticBezierTo(x(60), y(310), x(40), y(240))
      ..close();
    canvas.drawPath(p1, parkPaint);
    canvas.drawPath(p1, parkStrokePaint);

    // Park 2: Northeast Hilltop Park
    final p2 = Path()
      ..moveTo(x(220), y(140))
      ..quadraticBezierTo(x(340), y(120), x(370), y(200))
      ..quadraticBezierTo(x(360), y(290), x(280), y(270))
      ..quadraticBezierTo(x(220), y(220), x(220), y(140))
      ..close();
    canvas.drawPath(p2, parkPaint);
    canvas.drawPath(p2, parkStrokePaint);

    // Park 3: Southwest Barton Creek Greenbelt
    final p3 = Path()
      ..moveTo(x(30), y(420))
      ..quadraticBezierTo(x(120), y(400), x(170), y(460))
      ..quadraticBezierTo(x(150), y(540), x(60), y(550))
      ..quadraticBezierTo(x(20), y(490), x(30), y(420))
      ..close();
    canvas.drawPath(p3, parkPaint);
    canvas.drawPath(p3, parkStrokePaint);

    // Park 4: Southeast Travis Heights Reserve
    final p4 = Path()
      ..moveTo(x(240), y(400))
      ..quadraticBezierTo(x(340), y(380), x(380), y(440))
      ..quadraticBezierTo(x(370), y(530), x(260), y(520))
      ..quadraticBezierTo(x(210), y(470), x(240), y(400))
      ..close();
    canvas.drawPath(p4, parkPaint);
    canvas.drawPath(p4, parkStrokePaint);

    // 4. Lake Austin / Colorado River Ribbon (exact SVG path from preview_map.html)
    final river = Path()
      ..moveTo(x(-20), y(360))
      ..cubicTo(x(80), y(340), x(160), y(410), x(240), y(370))
      ..cubicTo(x(310), y(330), x(360), y(380), x(420), y(360))
      ..lineTo(x(420), y(420))
      ..cubicTo(x(350), y(440), x(290), y(390), x(230), y(430))
      ..cubicTo(x(150), y(480), x(80), y(400), x(-20), y(430))
      ..close();
    canvas.drawPath(
      river,
      Paint()
        ..color = riverColor.withOpacity(0.9)
        ..style = PaintingStyle.fill,
    );

    // 5. White Architectural Highway Network (exact SVG curves)
    void drawCurvedRoad(Path path, double width) {
      canvas.drawPath(
        path,
        Paint()
          ..color = roadBorder
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = width + 2.0,
      );
      canvas.drawPath(
        path,
        Paint()
          ..color = roadColor
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = width,
      );
    }

    // Highway North-South 1 (Mopac / Loop 1)
    final r1 = Path()
      ..moveTo(x(60), y(-20))
      ..quadraticBezierTo(x(80), y(300), x(70), y(860));
    drawCurvedRoad(r1, 10.0 * sx);

    // Highway East-West (State Hwy 71 / 290)
    final r2 = Path()
      ..moveTo(x(-20), y(260))
      ..quadraticBezierTo(x(200), y(240), x(410), y(270));
    drawCurvedRoad(r2, 8.0 * sx);

    // Highway North-South 2 (I-35 Corridor)
    final r3 = Path()
      ..moveTo(x(320), y(-20))
      ..quadraticBezierTo(x(300), y(450), x(330), y(860));
    drawCurvedRoad(r3, 7.0 * sx);

    // Highway diagonal connector
    final r4 = Path()
      ..moveTo(x(180), y(860))
      ..quadraticBezierTo(x(200), y(500), x(210), y(-20));
    drawCurvedRoad(r4, 6.0 * sx);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
