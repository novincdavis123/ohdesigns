import 'package:flutter/material.dart';
import 'package:ohdesigns/models/listing_model.dart';
import 'package:ohdesigns/theme/app_colors.dart';

class BuildListingAgentTab extends StatelessWidget {
  const BuildListingAgentTab({super.key, required this.listing});
  final Listing listing;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTabletOrWeb = screenWidth > 600;

    final agentDetails = [
      {"label": "Name", "value": listing.agentName},
      {"label": "Office", "value": listing.agentOffice},
    ];

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: isTabletOrWeb ? 40 : 16,
        vertical: 16,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: agentDetails.length,
      itemBuilder: (context, index) {
        final item = agentDetails[index];
        return _labelValueRowAligned(
          context,
          item["label"]!,
          item["value"]!,
          isTabletOrWeb,
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: isTabletOrWeb ? 24 : 16,
        child: const Divider(color: AppColors.grey, thickness: 0.5),
      ),
    );
  }

  Widget _labelValueRowAligned(
    BuildContext context,
    String label,
    String value,
    bool isTabletOrWeb,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: isTabletOrWeb ? 120 : 70, // wider on bigger screens
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: isTabletOrWeb ? 16 : 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: isTabletOrWeb ? 16 : 14,
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
