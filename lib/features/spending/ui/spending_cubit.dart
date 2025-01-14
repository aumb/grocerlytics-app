import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/categories/models/category_model.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/spending/domain/get_spending_use_case.dart';
import 'package:grocerlytics/features/spending/spending_categories/model/spending_category_model.dart';
import 'package:grocerlytics/features/spending/ui/spending_page.dart';
import 'package:injectable/injectable.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@injectable
class SpendingCubit extends Cubit<SpendingState> {
  SpendingCubit({
    required this.getSpendingUseCase,
  }) : super(SpendingState.initial());

  final GetSpendingUseCase getSpendingUseCase;

  Future<void> init(
    List<CategoryModel> categories,
    String userId,
  ) async {
    emit(
      state.copyWith(
        status: const LoadingStatus(),
        toDate: state.toDate,
      ),
    );

    buttonClickTracking(
      page: '$SpendingPage',
      buttonInfo:
          'Searching between dates ${state.fromDate} and ${state.toDate}',
    );

    try {
      final result = await getSpendingUseCase.run(
        userId,
        state.fromDate.toUtc().toIso8601String(),
        state.toDate.toUtc().toIso8601String(),
        categories,
      );

      emit(
        state.copyWith(
          toDate: state.toDate,
          status: const LoadedStatus(),
          spendingCategories: result.categories,
          totalSpendingAmount: result.totalSpendingAmount,
          selectedCategoryIndex: 0,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          toDate: state.toDate,
          status: ErrorStatus(e.toString()),
        ),
      );
    }
  }

  void changeSelectedCategory(int index) {
    if (index == state.selectedCategoryIndex) return;
    buttonClickTracking(
      page: '$SpendingPage',
      buttonInfo: 'Selecting chart category $index',
    );

    emit(
      state.copyWith(
        status: state.status.hasError ? const InitialStatus() : state.status,
        toDate: state.toDate,
        selectedCategoryIndex: index,
      ),
    );

    state.itemScrollController.scrollTo(
      index: state.selectedCategoryIndex,
      duration: const Duration(milliseconds: 300),
    );
  }

  void onRangeChanged(ShadDateTimeRange? range) {
    final startDate = range?.start ?? state.fromDate;
    final effectiveFromDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );

    final endDate = range?.end ?? startDate;
    final effectiveEndDate = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      23,
      59,
      59,
    );

    emit(
      state.copyWith(
        status: state.status.hasError ? const InitialStatus() : state.status,
        fromDate: effectiveFromDate,
        toDate: effectiveEndDate,
      ),
    );
  }
}

class SpendingState extends Equatable {
  const SpendingState._({
    required this.totalSpendingAmount,
    required this.spendingCategories,
    required this.selectedCategoryIndex,
    required this.itemScrollController,
    required this.fromDate,
    required this.toDate,
    required this.status,
  });

  final double totalSpendingAmount;
  final List<SpendingCategoryModel> spendingCategories;
  final ItemScrollController itemScrollController;
  final int selectedCategoryIndex;
  final DateTime fromDate;
  final DateTime toDate;
  final Status<SpendingState> status;

  factory SpendingState.initial() {
    final dtNow = DateTime.now();
    final fromDate = dtNow.subtract(const Duration(days: 7));
    final effectiveFromDate = DateTime(
      fromDate.year,
      fromDate.month,
      fromDate.day,
    );
    final effectiveToDate = DateTime(
      dtNow.year,
      dtNow.month,
      dtNow.day,
      23,
      59,
      59,
    );

    return SpendingState._(
      totalSpendingAmount: 0,
      spendingCategories: List.generate(
        21,
        (index) => SpendingCategoryModel(
          purchaseCount: 0,
          spendingPercentage: 0,
          spendingAmount: 0,
          categoryModel: CategoryModel(
            id: index,
            label: '',
            color: Colors.green,
            iconData: Icons.shopping_cart,
          ),
        ),
      ),
      selectedCategoryIndex: -1,
      itemScrollController: ItemScrollController(),
      fromDate: effectiveFromDate,
      toDate: effectiveToDate,
      status: const InitialStatus(),
    );
  }

  SpendingState copyWith({
    double? totalSpendingAmount,
    List<SpendingCategoryModel>? spendingCategories,
    int? selectedCategoryIndex,
    DateTime? fromDate,
    DateTime? toDate,
    Status<SpendingState>? status,
  }) =>
      SpendingState._(
        totalSpendingAmount: totalSpendingAmount ?? this.totalSpendingAmount,
        spendingCategories: spendingCategories ?? this.spendingCategories,
        selectedCategoryIndex:
            selectedCategoryIndex ?? this.selectedCategoryIndex,
        itemScrollController: itemScrollController,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        spendingCategories,
        selectedCategoryIndex,
        itemScrollController,
        fromDate,
        toDate,
        status,
      ];
}
