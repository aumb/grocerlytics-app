import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';

class CubitObserver extends BlocObserver {
  const CubitObserver();

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('${bloc.runtimeType} has errored: ${error.toString()} \n $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (change.toString().contains('ErrorStatus')) {
      errorTracking(
        page: bloc.runtimeType
            .toString()
            .substring(0, bloc.runtimeType.toString().length - 5),
      );
      log('${bloc.runtimeType} has errored: $change');
    }
    super.onChange(bloc, change);
  }
}
