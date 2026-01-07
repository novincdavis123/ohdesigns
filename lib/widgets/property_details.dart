import 'package:flutter/material.dart';
import 'package:ohdesigns/models/listing_model.dart';
import 'package:ohdesigns/theme/app_colors.dart';

class PropertyDetails extends StatelessWidget {
  const PropertyDetails({super.key, required this.listing});
  final Listing listing;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.bed_outlined, size: 18, color: AppColors.primary),
        const SizedBox(width: 4),
        Text("${listing.beds}"),
        const SizedBox(width: 16),
        Icon(Icons.bathtub_outlined, size: 18, color: AppColors.primary),
        const SizedBox(width: 4),
        Text("${listing.baths}"),
        const SizedBox(width: 16),
        RotatedBox(
          quarterTurns: 1,
          child: Icon(Icons.straighten, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: 4),
        Text("${listing.squareFeet} sqft"),
      ],
    );
  }
}
