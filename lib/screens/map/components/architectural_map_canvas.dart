import 'dart:math' as math;
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
            // 1. Vector Map Background Custom Painter
            CustomPaint(
              size: Size(width, height),
              painter: _ArchitecturalMapPainter(),
            ),

            // 2. Interactive Map Pins
            ...pins.map((pin) {
              final isSelected = pin.estateId == selectedEstateId;
              final posX = pin.xPercent * width;
              final posY = pin.yPercent * height;

              return Positioned(
                left: posX - 44,
                top: posY - 36,
                child: GestureDetector(
                  onTap: () => onPinSelected(pin.estateId),
                  child: _MapPinBubble(
                    priceLabel: pin.priceLabel,
                    isSelected: isSelected,
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.darkFabBg : Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: isSelected
                ? null
                : Border.all(
                    color: AppColors.outlineVariant.withOpacity(0.4),
                    width: 1,
                  ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? AppColors.darkFabBg.withOpacity(0.4)
                    : Colors.black.withOpacity(0.12),
                blurRadius: isSelected ? 12 : 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                const Icon(
                  Icons.home_rounded,
                  color: Colors.white,
                  size: 14,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                priceLabel,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
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
    const canvasBg = Color(0xFFE6EFE4);
    const riverColor = Color(0xFFBADBC5);
    const zoneGreen = Color(0xFFD6EBD7);
    const roadColor = Colors.white;
    const roadBorder = Color(0xFFD0DDD0);
    const parcelColor = Color(0xFFF0F6EE);
    const parcelBorder = Color(0xFFD3E2D1);
    const gridColor = Color(0xFFD9E6D8);

    // 1. Base Canvas
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = canvasBg,
    );

    // 2. Architectural Grid Lines
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (double x = 0; x < size.width; x += 80) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 80) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 3. Circular Eco-Zoning Patches
    final zonePaint = Paint()
      ..color = zoneGreen.withOpacity(0.45)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.32),
      size.width * 0.28,
      zonePaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.82, size.height * 0.24),
      size.width * 0.22,
      Paint()
        ..color = zoneGreen.withOpacity(0.35)
        ..style = PaintingStyle.fill,
    );

    // 4. Lake Austin / Colorado River Ribbon
    final riverPath = Path()
      ..moveTo(0, size.height * 0.35)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.38,
        size.width * 0.45,
        size.height * 0.32,
        size.width * 0.65,
        size.height * 0.35,
      )
      ..cubicTo(
        size.width * 0.82,
        size.height * 0.38,
        size.width * 0.92,
        size.height * 0.33,
        size.width,
        size.height * 0.34,
      )
      ..lineTo(size.width, size.height * 0.44)
      ..cubicTo(
        size.width * 0.88,
        size.height * 0.46,
        size.width * 0.68,
        size.height * 0.44,
        size.width * 0.50,
        size.height * 0.42,
      )
      ..cubicTo(
        size.width * 0.32,
        size.height * 0.45,
        size.width * 0.15,
        size.height * 0.47,
        0,
        size.height * 0.44,
      )
      ..close();

    canvas.drawPath(
      riverPath,
      Paint()
        ..color = riverColor
        ..style = PaintingStyle.fill,
    );

    // 5. Rotated Architectural Parcels
    void drawParcel(Offset center, double width, double height, double deg) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(deg * math.pi / 180);

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: width,
        height: height,
      );

      canvas.drawRect(
        rect,
        Paint()
          ..color = parcelColor
          ..style = PaintingStyle.fill,
      );
      canvas.drawRect(
        rect,
        Paint()
          ..color = parcelBorder
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );

      canvas.restore();
    }

    drawParcel(Offset(size.width * 0.22, size.height * 0.48), 65, 50, 12);
    drawParcel(Offset(size.width * 0.72, size.height * 0.26), 70, 55, -15);
    drawParcel(Offset(size.width * 0.65, size.height * 0.52), 80, 60, 8);

    // 6. Road Highways Network
    void drawRoad(Path path, double width) {
      canvas.drawPath(
        path,
        Paint()
          ..color = roadBorder
          ..style = PaintingStyle.stroke
          ..strokeWidth = width + 2.5,
      );
      canvas.drawPath(
        path,
        Paint()
          ..color = roadColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = width,
      );
    }

    final highway1 = Path()
      ..moveTo(size.width * 0.3, 0)
      ..cubicTo(
        size.width * 0.38,
        size.height * 0.22,
        size.width * 0.55,
        size.height * 0.36,
        size.width * 0.75,
        size.height * 0.52,
      )
      ..lineTo(size.width, size.height * 0.62);
    drawRoad(highway1, 7.0);

    final highway2 = Path()
      ..moveTo(0, size.height * 0.18)
      ..cubicTo(
        size.width * 0.22,
        size.height * 0.24,
        size.width * 0.42,
        size.height * 0.28,
        size.width * 0.60,
        size.height * 0.40,
      )
      ..lineTo(size.width * 0.85, size.height * 0.65);
    drawRoad(highway2, 6.0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
