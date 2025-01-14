import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AddReceiptCurrencyAndDate extends StatelessWidget {
  const AddReceiptCurrencyAndDate({
    super.key,
    required this.selectedCurrency,
    required this.currencies,
    required this.onCurrencyChanged,
    required this.purchaseDate,
    required this.onPurchaseDateChanged,
  });

  final CurrencyModel selectedCurrency;
  final List<CurrencyModel> currencies;
  final void Function(CurrencyModel?)? onCurrencyChanged;
  final DateTime purchaseDate;
  final void Function(DateTime?)? onPurchaseDateChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ShadDatePickerFormField(
            id: 'purchaseDate',
            initialValue: DateTime.now(),
            selectableDayPredicate: (day) => day.isBefore(DateTime.now()),
            onChanged: onPurchaseDateChanged,
            closeOnSelection: true,
            validator: (v) {
              if (v == null) {
                return 'Pruchase date must not be empty';
              }
              return null;
            },
          ),
        ),
        Expanded(
          child: ShadSelectFormField<CurrencyModel>(
            id: 'currencyType',
            enabled: false,
            minWidth: MediaQuery.sizeOf(context).width,
            shrinkWrap: true,
            onChanged: onCurrencyChanged,
            initialValue: selectedCurrency,
            options: currencies.map((e) =>
                ShadOption<CurrencyModel>(value: e, child: Text(e.symbol))),
            selectedOptionBuilder: (_, e) => Text(e.symbol),
            validator: (v) {
              if (v == null) {
                return 'Currency type must not be empty';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
