import 'package:flutter/material.dart';
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
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Image.network(
        imageUrl,
        height: 150,
        width: 180,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, error, stack) {
          return Container(
            height: 180,
            color: AppColors.tertiary,
            child: const Center(child: Icon(Icons.image_not_supported)),
          );
        },
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${listing.listPrice.toString()}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: listing.status == IdcStatus.active
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    listing.status == IdcStatus.active ? "Active" : "Sold",
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
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: AppColors.primary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.bed, size: 18, color: AppColors.tertiary),
                const SizedBox(width: 4),
                Text("${listing.beds}"),
                const SizedBox(width: 16),
                Icon(Icons.bathroom, size: 18, color: AppColors.tertiary),
                const SizedBox(width: 4),
                Text("${listing.baths}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
