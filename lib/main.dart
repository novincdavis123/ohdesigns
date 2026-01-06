import 'package:flutter/material.dart';
import 'package:ohdesigns/providers/listing_provider.dart';
import 'package:ohdesigns/services/listing_respository.dart';
import 'package:ohdesigns/ui/list/listng_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Provide ListingProvider to the app
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              ListingProvider(repository: ListingRepository())..loadListings(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: ListingPage(),
    );
  }
}
