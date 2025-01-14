import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/receipt/models/receipt_item_model.dart';
import 'package:grocerlytics/features/receipt/review_receipt/domain/create_receipt_use_case.dart';
import 'package:grocerlytics/features/receipt/review_receipt/models/create_receipt_model.dart';
import 'package:grocerlytics/features/receipt/review_receipt/ui/review_receipt_page.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReviewReceiptCubit extends Cubit<ReviewReceiptState> {
  ReviewReceiptCubit({
    required this.createReceiptUseCase,
  }) : super(ReviewReceiptState.initial());

  final CreateReceiptUseCase createReceiptUseCase;

  void init(
    String storeName,
    List<ReceiptItemModel> items,
    DateTime purchaseDate,
  ) {
    final totalAmount = items.fold<double>(
      0,
      (previousValue, element) =>
          previousValue + (element.priceModel?.price ?? 0),
    );

    emit(
      state.copyWith(
        totalAmount: totalAmount,
        purchaseDate: purchaseDate,
        storeName: storeName,
        items: items,
      ),
    );
  }

  Future<void> submit(String userId, int currencyId) async {
    buttonClickTracking(
      page: '$ReviewReceiptPage',
      buttonInfo: 'Submitting receipt',
    );
    emit(
      state.copyWith(
        status: const LoadingStatus(),
      ),
    );

    try {
      await createReceiptUseCase.run(
        CreateReceiptModel(
          userId: userId,
          currencyId: currencyId,
          storeName: state.storeName,
          totalAmount: state.totalAmount,
          purchaseDate: state.purchaseDate.toUtc().toIso8601String(),
          items: state.items
              .map(
                (e) => CreateReceiptItemModel(
                  itemName: e.name ?? '',
                  itemAbrv: e.itemAbrv,
                  price: e.priceModel?.price ?? 0,
                  quantity: e.quantityModel?.quantity ?? 0,
                  quantityUnitId: e.quantityModel?.unit.id ?? 0,
                  categoryId: e.categoryModel?.id ?? 0,
                ),
              )
              .toList(),
        ),
      );

      emit(
        state.copyWith(
          status: const LoadedStatus(),
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: ErrorStatus(e),
        ),
      );
    }
  }
}

class ReviewReceiptState extends Equatable {
  const ReviewReceiptState._({
    required this.totalAmount,
    required this.purchaseDate,
    required this.status,
    required this.storeName,
    required this.items,
  });

  final double totalAmount;
  final Status<ReviewReceiptState> status;
  final DateTime purchaseDate;
  final String storeName;
  final List<ReceiptItemModel> items;

  factory ReviewReceiptState.initial() {
    return ReviewReceiptState._(
      totalAmount: 0,
      purchaseDate: DateTime.now(),
      status: const LoadedStatus(),
      storeName: '',
      items: [],
    );
  }

  ReviewReceiptState copyWith({
    double? totalAmount,
    DateTime? purchaseDate,
    Status<ReviewReceiptState>? status,
    String? storeName,
    List<ReceiptItemModel>? items,
  }) {
    return ReviewReceiptState._(
      totalAmount: totalAmount ?? this.totalAmount,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      status: status ?? this.status,
      storeName: storeName ?? this.storeName,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [
        totalAmount,
        purchaseDate,
        status,
        storeName,
        items,
      ];
}
