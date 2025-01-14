import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/receipt_details/domain/delete_all_receipt_data_use_case.dart';
import 'package:grocerlytics/features/settings/ui/settings_page.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteReceiptDetailsCubit extends Cubit<DeleteReceiptDetailsState> {
  DeleteReceiptDetailsCubit({
    required this.deleteAllReceiptDataUseCase,
  }) : super(DeleteReceiptDetailsState.initial());

  final DeleteAllReceiptDataUseCase deleteAllReceiptDataUseCase;

  Future<void> deleteData(String userId) async {
    buttonClickTracking(
      page: '$SettingsPage',
      buttonInfo: 'Attempting to delete all data',
    );
    emit(state.copyWith(status: const LoadingStatus()));
    try {
      await deleteAllReceiptDataUseCase.run(userId);
      emit(state.copyWith(status: const LoadedStatus()));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: ErrorStatus(e)));
    }
  }
}

class DeleteReceiptDetailsState extends Equatable {
  const DeleteReceiptDetailsState._({
    required this.status,
  });

  factory DeleteReceiptDetailsState.initial() =>
      const DeleteReceiptDetailsState._(
        status: InitialStatus(),
      );

  final Status<DeleteReceiptDetailsState> status;

  DeleteReceiptDetailsState copyWith({
    Status<DeleteReceiptDetailsState>? status,
  }) =>
      DeleteReceiptDetailsState._(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status];
}
