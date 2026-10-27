import 'dart:convert';
import 'dart:io';
import '../models/advisor.dart';
import '../models/estate.dart';
import '../models/filter_category.dart';
import 'mock_data.dart';

class FirestoreService {
  static const String projectId = 'project313-82c85';
  static const String apiKey = 'AIzaSyDX1KXVJiV0PVotu_GsyRQz4VM3wsrY2fo';
  static const String baseUrl =
      'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/estates';

  static Future<List<Estate>> fetchEstates() async {
    try {
      final client = HttpClient();
      final request = await client.getUrl(Uri.parse('$baseUrl?key=$apiKey'));
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final data = jsonDecode(responseBody) as Map<String, dynamic>;
        final documents = data['documents'] as List<dynamic>? ?? [];

        if (documents.isNotEmpty) {
          return documents.map((d) => _documentToEstate(d)).toList();
        }
      }
    } catch (_) {
      // Fallback to local MockData if offline or network unavailable
    }
    return [MockData.featuredEstate, ...MockData.popularEstates];
  }

  static Estate _documentToEstate(dynamic doc) {
    final fields = doc['fields'] as Map<String, dynamic>? ?? {};
    final docName = (doc['name'] as String? ?? '').split('/').last;

    String getString(String key, String def) =>
        fields[key]?['stringValue'] as String? ?? def;
    String? getOptString(String key) => fields[key]?['stringValue'] as String?;
    int? getOptInt(String key) {
      final val = fields[key]?['integerValue'];
      return val != null ? int.tryParse(val.toString()) : null;
    }
    double? getOptDouble(String key) {
      final val = fields[key]?['doubleValue'];
      return val != null ? double.tryParse(val.toString()) : null;
    }
    bool getBool(String key, bool def) =>
        fields[key]?['booleanValue'] as bool? ?? def;

    final imageKey = getString('imageKey', docName);
    final imageAsset = 'assets/$imageKey.png';

    final categoryStr = getString('category', 'VILLAS').toUpperCase();
    final category = FilterCategory.values.firstWhere(
      (c) => c.name.toUpperCase() == categoryStr,
      orElse: () => FilterCategory.villas,
    );

    final advisor = Advisor(
      name: getString('advisorName', 'Sarah Jenkins'),
      title: getString('advisorTitle', 'Principal Private Advisor'),
      division: getString('advisorDivision', 'Austin Luxury Division'),
      avatarAsset: MockData.sarahJenkins.avatarAsset,
    );

    final priceInt = getOptInt('price') ?? 3850000;

    return Estate(
      id: docName,
      title: getString('title', 'Austin Estate'),
      price: priceInt,
      formattedPrice: getString('formattedPrice', '\$$priceInt'),
      originalPrice: getOptString('originalPrice'),
      priceDropNotice: getOptString('priceDropNotice'),
      openHouseNotice: getOptString('openHouseNotice'),
      availabilityTag: getOptString('availabilityTag'),
      estimatedMonthly: getString('estimatedMonthly', 'Est. \$12,000/mo'),
      address: getString('address', 'Austin, TX'),
      beds: getOptInt('beds'),
      baths: getOptInt('baths'),
      sqft: getOptInt('sqft'),
      rating: getOptDouble('rating'),
      reviewCount: getOptInt('reviewCount'),
      imageAsset: imageAsset,
      statusTag: getOptString('statusTag'),
      areaTag: getOptString('areaTag'),
      verifiedLuxury: getBool('verifiedLuxury', false),
      isFeatured: getBool('isFeatured', false),
      category: category,
      description: getOptString('description'),
      narrative: getOptString('narrative'),
      acreage: getOptString('acreage'),
      leedRating: getOptString('leedRating'),
      terraceSpec: getOptString('terraceSpec'),
      isUnderContract: getBool('isUnderContract', false),
      photoCount: getOptInt('photoCount') ?? 4,
      isSaved: getBool('isSaved', false),
      advisor: advisor,
    );
  }
}
