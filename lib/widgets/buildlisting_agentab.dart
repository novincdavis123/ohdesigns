import 'package:flutter/material.dart';
import 'package:ohdesigns/models/listing_model.dart';
import 'package:ohdesigns/theme/app_colors.dart';

class BuildListingAgentTab extends StatelessWidget {
  const BuildListingAgentTab({super.key, required this.listing});
  final Listing listing;

  @override
  Widget build(BuildContext context) {
    final agentDetails = [
      {"label": "Name", "value": listing.agentName},
      {"label": "Office", "value": listing.agentOffice},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: agentDetails.length,
      itemBuilder: (context, index) {
        final item = agentDetails[index];
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
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70, // same width as DetailsTab for alignment
            child: Text(
              "$label:",
              style: const TextStyle(fontSize: 14, color: AppColors.primary),
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
