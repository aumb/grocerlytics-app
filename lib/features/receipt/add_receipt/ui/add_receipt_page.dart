import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/categories/categories_cubit.dart';
import 'package:grocerlytics/features/common/currencies/ui/currencies_cubit.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/quantity_units/ui/quantity_units_cubit.dart';
import 'package:grocerlytics/features/common/ui/primary_button.dart';
import 'package:grocerlytics/features/receipt/add_receipt/ui/add_receipt_cubit.dart';
import 'package:grocerlytics/features/receipt/add_receipt/ui/widgets/add_receipt_currency_and_date.dart';
import 'package:grocerlytics/features/receipt/add_receipt/ui/widgets/add_receipt_item_widget.dart';
import 'package:grocerlytics/features/receipt/add_receipt/ui/widgets/add_receipt_photo_widget.dart';
import 'package:grocerlytics/router/router.gr.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final _formKey = GlobalKey<ShadFormState>();

@RoutePage()
class AddReceiptPage extends StatelessWidget {
  const AddReceiptPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AddReceiptScreen();
  }
}

class AddReceiptScreen extends StatelessWidget {
  const AddReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final state = context.select((AddReceiptCubit c) => c.state);

    return switch (state.status) {
      LoadingStatus<AddReceiptState>() => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      EmptyStatus<AddReceiptState>() ||
      ErrorStatus<AddReceiptState>() ||
      LoadedStatus<AddReceiptState>() ||
      InitialStatus<AddReceiptState>() =>
        Scaffold(
          appBar: AppBar(
            title: const Text('Add Receipt'),
            leading: const AutoLeadingButton(),
          ),
          body: SafeArea(
            child: Container(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: ShadForm(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AddReceiptPhotoWidget(
                                  onImageSelected: (file) => context.router
                                      .navigate(
                                          AnalyzeReceiptRoute(file: file)),
                                ),
                                Text(
                                  'Try sending an image of the receipt instead, we will analyze it to the best of our ability!',
                                  style: theme.textTheme.muted,
                                ),
                                const SizedBox(height: 16),
                                AddReceiptCurrencyAndDate(
                                  purchaseDate: state.purchaseDate,
                                  onPurchaseDateChanged: context
                                      .read<AddReceiptCubit>()
                                      .onPurchaseDateChanged,
                                  selectedCurrency: context
                                      .read<CurrenciesCubit>()
                                      .state
                                      .selectedCurrency,
                                  onCurrencyChanged: (_) {},
                                  currencies: context
                                      .read<CurrenciesCubit>()
                                      .state
                                      .currencies,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Store information',
                                  style: theme.textTheme.large,
                                ),
                                const SizedBox(height: 16),
                                ShadInputFormField(
                                  id: 'storeName',
                                  initialValue: state.storeName,
                                  placeholder: const Text('Name'),
                                  maxLength: 150,
                                  onChanged: context
                                      .read<AddReceiptCubit>()
                                      .onStoreNameChanged,
                                  validator: (v) {
                                    if (v.isEmpty) {
                                      return 'Store name must not be empty';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Item information',
                                  style: theme.textTheme.large,
                                ),
                                const SizedBox(height: 16),
                                ...state.items.mapIndexed(
                                  (index, e) => AddReceiptItemWidget(
                                    model: e,
                                    currencies: context
                                        .read<CurrenciesCubit>()
                                        .state
                                        .currencies,
                                    selectedCurrency: context
                                        .read<CurrenciesCubit>()
                                        .state
                                        .selectedCurrency,
                                    selectedCategory: e.categoryModel,
                                    categories: context
                                        .read<CategoriesCubit>()
                                        .state
                                        .categories,
                                    onItemCateogryChanged: (v) => context
                                        .read<AddReceiptCubit>()
                                        .onItemCateogryChanged(index, v),
                                    onItemNameChanged: (v) => context
                                        .read<AddReceiptCubit>()
                                        .onItemNameChanged(index, v),
                                    onItemQuantityChanged: (v) => context
                                        .read<AddReceiptCubit>()
                                        .onItemQuantityChanged(
                                          index,
                                          v,
                                          context
                                              .read<QuantityUnitsCubit>()
                                              .state
                                              .fallbackQuantity,
                                        ),
                                    onItemQuantityUnitChanged: (v) => context
                                        .read<AddReceiptCubit>()
                                        .onItemQuantityUnitChanged(
                                          index,
                                          v,
                                          context
                                              .read<QuantityUnitsCubit>()
                                              .state
                                              .fallbackQuantity,
                                        ),
                                    onItemPriceChanged: (v) => context
                                        .read<AddReceiptCubit>()
                                        .onItemPriceChanged(
                                          index,
                                          v,
                                          context
                                              .read<CurrenciesCubit>()
                                              .state
                                              .selectedCurrency,
                                        ),
                                    selectedQuantity: context
                                        .read<QuantityUnitsCubit>()
                                        .state
                                        .fallbackQuantity,
                                    quantities: context
                                        .read<QuantityUnitsCubit>()
                                        .state
                                        .quantities,
                                    showRemove: state.items.length > 1,
                                    onRemoveItem: () => context
                                        .read<AddReceiptCubit>()
                                        .removeItem(index),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ShadButton.outline(
                                  onPressed: context
                                      .read<AddReceiptCubit>()
                                      .addNewItem,
                                  child: const Text('New item'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: PrimaryButton(
                        label: 'Review',
                        onPressed: () {
                          buttonClickTracking(
                            page: '$AddReceiptPage',
                            buttonInfo: 'Try to proceed to review receipt',
                          );
                          if (_formKey.currentState!.saveAndValidate()) {
                            context.router.push(const ReviewReceiptRoute());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    };
  }
}
