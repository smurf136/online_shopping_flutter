import 'package:intl/intl.dart';

extension StringX on String {
  String get currency {
    final currencyFormat = NumberFormat("#,##0.0", "en_US");
    return currencyFormat.format(double.tryParse(this));
  }
}
