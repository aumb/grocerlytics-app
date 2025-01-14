import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/auth/ui/auth_cubit.dart';
import 'package:grocerlytics/features/common/categories/categories_cubit.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/currencies/ui/currencies_cubit.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/spending/spending_categories/model/spending_category_model.dart';
import 'package:grocerlytics/features/spending/spending_categories/ui/widgets/spending_categories_bottom_sheet.dart';
import 'package:grocerlytics/features/spending/spending_categories/ui/widgets/spending_categories_chart.dart';
import 'package:grocerlytics/features/spending/spending_categories/ui/widgets/spending_categories_panel.dart';
import 'package:grocerlytics/features/spending/ui/spending_cubit.dart';
import 'package:grocerlytics/features/spending/ui/widgets/spending_date_range_picker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class SpendingPage extends StatelessWidget {
  const SpendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpendingScreen();
  }
}

class SpendingScreen extends StatelessWidget {
  const SpendingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.select((SpendingCubit c) => c.state);

    return ShadResponsiveBuilder(
      builder: (_, breakpoint) => switch (breakpoint) {
        ShadBreakpointTN() ||
        ShadBreakpointSM() ||
        ShadBreakpointMD() =>
          _SpendingSmallScreen(
            isLoading: state.status.isLoading,
            spendingCategories: state.spendingCategories,
            selectedCategoryIndex: state.selectedCategoryIndex,
            onDateRangeConfirmed: () => context.read<SpendingCubit>().init(
                  context.read<CategoriesCubit>().state.categories,
                  context.read<AuthCubit>().state.user.id,
                ),
            onDateRangeChanged: context.read<SpendingCubit>().onRangeChanged,
            fromDate: state.fromDate,
            toDate: state.toDate,
            itemScrollController: state.itemScrollController,
            changeSelectedCategory:
                context.read<SpendingCubit>().changeSelectedCategory,
            totalSpendingAmount: state.totalSpendingAmount,
            selectedCurrency:
                context.read<CurrenciesCubit>().state.selectedCurrency,
            startDate: state.fromDate.toUtc().toIso8601String(),
            endDate: state.toDate.toUtc().toIso8601String(),
          ),
        ShadBreakpointLG() ||
        ShadBreakpointXL() ||
        ShadBreakpointXXL() =>
          _SpendingBigScreen(
            isLoading: state.status.isLoading,
            spendingCategories: state.spendingCategories,
            selectedCategoryIndex: state.selectedCategoryIndex,
            onDateRangeConfirmed: () => context.read<SpendingCubit>().init(
                  context.read<CategoriesCubit>().state.categories,
                  context.read<AuthCubit>().state.user.id,
                ),
            onDateRangeChanged: context.read<SpendingCubit>().onRangeChanged,
            fromDate: state.fromDate,
            toDate: state.toDate,
            itemScrollController: state.itemScrollController,
            changeSelectedCategory:
                context.read<SpendingCubit>().changeSelectedCategory,
            totalSpendingAmount: state.totalSpendingAmount,
            selectedCurrency:
                context.read<CurrenciesCubit>().state.selectedCurrency,
            startDate: state.fromDate.toUtc().toIso8601String(),
            endDate: state.toDate.toUtc().toIso8601String(),
          ),
      },
    );
  }
}

class _SpendingSmallScreen extends StatelessWidget {
  const _SpendingSmallScreen({
    required this.spendingCategories,
    required this.selectedCategoryIndex,
    required this.onDateRangeConfirmed,
    required this.onDateRangeChanged,
    required this.fromDate,
    required this.toDate,
    required this.itemScrollController,
    required this.changeSelectedCategory,
    required this.totalSpendingAmount,
    required this.selectedCurrency,
    required this.isLoading,
    required this.startDate,
    required this.endDate,
  });

  //Common
  final List<SpendingCategoryModel> spendingCategories;
  final int selectedCategoryIndex;
  final CurrencyModel selectedCurrency;
  final bool isLoading;
  //Chart
  final void Function(int) changeSelectedCategory;
  final double totalSpendingAmount;
  //Date time picker
  final VoidCallback onDateRangeConfirmed;
  final void Function(ShadDateTimeRange?) onDateRangeChanged;
  final DateTime? fromDate;
  final DateTime? toDate;
  //List
  final ItemScrollController itemScrollController;
  final String startDate;
  final String endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Center(
                  child: SpendingCategoriesChart(
                    isLoading: isLoading,
                    selectedCurrency: selectedCurrency,
                    totalSpendingAmount: totalSpendingAmount,
                    spendingCategories: spendingCategories,
                    selectedCategoryIndex: selectedCategoryIndex,
                    changeSelectedCategory: changeSelectedCategory,
                  ),
                ),
                const SizedBox(height: 32),
                SpendingDateRangePicker(
                  isLoading: isLoading,
                  onConfirmPressed: onDateRangeConfirmed,
                  onRangeChanged: onDateRangeChanged,
                  fromDate: fromDate,
                  toDate: toDate,
                ),
              ],
            ),
          ),
          SpendingCategoriesBottomSheet(
            isLoading: isLoading,
            selectedCurrency: selectedCurrency,
            spendingCategories: spendingCategories,
            selectedCategoryIndex: selectedCategoryIndex,
            itemScrollController: itemScrollController,
            startDate: startDate,
            endDate: endDate,
          ),
        ],
      ),
    );
  }
}

class _SpendingBigScreen extends StatelessWidget {
  const _SpendingBigScreen({
    required this.spendingCategories,
    required this.selectedCategoryIndex,
    required this.onDateRangeConfirmed,
    required this.onDateRangeChanged,
    required this.fromDate,
    required this.toDate,
    required this.itemScrollController,
    required this.changeSelectedCategory,
    required this.totalSpendingAmount,
    required this.selectedCurrency,
    required this.isLoading,
    required this.startDate,
    required this.endDate,
  });

  //Common
  final List<SpendingCategoryModel> spendingCategories;
  final int selectedCategoryIndex;
  final CurrencyModel selectedCurrency;
  final bool isLoading;
  //Chart
  final void Function(int) changeSelectedCategory;
  final double totalSpendingAmount;
  //Date time picker
  final VoidCallback onDateRangeConfirmed;
  final void Function(ShadDateTimeRange?) onDateRangeChanged;
  final DateTime? fromDate;
  final DateTime? toDate;
  //List
  final ItemScrollController itemScrollController;
  final String startDate;
  final String endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                SafeArea(
                  child: Center(
                    child: SpendingCategoriesChart(
                      isLoading: isLoading,
                      selectedCurrency: selectedCurrency,
                      spendingCategories: spendingCategories,
                      selectedCategoryIndex: selectedCategoryIndex,
                      changeSelectedCategory: changeSelectedCategory,
                      totalSpendingAmount: totalSpendingAmount,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SpendingDateRangePicker(
                  isLoading: isLoading,
                  onConfirmPressed: onDateRangeConfirmed,
                  onRangeChanged: onDateRangeChanged,
                  fromDate: fromDate,
                  toDate: toDate,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SpendingCategoriesPanel(
              isLoading: isLoading,
              spendingCategories: spendingCategories,
              selectedCategoryIndex: selectedCategoryIndex,
              itemScrollController: itemScrollController,
              selectedCurrency: selectedCurrency,
              startDate: startDate,
              endDate: endDate,
            ),
          ),
        ],
      ),
    );
  }
}
