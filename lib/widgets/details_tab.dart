import 'package:flutter/material.dart';
import 'package:ohdesigns/models/listing_model.dart';
import 'package:ohdesigns/theme/app_colors.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab({super.key, required this.listing});
  final Listing listing;

  @override
  Widget build(BuildContext context) {
    final details = [
      {"label": "MLS#", "value": listing.mlsNumber},
      {"label": "Property Type", "value": listing.propertyType},
      {"label": "Status", "value": listing.status},
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: details.length,
      itemBuilder: (context, index) {
        final item = details[index];
        return _labelValueRowAligned(item["label"]!, item["value"]!);
      },
      separatorBuilder: (context, index) => const Divider(
        color: AppColors.grey,
        thickness: 0.5,
        height: 16, // spacing between rows
      ),
    );
  }

  Widget _labelValueRowAligned(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // fixed width for label column
          SizedBox(
            width: 120, // adjust width as needed
            child: Text(
              "$label:",
              style: const TextStyle(fontSize: 14, color: AppColors.tertiary),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
