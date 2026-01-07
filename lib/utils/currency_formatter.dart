import 'package:intl/intl.dart';

// indian currency format
String getcurrencyFormat(int listingPrice) {
  final format = NumberFormat('#,##,###');
  final price = format.format(listingPrice);
  return price;
}
