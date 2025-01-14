import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/common/receipt_details/data/receipt_details_item_response.dart';

class ReceiptDetailsResponse extends Equatable {
  const ReceiptDetailsResponse({
    required this.id,
    required this.userId,
    required this.currencyId,
    required this.storeName,
    required this.totalAmount,
    required this.purchaseDate,
    required this.createdAt,
    required this.items,
  });

  factory ReceiptDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ReceiptDetailsResponse(
        id: json['id'] as String,
        userId: json['user_id'] as String?,
        currencyId: json['currency_id'] as int,
        storeName: json['store_name'] as String,
        totalAmount: (json['total_amount'] as num).toDouble(),
        purchaseDate: DateTime.parse(json['purchase_date'] as String),
        createdAt: DateTime.parse(json['created_at'] as String),
        items: (json['items'] as List<dynamic>?)
                ?.map(
                  (e) => ReceiptDetailsItemResponse.fromJson(e),
                )
                .toList() ??
            [],
      );

  final String id;
  final String? userId;
  final int currencyId;
  final String storeName;
  final double totalAmount;
  final DateTime purchaseDate;
  final DateTime createdAt;
  final List<ReceiptDetailsItemResponse> items;

  Map<String, dynamic> get toJson => {
        'id': id,
        'user_id': userId,
        'currency_id': currencyId,
        'store_name': storeName,
        'total_amount': totalAmount.toDouble(),
        'purchase_date': purchaseDate.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'items': items.map((e) => e.toJson).toList(),
      };

  @override
  List<Object?> get props => [
        id,
        userId,
        currencyId,
        storeName,
        totalAmount,
        purchaseDate,
        createdAt,
        items,
      ];
}
