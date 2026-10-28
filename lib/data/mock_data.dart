import '../models/advisor.dart';
import '../models/estate.dart';
import '../models/filter_category.dart';
import '../models/map_pin.dart';

class MockData {
  static const Advisor sarahJenkins = Advisor(
    name: 'Sarah Jenkins',
    title: 'Principal Private Advisor',
    division: 'Austin Luxury Division',
    avatarAsset: 'assets/agent.png',
    licenseId: 'TX-RE #782910',
  );

  static const String userAvatar = 'assets/female_luxury.png';

  static const Estate featuredEstate = Estate(
    id: 'the-glass-pavilions',
    title: 'The Glass Pavilions, Westlake',
    price: 3850000,
    formattedPrice: r'$3,850,000',
    estimatedMonthly: r'Est. $18,420/mo',
    address: '4420 Scenic Bluff Way, Westlake Hills',
    beds: 5,
    baths: 6,
    sqft: 5400,
    rating: 4.95,
    reviewCount: 38,
    imageAsset: 'assets/architectural_photograph_of_the_glass.png',
    statusTag: 'Exclusive Reserve',
    areaTag: 'Westlake Hills',
    verifiedLuxury: true,
    isFeatured: true,
    category: FilterCategory.villas,
    description:
        'A masterclass in modern transparency and limestone craftsmanship perched high above Lake Austin.',
    advisor: sarahJenkins,
    acreage: '1.8 Acres',
    leedRating: 'LEED Platinum',
    narrative:
        'Perched dramatically above Lake Austin, The Glass Pavilions embodies sustainable luxury through structural purity and environmental harmony. Characterized by expansive cantilevered glass volumes, rammed-earth accents, and locally quarried Westlake limestone, this sanctuary integrates seamless indoor-outdoor living with native drought-tolerant gardens and a negative-edge reflection pool.',
    photoCount: 4,
    activePhotoIndex: 0,
    isSaved: true,
  );

  static const List<Estate> popularEstates = [
    Estate(
      id: 'emerald-grove-residence',
      title: 'Emerald Grove Residence',
      price: 2450000,
      formattedPrice: r'$2,450,000',
      estimatedMonthly: r'Est. $11,200/mo',
      address: '7804 Spyglass Peak, Austin, TX 78746',
      beds: 4,
      baths: 4,
      sqft: 3900,
      imageAsset: 'assets/emerald_grove.png',
      statusTag: 'For Sale',
      areaTag: 'Austin Greenbelt',
      category: FilterCategory.villas,
      description:
          'Nestled alongside Barton Creek preserve, featuring terraced living, native flora, and infinity-edge reflection pool.',
      advisor: sarahJenkins,
      photoCount: 4,
      activePhotoIndex: 0,
    ),
    Estate(
      id: 'the-cedar-ridge-villa',
      title: 'The Cedar Ridge Villa',
      price: 1890000,
      formattedPrice: r'$1,890,000',
      estimatedMonthly: r'Est. $8,660/mo',
      address: '1204 Sunset View Terrace, Travis Heights',
      beds: 3,
      baths: 3,
      sqft: 2850,
      imageAsset: 'assets/modern_luxury.png',
      statusTag: 'New Listing',
      areaTag: 'Travis Heights',
      category: FilterCategory.villas,
      description:
          'Warm western red cedar craftsmanship coupled with architectural standing seam steel roof in vibrant Travis Heights.',
      advisor: sarahJenkins,
      photoCount: 4,
      activePhotoIndex: 0,
    ),
    Estate(
      id: 'skyline-botanica-penthouse',
      title: 'Skyline Botanica Penthouse',
      price: 4200000,
      formattedPrice: r'$4,200,000',
      estimatedMonthly: r'Est. $19,800/mo',
      address: '200 Congress Avenue #3801, Downtown',
      beds: 4,
      baths: 5,
      sqft: 4800,
      imageAsset: 'assets/botanica_luxury.png',
      statusTag: 'For Sale',
      areaTag: 'Downtown Austin',
      category: FilterCategory.penthouses,
      description:
          'Panoramic sunset vistas over Lady Bird Lake and the downtown skyline from a multi-level botanical terrace.',
      advisor: sarahJenkins,
      photoCount: 5,
      activePhotoIndex: 0,
    ),
    Estate(
      id: 'oakwood-sanctuary-cottage',
      title: 'Oakwood Sanctuary Cottage',
      price: 1650000,
      formattedPrice: r'$1,650,000',
      estimatedMonthly: r'Est. $7,400/mo',
      address: '2206 Exposition Blvd, Tarrytown',
      beds: 3,
      baths: 2,
      sqft: 2200,
      imageAsset: 'assets/sanctuary_cottage_in.png',
      statusTag: 'For Sale',
      areaTag: 'Tarrytown',
      category: FilterCategory.ecoHomes,
      description:
          'Preserved heritage live oaks frame this restored Austin limestone retreat with modern eco-certified retrofits.',
      advisor: sarahJenkins,
      photoCount: 3,
      activePhotoIndex: 0,
    ),
  ];

  static const List<Estate> savedEstates = [
    Estate(
      id: 'the-glass-pavilions',
      title: 'The Glass Pavilions',
      price: 3850000,
      formattedPrice: r'$3,850,000',
      originalPrice: r'$3,900,000',
      priceDropNotice: r'↓ -$50,000 this week',
      openHouseNotice: 'Open Sat 2:00 PM',
      estimatedMonthly: r'Est. $18,420/mo',
      address: 'Westlake Hills, Austin, TX',
      beds: 5,
      baths: 6,
      sqft: 5400,
      imageAsset: 'assets/architectural_photograph_of_the_glass.png',
      verifiedLuxury: true,
      isFeatured: true,
      category: FilterCategory.villas,
      advisor: sarahJenkins,
      isSaved: true,
    ),
    Estate(
      id: 'emerald-grove-residence',
      title: 'Emerald Grove Residence',
      price: 2450000,
      formattedPrice: r'$2,450,000',
      availabilityTag: 'Available',
      estimatedMonthly: r'Est. $11,200/mo',
      address: 'Barton Creek Preserve, Austin, TX',
      beds: 4,
      baths: 4,
      sqft: 4120,
      imageAsset: 'assets/emerald_grove.png',
      category: FilterCategory.villas,
      advisor: sarahJenkins,
      isSaved: true,
    ),
    Estate(
      id: 'skyline-botanica-penthouse',
      title: 'Skyline Botanica Penthouse',
      price: 4200000,
      formattedPrice: r'$4,200,000',
      availabilityTag: 'Under Contract',
      isUnderContract: true,
      estimatedMonthly: r'Est. $19,800/mo',
      address: 'Rainey District, Downtown Austin, TX',
      beds: 4,
      baths: 5,
      terraceSpec: 'Terrace',
      imageAsset: 'assets/botanica_luxury.png',
      category: FilterCategory.penthouses,
      advisor: sarahJenkins,
      isSaved: true,
    ),
    Estate(
      id: 'oakwood-sanctuary-cottage',
      title: 'Oakwood Sanctuary Cottage',
      price: 1150000,
      formattedPrice: r'$1,150,000',
      availabilityTag: 'New Price',
      estimatedMonthly: r'Est. $5,400/mo',
      address: 'Tarrytown, Austin, TX',
      beds: 3,
      baths: 2,
      acreage: '0.45 Acres',
      imageAsset: 'assets/sanctuary_cottage_in.png',
      category: FilterCategory.ecoHomes,
      advisor: sarahJenkins,
      isSaved: true,
    ),
  ];

  static const List<MapPin> mapPins = [
    MapPin(
      estateId: 'the-glass-pavilions',
      priceLabel: r'$3.85M',
      xPercent: 0.38,
      yPercent: 0.28,
      latitude: 30.2985,
      longitude: -97.8050,
    ),
    MapPin(
      estateId: 'emerald-grove-residence',
      priceLabel: r'$2.45M',
      xPercent: 0.18,
      yPercent: 0.22,
      latitude: 30.2540,
      longitude: -97.8220,
    ),
    MapPin(
      estateId: 'the-cedar-ridge-villa',
      priceLabel: r'$1.89M',
      xPercent: 0.78,
      yPercent: 0.21,
      latitude: 30.2485,
      longitude: -97.7485,
    ),
    MapPin(
      estateId: 'skyline-botanica-penthouse',
      priceLabel: r'$4.20M',
      xPercent: 0.68,
      yPercent: 0.38,
      latitude: 30.2610,
      longitude: -97.7405,
    ),
    MapPin(
      estateId: 'oakwood-sanctuary-cottage',
      priceLabel: r'$1.45M',
      xPercent: 0.24,
      yPercent: 0.46,
      latitude: 30.3010,
      longitude: -97.7660,
    ),
  ];

  static Estate getEstateById(String id) {
    if (id == featuredEstate.id) return featuredEstate;
    try {
      return savedEstates.firstWhere((e) => e.id == id);
    } catch (_) {
      try {
        return popularEstates.firstWhere((e) => e.id == id);
      } catch (_) {
        return featuredEstate;
      }
    }
  }
}
