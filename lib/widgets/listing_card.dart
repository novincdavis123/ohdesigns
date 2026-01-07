import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ohdesigns/utils/currency_formatter.dart';
import 'package:ohdesigns/widgets/property_details.dart';
import '../models/listing_model.dart';
import '../theme/app_colors.dart';

class ListingCard extends StatelessWidget {
  const ListingCard({required this.listing, required this.onTap, super.key});
  final Listing listing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;

            // Adjust sizes based on available width
            final imageWidth = screenWidth < 600
                ? 170.0
                : screenWidth < 900
                ? 220.0
                : 260.0;
            final imageHeight = imageWidth * 0.66; // 3:2 ratio

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageSection(imageWidth, imageHeight),
                const SizedBox(width: 10),
                Expanded(child: _buildInfoSection(context)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageSection(double width, double height) {
    final imageUrl = listing.images.isNotEmpty
        ? listing.images.first
        : "https://via.placeholder.com/400";

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => SizedBox(
          width: width,
          height: height,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => SizedBox(
          width: width,
          height: height,
          child: Icon(Icons.broken_image, size: width / 2, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price + Status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                '\$ ${getcurrencyFormat(listing.listPrice)}',

                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.tertiary,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
              decoration: BoxDecoration(
                color: listing.status == "Active"
                    ? AppColors.lightBlue
                    : Colors.pink[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                listing.status == "Active" ? "Active" : "Sold",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Address
        Text(
          listing.fullAddress,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.darkGrey,
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        // Property details
        PropertyDetails(listing: listing),
      ],
    );
  }
}
