import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/theme/domain/get_theme_use_case.dart';
import 'package:grocerlytics/features/common/theme/domain/save_theme_use_case.dart';
import 'package:grocerlytics/features/common/theme/ui/theme_page.dart';
import 'package:injectable/injectable.dart';

@injectable
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit({
    required this.getSavedThemeUseCase,
    required this.saveThemeUseCase,
  }) : super(getSavedThemeUseCase.run());

  final GetSavedThemeUseCase getSavedThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;

  void setTheme(ThemeMode mode) {
    buttonClickTracking(
      page: '$ThemePage',
      buttonInfo: 'Setting theme to ${mode.name}',
    );
    unawaited(saveThemeUseCase.run(mode));
    emit(mode);
  }
}
