import 'dart:convert';

/// -----------
/// JSON Helpers
/// -----------

ListingResponse listingResponseFromJson(String str) =>
    ListingResponse.fromJson(json.decode(str));

String listingResponseToJson(ListingResponse data) =>
    json.encode(data.toJson());

/// --------------------
/// API Response Wrapper
/// --------------------

class ListingResponse {
  final List<Listing> listings;

  ListingResponse({required this.listings});

  factory ListingResponse.fromJson(Map<String, dynamic> json) {
    return ListingResponse(
      listings: List<Listing>.from(
        json['data'].map((x) => Listing.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': listings.map((x) => x.toJson()).toList()};
  }
}

/// --------------------
/// Listing Model
/// --------------------

class Listing {
  final String propertyTypeRaw;
  final int commonKey;
  final String agentName;
  final String agentOffice;
  final List<String> images;
  final String mlsNumber;
  final int squareFeet;
  final int beds;
  final String remarks;
  final String status;
  final int listPrice;
  final bool displayAddress;
  final int photoCount;
  final String propertyType;
  final int baths;
  final String fullAddress;

  Listing({
    required this.propertyTypeRaw,
    required this.commonKey,
    required this.agentName,
    required this.agentOffice,
    required this.images,
    required this.mlsNumber,
    required this.squareFeet,
    required this.beds,
    required this.remarks,
    required this.status,
    required this.listPrice,
    required this.displayAddress,
    required this.photoCount,
    required this.propertyType,
    required this.baths,
    required this.fullAddress,
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      propertyTypeRaw: json['PROPERTYRT'],
      commonKey: json['CMNCMNKEY'],
      agentName: json['LISTAGENTNAME'],
      agentOffice: json['LISTAGENTOFFICE'],
      images: List<String>.from(json['PICTURE']),
      mlsNumber: json['IDCMLSNUMBER'],
      squareFeet: json['SQFT'],
      beds: json['BEDS'],
      remarks: json['IDCREMARKS'],
      status: json['IDCSTATUS'],
      listPrice: json['IDCLISTPRICE'],
      displayAddress: json['IDCDISPLAYADDRESS'],
      photoCount: json['MLSPHOTOCOUNT'],
      propertyType: json['IDCPROPERTYTYPE'],
      baths: json['BATHSTOTAL'],
      fullAddress: json['IDCFULLADDRESS'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PROPERTYRT': propertyTypeRaw,
      'CMNCMNKEY': commonKey,
      'LISTAGENTNAME': agentName,
      'LISTAGENTOFFICE': agentOffice,
      'PICTURE': images,
      'IDCMLSNUMBER': mlsNumber,
      'SQFT': squareFeet,
      'BEDS': beds,
      'IDCREMARKS': remarks,
      'IDCSTATUS': status,
      'IDCLISTPRICE': listPrice,
      'IDCDISPLAYADDRESS': displayAddress,
      'MLSPHOTOCOUNT': photoCount,
      'IDCPROPERTYTYPE': propertyType,
      'BATHSTOTAL': baths,
      'IDCFULLADDRESS': fullAddress,
    };
  }
}

/// --------------------
/// Enums
/// --------------------

// enum IdcPropertyType {
//   commercialSale,
//   condoTownhouse,
//   land,
//   multiFamily,
//   singleFamily,
// }

/// --------------------
/// Enum Helpers
/// --------------------

// final idcPropertyTypeValues = EnumValues({
//   'Commercial Sale': IdcPropertyType.commercialSale,
//   'Condo/Townhouse': IdcPropertyType.condoTownhouse,
//   'Land': IdcPropertyType.land,
//   'Multi-Family': IdcPropertyType.multiFamily,
//   'Single Family': IdcPropertyType.singleFamily,
// });

class EnumValues<T> {
  final Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
