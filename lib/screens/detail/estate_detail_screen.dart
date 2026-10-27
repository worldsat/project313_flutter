import 'package:flutter/material.dart';
import '../../controllers/estate_controller.dart';
import '../../data/mock_data.dart';
import '../../models/estate.dart';
import '../../theme/app_colors.dart';

class EstateDetailScreen extends StatefulWidget {
  final String estateId;
  final EstateController controller;

  const EstateDetailScreen({
    super.key,
    required this.estateId,
    required this.controller,
  });

  @override
  State<EstateDetailScreen> createState() => _EstateDetailScreenState();
}

class _EstateDetailScreenState extends State<EstateDetailScreen> {
  bool _isExpanded = false;

  final List<String> _features = const [
    'Solar Array & Tesla Powerwall',
    'Rainwater Harvesting (20k Gal)',
    'Geothermal HVAC System',
    'Sub-Zero & Miele Kitchen Suite',
    '12-Car Architectural Gallery',
    'Private Lake Austin Boat Dock',
    'Zero-Edge Negative Pool',
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final estate = MockData.getEstateById(widget.estateId);
        final isSaved = widget.controller.isEstateSaved(estate.id);

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              // 1. Scrollable Content
              CustomScrollView(
                slivers: [
                  // Hero Header Image & Floating Controls
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        // Image Banner
                        SliverHeroBanner(estate: estate),

                        // Top Controls Overlay
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 8,
                          left: 16,
                          right: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Back Button
                              _CircleBlurButton(
                                icon: Icons.arrow_back_rounded,
                                onTap: () => Navigator.of(context).pop(),
                              ),

                              // Right Actions
                              Row(
                                children: [
                                  _CircleBlurButton(
                                    icon: isSaved
                                        ? Icons.favorite
                                        : Icons.favorite_border_rounded,
                                    iconColor: isSaved
                                        ? const Color(0xFFD32F2F)
                                        : AppColors.onSurface,
                                    onTap: () {
                                      widget.controller.toggleSave(estate.id);
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  _CircleBlurButton(
                                    icon: Icons.share_outlined,
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Property link copied to clipboard'),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Photo Counter Badge
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.photo_library_outlined,
                                  color: Colors.white,
                                  size: 13,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '1 of ${estate.photoCount}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content Body
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status & Area Badges
                          Row(
                            children: [
                              if (estate.statusTag != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryContainer,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    estate.statusTag!,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              if (estate.areaTag != null) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainerLow,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    estate.areaTag!,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Estate Title
                          Text(
                            estate.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.onSurface,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Address
                          Row(
                            children: [
                              const Icon(
                                Icons.near_me_outlined,
                                size: 14,
                                color: AppColors.outline,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  estate.address,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.outline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Price Line
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                estate.formattedPrice,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                estate.estimatedMonthly,
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  color: AppColors.outline,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          // Key Specs Box
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: AppColors.outlineVariant.withOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _SpecItem(
                                  icon: Icons.bed_outlined,
                                  val: '${estate.beds ?? 4}',
                                  lbl: 'Beds',
                                ),
                                _Divider(),
                                _SpecItem(
                                  icon: Icons.bathtub_outlined,
                                  val: '${estate.baths ?? 4}',
                                  lbl: 'Baths',
                                ),
                                _Divider(),
                                _SpecItem(
                                  icon: Icons.square_foot_rounded,
                                  val: '${estate.sqft ?? 3900}',
                                  lbl: 'sqft',
                                ),
                                if (estate.acreage != null) ...[
                                  _Divider(),
                                  _SpecItem(
                                    icon: Icons.landscape_outlined,
                                    val: estate.acreage!,
                                    lbl: 'Lot',
                                  ),
                                ],
                                if (estate.leedRating != null) ...[
                                  _Divider(),
                                  _SpecItem(
                                    icon: Icons.eco_outlined,
                                    val: estate.leedRating!,
                                    lbl: 'Rating',
                                    valColor: AppColors.primary,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Architectural Narrative
                          const Text(
                            'Architectural Narrative',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            estate.narrative ?? estate.description ?? '',
                            maxLines: _isExpanded ? null : 4,
                            overflow: _isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13.5,
                              height: 1.55,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                _isExpanded ? 'Read less' : 'Read more',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Curated Features
                          const Text(
                            'Curated Amenities & Eco-Specs',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _features.map((feature) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 7),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: AppColors.outlineVariant
                                        .withOpacity(0.5),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline,
                                      size: 14,
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      feature,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),

                          // Private Advisor Card
                          const Text(
                            'Dedicated Private Advisor',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.outlineVariant.withOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    MockData.sarahJenkins.avatarAsset,
                                    width: 52,
                                    height: 52,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        MockData.sarahJenkins.name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        MockData.sarahJenkins.title,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.outline,
                                        ),
                                      ),
                                      Text(
                                        MockData.sarahJenkins.division,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Connecting with ${MockData.sarahJenkins.name}...'),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                  ),
                                  child: const Text(
                                    'Contact',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // 2. Fixed Bottom Booking Bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    12,
                    16,
                    MediaQuery.of(context).padding.bottom + 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: AppColors.outlineVariant.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Offered At',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.outline,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            estate.formattedPrice,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Private tour request sent for ${estate.title}!'),
                                  backgroundColor: AppColors.primary,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkFabBg,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              'Schedule Private Tour',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SliverHeroBanner extends StatelessWidget {
  final Estate estate;

  const SliverHeroBanner({super.key, required this.estate});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Image.asset(
        estate.imageAsset,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _CircleBlurButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const _CircleBlurButton({
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.88),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: iconColor ?? AppColors.onSurface,
        ),
      ),
    );
  }
}

class _SpecItem extends StatelessWidget {
  final IconData icon;
  final String val;
  final String lbl;
  final Color? valColor;

  const _SpecItem({
    required this.icon,
    required this.val,
    required this.lbl,
    this.valColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.outline),
        const SizedBox(height: 4),
        Text(
          val,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: valColor ?? AppColors.onSurface,
          ),
        ),
        Text(
          lbl,
          style: const TextStyle(fontSize: 10.5, color: AppColors.outline),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 28,
      color: AppColors.outlineVariant.withOpacity(0.4),
    );
  }
}
