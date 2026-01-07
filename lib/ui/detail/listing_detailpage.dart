import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ohdesigns/models/listing_model.dart';
import 'package:ohdesigns/providers/listing_provider.dart';
import 'package:ohdesigns/theme/app_colors.dart';
import 'package:ohdesigns/widgets/buildlisting_agentab.dart';
import 'package:ohdesigns/widgets/details_tab.dart';
import 'package:provider/provider.dart';

class ListingDetailPage extends StatelessWidget {
  const ListingDetailPage({required this.listing, super.key});
  final Listing listing;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _body(context)));
  }

  // Body with image gallery and details
  SingleChildScrollView _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Image Gallery ---
          Stack(
            children: [
              _buildImageGallery(context),
              _buildBackButton(context),
              _buildPropertyTypeLabel(),
              _buildShareButton(),
            ],
          ),
          const SizedBox(height: 16),

          // --- Basic Info Section ---
          _buildBasicInfo(context),
          const SizedBox(height: 16),

          // --- Tabs Section ---
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                // Tab Bar
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

                // Tab Views
                SizedBox(
                  height: 300,
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

  Widget _buildImageGallery(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: PageView.builder(
            itemCount: listing.images.length,
            onPageChanged: (index) {
              // update via provider
              Provider.of<ListingProvider>(
                context,
                listen: false,
              ).updateImageIndex(index);
            },
            itemBuilder: (context, index) {
              final imageUrl = listing.images[index];
              return Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, _, __) => Container(
                  color: AppColors.tertiary,
                  child: Icon(
                    Icons.broken_image,
                    size: 180,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),

        // Positioned at bottom right
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

  Widget _buildPropertyTypeLabel() => Positioned(
    top: 8,
    left: 80,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
    top: 8,
    right: 20,
    child: CircleAvatar(
      backgroundColor: AppColors.secondary,
      child: IconButton(
        icon: const Icon(Icons.share, color: AppColors.primary),
        onPressed: () {},
      ),
    ),
  );

  Widget _buildBasicInfo(BuildContext context) {
    final format = NumberFormat('#,##,###'); // Indian style
    final price = format.format(listing.listPrice);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Text(
                  '\$ $price',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.tertiary,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  listing.propertyType,
                  style: TextStyle(fontSize: 16, color: AppColors.darkGrey),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    " Coming Soon",
                    style: TextStyle(fontSize: 12, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              listing.fullAddress,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.darkGrey,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Icon(Icons.bed_outlined, size: 18, color: AppColors.primary),
                const SizedBox(width: 4),
                Text("${listing.beds}"),
                const SizedBox(width: 16),
                Icon(
                  Icons.bathtub_outlined,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                Text("${listing.baths}"),
                const SizedBox(width: 16),
                RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.straighten,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 4),
                Text("${listing.squareFeet} sqft"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _texttheme(Icons.public, "View on website"),
                _texttheme(Icons.location_on, "View on map"),
              ],
            ),
          ),
          Divider(color: AppColors.darkGrey, height: 40, thickness: .5),
        ],
      ),
    );
  }

  Row _texttheme(IconData iconData, String text) => Row(
    children: [
      Icon(iconData, color: AppColors.primary),
      const SizedBox(width: 4),
      Text(text, style: TextStyle(color: AppColors.primary)),
    ],
  );
}
