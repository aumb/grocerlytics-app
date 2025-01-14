import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/auth/ui/auth_cubit.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/categories/categories_cubit.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/currencies/ui/currencies_cubit.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/ui/circular_icon_widget.dart';
import 'package:grocerlytics/features/common/ui/price_widget.dart';
import 'package:grocerlytics/features/common/ui/primary_button.dart';
import 'package:grocerlytics/features/common/ui/toasts.dart';
import 'package:grocerlytics/features/dependency_injection/injectable.dart';
import 'package:grocerlytics/features/receipt/add_receipt/ui/add_receipt_cubit.dart';
import 'package:grocerlytics/features/receipt/models/receipt_item_model.dart';
import 'package:grocerlytics/features/receipt/review_receipt/ui/review_receipt_cubit.dart';
import 'package:grocerlytics/features/spending/ui/spending_cubit.dart';
import 'package:grocerlytics/features/utils/intl_utils.dart';
import 'package:grocerlytics/router/router.gr.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ReviewReceiptPage extends StatelessWidget {
  const ReviewReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReviewReceiptCubit>(
      create: (_) => getIt.get<ReviewReceiptCubit>()
        ..init(
          context.read<AddReceiptCubit>().state.storeName,
          context.read<AddReceiptCubit>().state.items,
          context.read<AddReceiptCubit>().state.purchaseDate,
        ),
      child: BlocListener<ReviewReceiptCubit, ReviewReceiptState>(
        listener: (context, state) {
          switch (state.status) {
            case LoadedStatus<ReviewReceiptState>():
              context.read<SpendingCubit>().init(
                    context.read<CategoriesCubit>().state.categories,
                    context.read<AuthCubit>().state.user.id,
                  );
              context.router.root.popUntil((route) => route.isFirst);
              final rootRouter = AutoRouter.of(context).parent();
              final homeTabsRouter =
                  rootRouter?.innerRouterOf<TabsRouter>(HomeRoute.name);
              homeTabsRouter?.setActiveIndex(0);
            case ErrorStatus<ReviewReceiptState>():
              ShadToaster.of(context).show(
                errorToast(
                  body:
                      'There was a problem submitting this data, please try again',
                ),
              );
            case LoadingStatus<ReviewReceiptState>():
            case InitialStatus<ReviewReceiptState>():
            case EmptyStatus<ReviewReceiptState>():
              break;
          }
        },
        child: const ReviewReceiptScreen(),
      ),
    );
  }
}

class ReviewReceiptScreen extends StatelessWidget {
  const ReviewReceiptScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final state = context.select((ReviewReceiptCubit c) => c.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Receipt'),
        actions: [
          IconButton(
            onPressed: () {
              buttonClickTracking(
                page: '$ReviewReceiptPage',
                buttonInfo: 'Going back to edit',
              );
              context.router.maybePop();
            },
            icon: const Icon(LucideIcons.pencil),
          ),
        ],
        leading: const AutoLeadingButton(),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  state.storeName,
                                  style: theme.textTheme.h3,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                spacing: 2,
                                children: [
                                  PriceWidget(
                                    currencyModel: context
                                        .read<CurrenciesCubit>()
                                        .state
                                        .selectedCurrency,
                                    price: state.totalAmount,
                                  ),
                                  Text(
                                    formatDateTime(state.purchaseDate),
                                    style: theme.textTheme.muted,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: Divider()),
                      SliverList.builder(
                        itemCount: state.items.length,
                        itemBuilder: (_, index) {
                          final element = state.items[index];
                          return _ReviewReceiptItemTile(
                            element: element,
                            selectedCurrency: context
                                .read<CurrenciesCubit>()
                                .state
                                .selectedCurrency,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: PrimaryButton(
                    isEnabled: !state.status.isLoading,
                    isLoading: state.status.isLoading,
                    onPressed: () => context.read<ReviewReceiptCubit>().submit(
                          context.read<AuthCubit>().state.user.id,
                          context
                              .read<CurrenciesCubit>()
                              .state
                              .selectedCurrency
                              .id,
                        ),
                    label: 'Submit',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewReceiptItemTile extends StatelessWidget {
  const _ReviewReceiptItemTile({
    required this.element,
    required this.selectedCurrency,
  });

  final ReceiptItemModel element;
  final CurrencyModel selectedCurrency;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ListTile(
      leading: CircularIconWidget(
        icon: element.categoryModel?.iconData ?? Icons.shopping_cart,
      ),
      title: Text(element.name ?? ''),
      subtitle: Text(
        '${element.quantityModel?.quantity.toString() ?? ''} ${element.quantityModel?.unit.shorthand ?? ''}',
        style: theme.textTheme.muted,
      ),
      trailing: PriceWidget(
        currencyModel: element.priceModel?.unit ?? selectedCurrency,
        price: element.priceModel?.price ?? 0,
      ),
    );
  }
}
