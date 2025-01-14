import 'package:equatable/equatable.dart';

class CategoriesResponse extends Equatable {
  const CategoriesResponse({
    required this.categories,
  });

  factory CategoriesResponse.fromJson(List<dynamic> json) => CategoriesResponse(
        categories: json.map((e) => CategoryResponse.fromJson(e)).toList(),
      );

  final List<CategoryResponse> categories;

  @override
  List<Object?> get props => [categories];
}

class CategoryResponse extends Equatable {
  const CategoryResponse({
    required this.id,
    required this.label,
    required this.color,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        id: json['id'] as int,
        label: json['label'] as String,
        color: json['color'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'color': color,
      };

  final int id;
  final String label;
  final String color;

  @override
  List<Object?> get props => [id, label, color];
}
