class Advisor {
  final String name;
  final String title;
  final String division;
  final String avatarAsset;
  final String? licenseId;

  const Advisor({
    required this.name,
    required this.title,
    required this.division,
    required this.avatarAsset,
    this.licenseId,
  });
}
