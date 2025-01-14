import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/categories/domain/get_categories_use_case.dart';
import 'package:grocerlytics/features/common/categories/models/category_model.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({
    required this.getCategoriesUseCase,
  }) : super(CategoriesState.initial());

  final GetCategoriesUseCase getCategoriesUseCase;

  Future<void> init() async {
    emit(
      state.copyWith(
        status: const LoadingStatus(),
      ),
    );
    try {
      final result = await getCategoriesUseCase.run();

      emit(
        state.copyWith(
          status: const LoadedStatus(),
          categories: result,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: ErrorStatus(e),
        ),
      );
      rethrow;
    }
  }
}

class CategoriesState extends Equatable {
  const CategoriesState._({
    required this.status,
    required this.categories,
  });

  final Status<CategoriesState> status;
  final List<CategoryModel> categories;

  factory CategoriesState.initial() {
    return const CategoriesState._(
      status: LoadingStatus(),
      categories: [],
    );
  }

  CategoriesState copyWith({
    List<CategoryModel>? categories,
    Status<CategoriesState>? status,
  }) {
    return CategoriesState._(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        status,
      ];
}
