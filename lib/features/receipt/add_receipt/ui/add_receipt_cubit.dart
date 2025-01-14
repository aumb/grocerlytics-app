import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/categories/models/category_model.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/quantity_units/models/quantity_unit_model.dart';
import 'package:grocerlytics/features/receipt/add_receipt/ui/add_receipt_page.dart';
import 'package:grocerlytics/features/receipt/models/receipt_item_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:uuid/uuid.dart';

@injectable
class AddReceiptCubit extends Cubit<AddReceiptState> {
  AddReceiptCubit() : super(AddReceiptState.initial());

  void init(CategoryModel initialCategory) {
    emit(
      state.copyWith(
        initialCategoryModel: initialCategory,
        storeName: '',
        purchaseDate: DateTime.now(),
        items: [
          ReceiptItemModel(
            id: const Uuid().v4(),
            categoryModel: initialCategory,
          ),
        ],
      ),
    );
  }

  Future<void> bulkUpdate({
    required String storeName,
    required List<ReceiptItemModel> items,
  }) async {
    emit(
      state.copyWith(
        status: const LoadingStatus(),
        storeName: storeName,
        purchaseDate: DateTime.now(),
        items: items,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    emit(
      state.copyWith(
        status: const LoadedStatus(),
      ),
    );
  }

  void onPurchaseDateChanged(DateTime? value) {
    if (value == null || value.isSameDay(state.purchaseDate)) {
      return;
    }

    emit(state.copyWith(purchaseDate: value));
  }

  void onStoreNameChanged(String value) {
    emit(state.copyWith(storeName: value));
  }

  void addNewItem() {
    buttonClickTracking(
      page: '$AddReceiptPage',
      buttonInfo: 'Add new item to receipt',
    );
    final uuid = const Uuid().v4();

    emit(
      state.copyWith(
        items: [
          ...state.items,
          ReceiptItemModel(
            id: uuid,
            categoryModel: state.initialCategoryModel,
          ),
        ],
      ),
    );
  }

  void onItemCateogryChanged(int index, CategoryModel? value) {
    final newItems = [...state.items];
    final item = newItems[index];

    newItems[index] = ReceiptItemModel(
      categoryModel: value,
      id: item.id,
      name: item.name,
      quantityModel: item.quantityModel,
      priceModel: item.priceModel,
    );

    emit(
      state.copyWith(items: newItems),
    );
  }

  void onItemNameChanged(int index, String value) {
    final newItems = [...state.items];

    final item = newItems[index];

    newItems[index] = ReceiptItemModel(
      name: value,
      categoryModel: item.categoryModel,
      id: item.id,
      quantityModel: item.quantityModel,
      priceModel: item.priceModel,
    );

    emit(
      state.copyWith(items: newItems),
    );
  }

  void onItemQuantityChanged(
    int index,
    String value,
    QuantityUnitModel quantityFallback,
  ) {
    final newItems = [...state.items];
    final item = newItems[index];

    newItems[index] = ReceiptItemModel(
      quantityModel: ReceiptItemQuantityModel(
        quantity: double.tryParse(value) ?? 0,
        unit: item.quantityModel?.unit ?? quantityFallback,
      ),
      name: item.name,
      categoryModel: item.categoryModel,
      id: item.id,
      priceModel: item.priceModel,
    );

    emit(
      state.copyWith(items: newItems),
    );
  }

  void onItemQuantityUnitChanged(
    int index,
    QuantityUnitModel? value,
    QuantityUnitModel quantityFallback,
  ) {
    final newItems = [...state.items];
    final item = newItems[index];

    newItems[index] = ReceiptItemModel(
      quantityModel: ReceiptItemQuantityModel(
        unit: value ?? quantityFallback,
        quantity: newItems[index].quantityModel?.quantity ?? 0.0,
      ),
      name: item.name,
      categoryModel: item.categoryModel,
      id: item.id,
      priceModel: item.priceModel,
    );

    emit(
      state.copyWith(items: newItems),
    );
  }

  void onItemPriceChanged(
    int index,
    String value,
    CurrencyModel currencyFallback,
  ) {
    final newItems = [...state.items];
    final item = newItems[index];

    newItems[index] = ReceiptItemModel(
      priceModel: ReceiptItemPriceModel(
        price: double.tryParse(value) ?? 0,
        unit: newItems[index].priceModel?.unit ?? currencyFallback,
      ),
      quantityModel: item.quantityModel,
      name: item.name,
      categoryModel: item.categoryModel,
      id: item.id,
    );

    emit(
      state.copyWith(items: newItems),
    );
  }

  void removeItem(int index) {
    buttonClickTracking(
      page: '$AddReceiptPage',
      buttonInfo: 'Remove item from receipt',
    );
    final itemIdToRemove = state.items[index].id;
    final updatedItems =
        state.items.where((item) => item.id != itemIdToRemove).toList();
    emit(state.copyWith(items: updatedItems));
  }
}

class AddReceiptState extends Equatable {
  const AddReceiptState._({
    required this.status,
    required this.storeName,
    required this.purchaseDate,
    required this.items,
    required this.initialCategoryModel,
  });

  final Status<AddReceiptState> status;
  final String storeName;
  final DateTime purchaseDate;
  final List<ReceiptItemModel> items;
  final CategoryModel initialCategoryModel;

  factory AddReceiptState.initial() => AddReceiptState._(
        status: const LoadedStatus(),
        storeName: '',
        purchaseDate: DateTime.now(),
        items: [],
        initialCategoryModel: const CategoryModel(
          id: 0,
          label: '',
          color: Colors.green,
          iconData: Icons.shopping_cart,
        ),
      );

  AddReceiptState copyWith({
    Status<AddReceiptState>? status,
    String? storeName,
    DateTime? purchaseDate,
    List<ReceiptItemModel>? items,
    CategoryModel? initialCategoryModel,
  }) =>
      AddReceiptState._(
        status: status ?? this.status,
        storeName: storeName ?? this.storeName,
        purchaseDate: purchaseDate ?? this.purchaseDate,
        items: items ?? this.items,
        initialCategoryModel: initialCategoryModel ?? this.initialCategoryModel,
      );

  @override
  List<Object?> get props => [
        status,
        storeName,
        purchaseDate,
        items,
        initialCategoryModel,
      ];
}
