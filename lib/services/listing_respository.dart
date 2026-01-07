import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ohdesigns/models/listing_model.dart';
import 'dart:developer';

class ListingRepository {
  Future<List<Listing>> loadListings() async {
    final jsonString = await rootBundle.loadString('assets/listings.json');
    // log("Loaded JSON string length: ${jsonString.length}");

    final decoded = json.decode(jsonString);

    if (decoded is! Map<String, dynamic>) {
      // log(
      //   "Root JSON is not a Map<String, dynamic>, got: ${decoded.runtimeType}",
      // );
      return [];
    }

    final dynamic dataValue = decoded['data'];
    if (dataValue is! List) {
      // log("JSON ‘data’ is not a List, got: ${dataValue.runtimeType}");
      return [];
    }

    final List<dynamic> rawList = dataValue;
    log("rawList length: ${rawList.length}");

    final List<Listing> parsedList = [];

    for (var i = 0; i < rawList.length; i++) {
      final item = rawList[i];
      if (item is Map<String, dynamic>) {
        try {
          final listing = Listing.fromJson(item);
          parsedList.add(listing);
          // log("Parsed item $i OK");
        } catch (e) {
          // log("Error parsing item $i: $e");
          // log(st.toString());
        }
      } else {
        // log("Skipping item $i — not a Map: ${item.runtimeType}");
      }
    }

    // log("Final parsed list length: ${parsedList.length}");
    return parsedList;
  }
}
