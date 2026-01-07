import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/listing_model.dart';
import '../theme/app_colors.dart';

class ListingCard extends StatelessWidget {
  const ListingCard({required this.listing, required this.onTap, super.key});
  final Listing listing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildImageSection(), _buildInfoSection(context)],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    final imageUrl = listing.images.isNotEmpty
        ? listing.images.first
        : "https://via.placeholder.com/400"; // fallback

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Image.network(
        imageUrl,
        height: 150,
        width: 180,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const SizedBox(
            height: 180,
            width: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, error, stack) {
          // Show a placeholder icon on error
          return Icon(Icons.broken_image, size: 180, color: Colors.grey);
        },
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    final format = NumberFormat('#,##,###'); // Indian style
    final price = format.format(listing.listPrice);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 210,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ $price',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: listing.status == "Active"
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    listing.status == "Active" ? "Active" : "Sold",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              listing.fullAddress,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.darkGrey,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
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
          ],
        ),
      ),
    );
  }
}
