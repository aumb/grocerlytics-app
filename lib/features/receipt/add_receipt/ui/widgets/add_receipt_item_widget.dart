import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/categories/models/category_model.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/quantity_units/models/quantity_unit_model.dart';
import 'package:grocerlytics/features/receipt/models/receipt_item_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AddReceiptItemWidget extends StatelessWidget {
  const AddReceiptItemWidget({
    super.key,
    required this.model,
    required this.selectedCategory,
    required this.categories,
    required this.onItemCateogryChanged,
    required this.onItemNameChanged,
    required this.onItemQuantityChanged,
    required this.onItemQuantityUnitChanged,
    required this.onItemPriceChanged,
    required this.showRemove,
    required this.onRemoveItem,
    required this.currencies,
    required this.selectedCurrency,
    required this.selectedQuantity,
    required this.quantities,
  });

  final ReceiptItemModel model;
  final CategoryModel? selectedCategory;
  final List<CategoryModel> categories;
  final CurrencyModel selectedCurrency;
  final List<CurrencyModel> currencies;
  final void Function(CategoryModel?) onItemCateogryChanged;
  final void Function(String) onItemNameChanged;
  final void Function(String) onItemQuantityChanged;
  final void Function(QuantityUnitModel?) onItemQuantityUnitChanged;
  final void Function(String) onItemPriceChanged;
  final bool showRemove;
  final VoidCallback onRemoveItem;
  final QuantityUnitModel selectedQuantity;
  final List<QuantityUnitModel> quantities;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      key: Key(model.id),
      children: [
        ShadSelectFormField<CategoryModel>(
          maxHeight: MediaQuery.sizeOf(context).width / 2,
          id: '${model.id}category',
          maxWidth: MediaQuery.sizeOf(context).width,
          shrinkWrap: true,
          initialValue: selectedCategory,
          placeholder: Text('Category',
              style: TextStyle(color: theme.colorScheme.mutedForeground)),
          onChanged: onItemCateogryChanged,
          options: categories.map(
            (e) => ShadOption<CategoryModel>(
              value: e,
              child: Row(
                children: [
                  Icon(e.iconData),
                  const SizedBox(width: 8),
                  Text(e.label),
                ],
              ),
            ),
          ),
          selectedOptionBuilder: (context, value) => Row(
            children: [
              Icon(value.iconData),
              const SizedBox(width: 8),
              Text(value.label),
            ],
          ),
          validator: (v) {
            if (v == null) {
              return 'Category must not be empty';
            }
            return null;
          },
        ),
        ShadInputFormField(
          textInputAction: TextInputAction.next,
          id: '${model.id}name',
          placeholder: const Text('Name'),
          initialValue: model.name,
          maxLength: 255,
          onChanged: onItemNameChanged,
          validator: (v) {
            if (v.isEmpty) {
              return 'Item name must not be empty';
            }
            return null;
          },
        ),
        _AddReceiptItemQuantity(
          model: model,
          onItemQuantityChanged: onItemQuantityChanged,
          onItemQuantityUnitChanged: onItemQuantityUnitChanged,
          quantities: quantities,
          selectedQuantity: selectedQuantity,
        ),
        ShadInputFormField(
          textInputAction: TextInputAction.done,
          id: '${model.id}price',
          onChanged: onItemPriceChanged,
          initialValue: model.priceModel?.price.toString(),
          placeholder: const Text('Price'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          maxLength: 15,
          validator: (v) {
            if (v.isEmpty) {
              return 'Item price must not be empty';
            } else if (double.tryParse(v) == null) {
              return 'Enter a valid price';
            }
            return null;
          },
        ),
        if (showRemove)
          ShadButton.destructive(
            onPressed: onRemoveItem,
            child: const Text('Remove'),
          ),
      ],
    );
  }
}

class _AddReceiptItemQuantity extends StatelessWidget {
  const _AddReceiptItemQuantity({
    required this.model,
    required this.onItemQuantityChanged,
    required this.onItemQuantityUnitChanged,
    required this.quantities,
    required this.selectedQuantity,
  });

  final ReceiptItemModel model;
  final QuantityUnitModel selectedQuantity;
  final List<QuantityUnitModel> quantities;
  final void Function(String) onItemQuantityChanged;
  final void Function(QuantityUnitModel?) onItemQuantityUnitChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ShadSelectFormField<QuantityUnitModel>(
            maxHeight: MediaQuery.sizeOf(context).width / 2 - 20,
            id: '${model.id}quantityType',
            maxWidth: MediaQuery.sizeOf(context).width,
            shrinkWrap: true,
            onChanged: onItemQuantityUnitChanged,
            initialValue: model.quantityModel?.unit ?? selectedQuantity,
            options: quantities.map((e) => ShadOption<QuantityUnitModel>(
                value: e, child: Text(e.shorthand))),
            selectedOptionBuilder: (_, e) => Text(e.shorthand),
            validator: (v) {
              if (v == null) {
                return 'Quantity type must not be empty';
              }
              return null;
            },
          ),
        ),
        Expanded(
          flex: 4,
          child: ShadInputFormField(
            textInputAction: TextInputAction.next,
            id: '${model.id}quantity',
            placeholder: const Text('Quantity'),
            initialValue: model.quantityModel?.quantity.toString(),
            maxLength: 15,
            onChanged: onItemQuantityChanged,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (v) {
              if (v.isEmpty) {
                return 'Item quantity name must not be empty';
              } else if (double.tryParse(v) == null) {
                return 'Enter a valid quantity';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
