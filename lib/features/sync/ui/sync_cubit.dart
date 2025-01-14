import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/auth/domain/get_access_token_use_case.dart';
import 'package:grocerlytics/features/auth/domain/get_user_id.dart';
import 'package:grocerlytics/features/auth/domain/get_user_use_case.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/receipt_details/domain/get_receipt_details_use_case.dart';
import 'package:grocerlytics/features/common/receipt_details/domain/get_unassigned_receipts_details_use_case.dart';
import 'package:grocerlytics/features/common/receipt_details/domain/save_receipt_details_local_use_case.dart';
import 'package:grocerlytics/features/common/receipt_details/domain/sync_unassigned_receipts_details_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class SyncCubit extends Cubit<SyncState> {
  SyncCubit({
    required this.getUserUseCase,
    required this.getAccessTokenUseCase,
    required this.getUnassignedReceiptsDetailsUseCase,
    required this.syncUnassignedReceiptsDetailsUseCase,
    required this.getReceiptDetailsUseCase,
    required this.saveReceiptDetailsLocalUseCase,
    required this.getUserIdUseCase,
  }) : super(SyncState.initial());

  final GetUserUseCase getUserUseCase;
  final GetAccessTokenUseCase getAccessTokenUseCase;
  final GetUnassignedReceiptsDetailsUseCase getUnassignedReceiptsDetailsUseCase;
  final SyncUnassignedReceiptsDetailsUseCase
      syncUnassignedReceiptsDetailsUseCase;
  final GetReceiptDetailsUseCase getReceiptDetailsUseCase;
  final SaveReceiptDetailsLocalUseCase saveReceiptDetailsLocalUseCase;
  final GetUserIdUseCase getUserIdUseCase;

  String get _accessToken => getAccessTokenUseCase.run();
  String get _userId => getUserIdUseCase.run();

  Future<void> syncWithServer() async {
    emit(state.copyWith(status: const InitialStatus()));

    if (_accessToken.isNotEmpty) {
      emit(state.copyWith(status: const LoadingStatus()));

      try {
        final unassignedReceipts =
            await getUnassignedReceiptsDetailsUseCase.run();

        if (unassignedReceipts.isNotEmpty) {
          await syncUnassignedReceiptsDetailsUseCase.run(
            unassignedReceipts,
            _userId,
          );
        }

        final res = await getReceiptDetailsUseCase.run(_userId);
        await saveReceiptDetailsLocalUseCase.run(res);

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
}

class SyncState extends Equatable {
  const SyncState._({
    required this.status,
  });

  factory SyncState.initial() => const SyncState._(
        status: InitialStatus(),
      );

  final Status<SyncState> status;

  SyncState copyWith({
    Status<SyncState>? status,
  }) =>
      SyncState._(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status];
}
