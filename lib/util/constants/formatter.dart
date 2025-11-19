import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:intl/intl.dart';

class Formatter {
  // currency formatter
  static final formatter = NumberFormat.currency(
    // locale: 'en_IN',
    decimalDigits: 2,
    symbol: locator.get<HomeViewModel>().currentCurrencySymbol,
    //  '₹',
  );

  static NumberFormat customFormatter(String? symbol) {
    return NumberFormat.currency(
      // locale: 'en_IN',
      decimalDigits: 2,
      symbol: symbol ?? '',
      //  '₹',
    );
  }
}