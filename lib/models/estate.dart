import 'advisor.dart';
import 'filter_category.dart';

class Estate {
  final String id;
  final String title;
  final int price;
  final String formattedPrice;
  final String estimatedMonthly;
  final String address;
  final int? beds;
  final int? baths;
  final int? sqft;
  final double? rating;
  final int? reviewCount;
  final String imageAsset;
  final String? statusTag;
  final String? areaTag;
  final bool verifiedLuxury;
  final bool isFeatured;
  final FilterCategory category;
  final String? description;
  final Advisor? advisor;
  final String? acreage;
  final String? leedRating;
  final String? narrative;
  final String? originalPrice;
  final String? priceDropNotice;
  final String? openHouseNotice;
  final String? availabilityTag;
  final String? terraceSpec;
  final bool isUnderContract;
  final int photoCount;
  final int activePhotoIndex;
  final bool isSaved;

  const Estate({
    required this.id,
    required this.title,
    required this.price,
    required this.formattedPrice,
    required this.estimatedMonthly,
    required this.address,
    this.beds,
    this.baths,
    this.sqft,
    this.rating,
    this.reviewCount,
    required this.imageAsset,
    this.statusTag,
    this.areaTag,
    this.verifiedLuxury = false,
    this.isFeatured = false,
    this.category = FilterCategory.villas,
    this.description,
    this.advisor,
    this.acreage,
    this.leedRating,
    this.narrative,
    this.originalPrice,
    this.priceDropNotice,
    this.openHouseNotice,
    this.availabilityTag,
    this.terraceSpec,
    this.isUnderContract = false,
    this.photoCount = 4,
    this.activePhotoIndex = 0,
    this.isSaved = false,
  });

  Estate copyWith({
    String? id,
    String? title,
    int? price,
    String? formattedPrice,
    String? estimatedMonthly,
    String? address,
    int? beds,
    int? baths,
    int? sqft,
    double? rating,
    int? reviewCount,
    String? imageAsset,
    String? statusTag,
    String? areaTag,
    bool? verifiedLuxury,
    bool? isFeatured,
    FilterCategory? category,
    String? description,
    Advisor? advisor,
    String? acreage,
    String? leedRating,
    String? narrative,
    String? originalPrice,
    String? priceDropNotice,
    String? openHouseNotice,
    String? availabilityTag,
    String? terraceSpec,
    bool? isUnderContract,
    int? photoCount,
    int? activePhotoIndex,
    bool? isSaved,
  }) {
    return Estate(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      formattedPrice: formattedPrice ?? this.formattedPrice,
      estimatedMonthly: estimatedMonthly ?? this.estimatedMonthly,
      address: address ?? this.address,
      beds: beds ?? this.beds,
      baths: baths ?? this.baths,
      sqft: sqft ?? this.sqft,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      imageAsset: imageAsset ?? this.imageAsset,
      statusTag: statusTag ?? this.statusTag,
      areaTag: areaTag ?? this.areaTag,
      verifiedLuxury: verifiedLuxury ?? this.verifiedLuxury,
      isFeatured: isFeatured ?? this.isFeatured,
      category: category ?? this.category,
      description: description ?? this.description,
      advisor: advisor ?? this.advisor,
      acreage: acreage ?? this.acreage,
      leedRating: leedRating ?? this.leedRating,
      narrative: narrative ?? this.narrative,
      originalPrice: originalPrice ?? this.originalPrice,
      priceDropNotice: priceDropNotice ?? this.priceDropNotice,
      openHouseNotice: openHouseNotice ?? this.openHouseNotice,
      availabilityTag: availabilityTag ?? this.availabilityTag,
      terraceSpec: terraceSpec ?? this.terraceSpec,
      isUnderContract: isUnderContract ?? this.isUnderContract,
      photoCount: photoCount ?? this.photoCount,
      activePhotoIndex: activePhotoIndex ?? this.activePhotoIndex,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
