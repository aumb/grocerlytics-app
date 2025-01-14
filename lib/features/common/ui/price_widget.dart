import 'package:flutter/widgets.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/utils/intl_utils.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.currencyModel,
    required this.price,
  });

  final CurrencyModel currencyModel;
  final double price;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadDecorator(
      decoration: ShadDecoration(
        merge: false,
        color: theme.colorScheme.border,
        border: ShadBorder(radius: BorderRadius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          formatCurrency(
            currencyModel,
            price,
          ),
          style: theme.textTheme.small.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
