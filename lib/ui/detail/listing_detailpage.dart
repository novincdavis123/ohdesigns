import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ohdesigns/models/listing_model.dart';
import 'package:ohdesigns/providers/listing_provider.dart';
import 'package:ohdesigns/theme/app_colors.dart';
import 'package:ohdesigns/utils/currency_formatter.dart';
import 'package:ohdesigns/widgets/buildlisting_agentab.dart';
import 'package:ohdesigns/widgets/details_tab.dart';
import 'package:ohdesigns/widgets/property_details.dart';
import 'package:provider/provider.dart';

class ListingDetailPage extends StatelessWidget {
  const ListingDetailPage({required this.listing, super.key});
  final Listing listing;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _body(context)));
  }

  SingleChildScrollView _body(BuildContext context) {
    // Reset current image index for this listing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ListingProvider>(context, listen: false).resetImageIndex();
    });
    final screenWidth = MediaQuery.of(context).size.width;
    final isTabletOrWeb = screenWidth > 600;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Image Gallery ---
          Stack(
            children: [
              _buildImageGallery(context, isTabletOrWeb),
              _buildBackButton(context),
              _buildPropertyTypeLabel(screenWidth),
              _buildShareButton(),
            ],
          ),
          const SizedBox(height: 16),

          // --- Basic Info Section ---
          _buildBasicInfo(context, screenWidth),
          const SizedBox(height: 16),

          // --- Tabs Section ---
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  dividerColor: AppColors.secondary,
                  unselectedLabelColor: AppColors.grey,
                  indicatorColor: AppColors.primary,
                  tabs: const [
                    Tab(text: 'Details'),
                    Tab(text: 'Listing Agent'),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: isTabletOrWeb ? 500 : 300,
                  child: TabBarView(
                    children: [
                      DetailsTab(listing: listing),
                      BuildListingAgentTab(listing: listing),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery(BuildContext context, bool isTabletOrWeb) {
    final height = isTabletOrWeb ? 400.0 : 250.0;

    return Stack(
      children: [
        SizedBox(
          height: height,
          width: double.infinity,
          child: PageView.builder(
            itemCount: listing.images.length,
            onPageChanged: (index) {
              Provider.of<ListingProvider>(
                context,
                listen: false,
              ).updateImageIndex(index);
            },

            itemBuilder: (context, index) {
              final imageUrl = listing.images[index];
              return CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.tertiary,
                  child: Icon(
                    Icons.broken_image,
                    size: isTabletOrWeb ? 220 : 180,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),

        Positioned(
          bottom: 8,
          right: 12,
          child: Consumer<ListingProvider>(
            builder: (context, provider, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${provider.currentImageIndex + 1}/${listing.images.length}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8),
    child: CircleAvatar(
      backgroundColor: AppColors.secondary,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
  );

  Widget _buildPropertyTypeLabel(double screenWidth) => Positioned(
    top: 16,
    left: screenWidth * 0.25, // responsive left
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.secondary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
        child: Text(
          'MLS# ${listing.mlsNumber}',
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );

  Widget _buildShareButton() => Positioned(
    top: 16,
    right: 20,
    child: CircleAvatar(
      backgroundColor: AppColors.secondary,
      child: IconButton(
        icon: const Icon(Icons.share, color: AppColors.primary),
        onPressed: () {},
      ),
    ),
  );

  Widget _buildBasicInfo(BuildContext context, double screenWidth) {
    final isTabletOrWeb = screenWidth > 600;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTabletOrWeb ? 40 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 15),
            child: Row(
              children: [
                Text(
                  '\$ ${getcurrencyFormat(listing.listPrice)}',
                  style: TextStyle(
                    fontSize: isTabletOrWeb ? 32 : 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.tertiary,
                  ),
                ),
                const SizedBox(width: 13),
                Text(
                  listing.propertyType,
                  style: TextStyle(
                    fontSize: isTabletOrWeb ? 18 : 14,
                    color: AppColors.darkGrey,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: isTabletOrWeb ? 8 : 4,
                    horizontal: isTabletOrWeb ? 30 : 20,
                  ),
                  child: Text(
                    " Coming Soon",
                    style: TextStyle(
                      fontSize: isTabletOrWeb ? 14 : 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: screenWidth / 2,
              child: Text(
                listing.fullAddress,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.darkGrey,
                  fontSize: isTabletOrWeb ? 16 : 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: PropertyDetails(listing: listing),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _textTheme(Icons.public, "View on website", isTabletOrWeb),
                _textTheme(Icons.location_on, "View on map", isTabletOrWeb),
              ],
            ),
          ),
          Divider(color: AppColors.darkGrey, height: 40, thickness: .5),
        ],
      ),
    );
  }

  Row _textTheme(IconData iconData, String text, bool isTabletOrWeb) => Row(
    children: [
      Icon(iconData, color: AppColors.primary, size: isTabletOrWeb ? 20 : 18),
      const SizedBox(width: 4),
      Text(
        text,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: isTabletOrWeb ? 14 : 12,
        ),
      ),
    ],
  );
}
