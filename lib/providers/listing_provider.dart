import 'package:flutter/material.dart';
import 'package:ohdesigns/models/listing_model.dart';
import 'package:ohdesigns/services/listing_respository.dart';

class ListingProvider extends ChangeNotifier {
  ListingProvider({required this.repository});
  final ListingRepository repository;

  List<Listing> listings = [];
  bool isLoading = false;
  String? error;

  // current image index for detail page
  int currentImageIndex = 0;

  Future<void> loadListings() async {
    try {
      isLoading = true;
      notifyListeners();

      listings = await repository.loadListings();
      error = null;
    } catch (e) {
      error = "Failed to load listings";
      listings = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateImageIndex(int index) {
    currentImageIndex = index;
    notifyListeners(); // triggers Consumer rebuild
  }
}
