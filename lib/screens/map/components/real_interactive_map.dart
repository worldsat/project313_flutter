import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/map_pin.dart';

enum MapLayerType {
  street(
    'Standard Map (OSM)',
    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  ),
  topo(
    'Topographic / Terrain',
    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}',
  ),
  satellite(
    'Satellite Imagery',
    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
  );

  final String displayName;
  final String urlTemplate;
  const MapLayerType(this.displayName, this.urlTemplate);
}

class RealInteractiveMap extends StatefulWidget {
  final List<MapPin> pins;
  final String selectedEstateId;
  final ValueChanged<String> onPinSelected;
  final MapLayerType layerType;
  final MapController? mapController;

  const RealInteractiveMap({
    super.key,
    required this.pins,
    required this.selectedEstateId,
    required this.onPinSelected,
    this.layerType = MapLayerType.street,
    this.mapController,
  });

  @override
  State<RealInteractiveMap> createState() => _RealInteractiveMapState();
}

class _RealInteractiveMapState extends State<RealInteractiveMap>
    with TickerProviderStateMixin {
  late final MapController _mapController;
  static const LatLng _austinCenter = LatLng(30.2780, -97.7780);

  @override
  void initState() {
    super.initState();
    _mapController = widget.mapController ?? MapController();
  }

  @override
  void didUpdateWidget(covariant RealInteractiveMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedEstateId != widget.selectedEstateId) {
      _centerOnSelectedPin();
    }
  }

  void _centerOnSelectedPin() {
    final pin = widget.pins.firstWhere(
      (p) => p.estateId == widget.selectedEstateId,
      orElse: () => widget.pins.first,
    );
    _animatedMapMove(LatLng(pin.latitude, pin.longitude), 13.5);
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final camera = _mapController.camera;
    final latTween = Tween<double>(
      begin: camera.center.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: camera.center.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(
      begin: camera.zoom,
      end: destZoom,
    );

    final controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    final Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCubic,
    );

    controller.addListener(() {
      _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEBF2EC),
      child: FlutterMap(
        mapController: _mapController,
        options: const MapOptions(
          initialCenter: _austinCenter,
          initialZoom: 12.5,
          minZoom: 10.0,
          maxZoom: 18.0,
          interactionOptions: InteractionOptions(
            flags: InteractiveFlag.all,
          ),
        ),
        children: [
          TileLayer(
            key: ValueKey(widget.layerType),
            urlTemplate: widget.layerType.urlTemplate,
            userAgentPackageName: 'com.example.project313',
            maxZoom: 19,
          ),
          MarkerLayer(
            markers: widget.pins.map((pin) {
              final isSelected = pin.estateId == widget.selectedEstateId;
              return Marker(
                point: LatLng(pin.latitude, pin.longitude),
                width: isSelected ? 110 : 92,
                height: 44,
                alignment: Alignment.center,
                child: _buildPricePill(pin, isSelected),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPricePill(MapPin pin, bool isSelected) {
    return GestureDetector(
      onTap: () {
        widget.onPinSelected(pin.estateId);
        _animatedMapMove(LatLng(pin.latitude, pin.longitude), 13.5);
      },
      child: AnimatedScale(
        scale: isSelected ? 1.08 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 12 : 10,
            vertical: isSelected ? 6 : 5,
          ),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1B4332) : Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: isSelected ? const Color(0xFF52B788) : const Color(0xFF2D6A4F),
              width: isSelected ? 2.0 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? const Color(0x661B4332)
                    : Colors.black.withOpacity(0.18),
                blurRadius: isSelected ? 14 : 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected) ...[
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFF52B788),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
              ],
              Text(
                pin.priceLabel,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF1B4332),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

