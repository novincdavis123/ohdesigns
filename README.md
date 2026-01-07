Listings App with Flutter

A Flutter application for viewing a list of real estate postings obtained from a local JSON file, with the ability to search by address and see posting details along with an image gallery.

lib/
├── main.dart             # App entry point
├── models/               # Data models (Listing)
├── services/             # JSON loading & parsing
├── providers/            # State management using Provider
├── theme/                # App theme and text styles (Roboto)
├── widgets/              # Reusable UI components
├── ui/                   # Screens / Pages
│   ├── detail/           # Detail page of listings
│   └── list/             # List page for listings

└── utils/                # Helper functions (e.g., string formatting)

Getting Started

1. Clone the repository


git clone https://github.com/yourusername/flutter-listings-app.git

2. Change into the project directory


cd flutter-listings-app

3. Get dependencies


flutter pub get

4. Execute the app

flutter run

## EXPLANATION

1. Model Structure & JSON Parsing

Listings are stored in assets/listings.json.

The Listing model encapsulates all listing data:

class Listing {
  final String id;
  final String title;
  final String address;
  final double price;
  final List<String> images;

  Listing({required this.id, required this.title, required this.address, required this.price, required this.images});

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['id'],
      title: json['title'],
      address: json['address'],
      price: json['price'].toDouble(),
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'address': address,
        'price': price,
        'images': images,
      };
}


Parsing is done in a dedicated service class to avoid direct Map access in UI, ensuring cleaner and safer code.


2. State Management
It is utilized for state management:

ListingProvider deals with

Loading lists from JSON.

Processing listings according to the searched keywords.

Handling the current image index in the gallery.

Justification: It is a light library; it is simple to integrate; it is enough for a state management scale such as ours; it divides presentation logic from application logic.

3. Search & Image Gallery Implementation

Search

Has been implemented using TextField on the List Page.

Also upon entering, ListingProvider filters listings in real-time based on address.

UI changes are done dynamically based on the Consumer.setDisplayFilter.

Image Gallery

Executed with PageView.Builder on the Detail Page.

Utilize CachedNetworkImage to

Cache images locally.

IndicatorView(QWidget parent=None):GenresEditor(parent); #qt

Show a default icon for damaged images.

currentImageIndex, a property in the provider, changes as swiping occurs.

Every time the listing is opened, the index is set again to 0 in order to begin with the first image.

Optional pre-caching enables smooth functionality even with multiple images.

4. Assumptions &amp

Local JSON data is accessed for ease instead of a remote API.

Provider was selected due to its simplicity compared to more complex libraries Bloc/RiverPod.

The image gallery has performance optimization through caching and preloading.


The UI follows mobile-first responsive design; tablet layouts are supported, but desktop is basic.

Some UI elements (like "Coming Soon" labels) are static for demonstration purposes.