import 'package:flutter/material.dart';
import 'package:ohdesigns/models/listing_model.dart';
import 'package:ohdesigns/services/listing_respository.dart';

class ListingProvider extends ChangeNotifier {
  ListingProvider({required this.repository});

  final ListingRepository repository;

  /// Original data
  List<Listing> _allListings = [];
  List<Listing> listings = [];

  bool isLoading = false;
  String? error;

  /// Detail page image index
  int currentImageIndex = 0;

  ///  Search state
  bool _isSearching = false;
  bool get isSearching => _isSearching;

  final TextEditingController searchController = TextEditingController();

  // Data loading
  Future<void> loadListings() async {
    try {
      isLoading = true;
      notifyListeners();

      _allListings = await repository.loadListings();
      listings = _allListings;
      error = null;
    } catch (e) {
      error = "Failed to load listings";
      listings = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Search handling
  void toggleSearch() {
    _isSearching = !_isSearching;

    if (!_isSearching) {
      clearSearch();
    }

    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    listings = _allListings;
  }

  void search(String query) {
    if (query.isEmpty) {
      listings = _allListings;
    } else {
      // Filter listings based on query
      listings = _allListings
          .where(
            (listing) =>
                listing.fullAddress.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  // index reset for images
  void resetImageIndex() {
    currentImageIndex = 0;
    notifyListeners();
  }

  // Detail page logic
  void updateImageIndex(int index) {
    currentImageIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
