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
    return Scaffold(appBar: _appBar(context), body: _body());
  }

  // AppBar with back button and title/search
  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: Consumer<ListingProvider>(
        builder: (_, provider, _) => IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.secondary),
          onPressed: () {
            if (provider.isSearching) {
              provider.toggleSearch();
            } else {
              // No previous page
            }
          },
        ),
      ),
      title: Consumer<ListingProvider>(
        builder: (_, provider, _) {
          return provider.isSearching
              ? _centeredSearchBar(provider, context)
              : const Text(
                  'Listings',
                  style: TextStyle(color: AppColors.secondary),
                );
        },
      ),
      backgroundColor: AppColors.primary,
      actions: [
        Consumer<ListingProvider>(
          builder: (_, provider, _) {
            if (provider.isSearching) return const SizedBox.shrink();
            return IconButton(
              icon: const Icon(Icons.search, color: AppColors.secondary),
              onPressed: provider.toggleSearch,
            );
          },
        ),
      ],
    );
  }

  /// Responsive centered search bar
  Widget _centeredSearchBar(ListingProvider provider, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double width;

    if (screenWidth < 600) {
      width = screenWidth * 0.75; // phones
    } else if (screenWidth < 1200) {
      width = screenWidth * 0.5; // tablets
    } else {
      width = screenWidth * 0.4; // large screens
    }

    return SizedBox(width: width, height: 40, child: _searchBar(provider));
  }

  /// Search TextField
  Widget _searchBar(ListingProvider provider) {
    return TextField(
      controller: provider.searchController,
      autofocus: true,
      style: const TextStyle(color: AppColors.tertiary),
      decoration: InputDecoration(
        hintText: 'Search listings...',
        hintStyle: const TextStyle(color: AppColors.secondary),
        filled: true,
        fillColor: AppColors.lightBlue,
        suffixIcon: IconButton(
          icon: const Icon(Icons.cancel_outlined, color: AppColors.secondary),
          onPressed: provider.toggleSearch, // exits search + clears text
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onChanged: provider.search,
    );
  }

  /// Responsive body
  Widget _body() {
    return Consumer<ListingProvider>(
      builder: (context, provider, _) {
        // Loading
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // No data
        if (provider.listings.isEmpty) {
          return const Center(child: Text("No listings found"));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            // Determine columns based on screen width
            int columns = 1; // default mobile
            if (constraints.maxWidth >= 1200) {
              columns = 4; // desktop
            } else if (constraints.maxWidth >= 800) {
              columns = 3; // tablet landscape
            } else if (constraints.maxWidth >= 600) {
              columns = 2; // tablet portrait
            }

            // Use GridView for multiple columns, ListView for 1 column
            if (columns == 1) {
              return ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: provider.listings.length,
                separatorBuilder: (_, _) => const Divider(
                  color: AppColors.grey,
                  height: 1,
                  thickness: .5,
                ),
                itemBuilder: (context, index) {
                  final listing = provider.listings[index];
                  return ListingCard(
                    listing: listing,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ListingDetailPage(listing: listing),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: provider.listings.length,
                itemBuilder: (context, index) {
                  final listing = provider.listings[index];
                  return ListingCard(
                    listing: listing,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ListingDetailPage(listing: listing),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
