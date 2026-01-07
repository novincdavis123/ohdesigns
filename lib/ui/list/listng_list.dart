import 'package:flutter/material.dart';
import 'package:ohdesigns/providers/listing_provider.dart';
import 'package:ohdesigns/theme/app_colors.dart';
import 'package:ohdesigns/ui/detail/listing_detailpage.dart';
import 'package:ohdesigns/widgets/listing_card.dart';
import 'package:provider/provider.dart';

class ListingPage extends StatelessWidget {
  const ListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appbar(), body: _body());
  }

  // AppBar with back button and title
  AppBar _appbar() => AppBar(
    leading: Icon(Icons.arrow_back, color: AppColors.secondary),
    title: const Text('Listings', style: TextStyle(color: AppColors.secondary)),
    backgroundColor: AppColors.primary,
    actions: [
      IconButton(
        icon: const Icon(Icons.search),
        color: AppColors.secondary,
        onPressed: () {},
      ),
    ],
  );

  // Body with listing cards
  Consumer<ListingProvider> _body() {
    return Consumer<ListingProvider>(
      builder: (context, provider, child) {
        // Still loading
        if (provider.isLoading) {
          return SizedBox(
            width: 200,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        // No data after loading
        if (provider.listings.isEmpty) {
          return const Center(child: Text("No listings found"));
        }

        // Show data
        return ListView.separated(
          padding: EdgeInsets.all(10),
          itemCount: provider.listings.length,
          separatorBuilder: (context, index) =>
              const Divider(color: AppColors.grey, height: 1, thickness: .5),
          itemBuilder: (context, index) {
            final listing = provider.listings[index];
            return ListingCard(
              listing: listing,
              onTap: () {
                // navigate to detail page later
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListingDetailPage(listing: listing),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
