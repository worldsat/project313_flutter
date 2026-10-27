class MapPin {
  final String estateId;
  final String priceLabel;
  final double xPercent;
  final double yPercent;
  final double latitude;
  final double longitude;

  const MapPin({
    required this.estateId,
    required this.priceLabel,
    required this.xPercent,
    required this.yPercent,
    required this.latitude,
    required this.longitude,
  });
}
