import 'package:equatable/equatable.dart';

class ReceiptResponse extends Equatable {
  const ReceiptResponse({
    required this.id,
    required this.currencyId,
    required this.storeName,
    required this.totalAmount,
    required this.purchaseDate,
    required this.createdAt,
  });

  factory ReceiptResponse.fromJson(Map<String, dynamic> json) =>
      ReceiptResponse(
        id: json['id'] as String,
        currencyId: json['currency_id'] as int,
        storeName: json['store_name'] as String,
        totalAmount: (json['total_amount'] as num).toDouble(),
        purchaseDate: DateTime.parse(json['purchase_date'] as String),
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  final String id;
  final int currencyId;
  final String storeName;
  final double totalAmount;
  final DateTime purchaseDate;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        id,
        currencyId,
        storeName,
        totalAmount,
        purchaseDate,
        createdAt,
      ];
}
