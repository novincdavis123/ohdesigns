import 'package:flutter/material.dart';
import 'package:ohdesigns/models/listing_model.dart';
import 'package:ohdesigns/providers/listing_provider.dart';
import 'package:ohdesigns/theme/app_colors.dart';
import 'package:provider/provider.dart';

class ListingDetailPage extends StatelessWidget {
  const ListingDetailPage({required this.listing, super.key});
  final Listing listing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body(context));
  }

  // AppBar with back button and title
  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      iconTheme: IconThemeData(color: AppColors.secondary),
      title: Text(
        listing.fullAddress,
        style: TextStyle(color: AppColors.secondary),
      ),
    );
  }

  // Body with image gallery and details
  SingleChildScrollView _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageGallery(context, listing),
          const SizedBox(height: 16),
          _buildBasicInfo(),
          const SizedBox(height: 16),
          _buildDetailsSection(),
        ],
      ),
    );
  }

  Widget _buildImageGallery(BuildContext context, Listing listing) {
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
                  child: const Icon(Icons.image_not_supported),
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

  Widget _buildBasicInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\$${listing.listPrice}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            listing.remarks.isNotEmpty
                ? listing.remarks
                : "No description available",
            style: TextStyle(color: AppColors.secondary),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
