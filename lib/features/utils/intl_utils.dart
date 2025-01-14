import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

String formatDateTime(DateTime dateTime) {
  final formatter = DateFormat.yMMMMd('en_US');

  return formatter.format(dateTime);
}

String formatCurrency(CurrencyModel currency, double number) {
  final formatter =
      NumberFormat.currency(locale: "en_US", symbol: currency.symbol);
  return formatter.format(number);
}
