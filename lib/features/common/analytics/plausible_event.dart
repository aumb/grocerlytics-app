import 'package:flutter/foundation.dart';
import 'package:grocerlytics/features/common/models/app_info.dart';
import 'package:grocerlytics/features/dependency_injection/injectable.dart';
import 'package:plausible_analytics/plausible_analytics.dart';

Future<void> buttonClickTracking({
  required String page,
  required String buttonInfo,
}) =>
    getIt<Plausible>().event(
      name: 'button',
      page: page,
      props: {
        'button_info': buttonInfo,
        'app_version': getIt<AppInfo>().buildNumber,
        'app_platform': defaultTargetPlatform.name,
      },
    );

Future<void> errorTracking({
  required String page,
}) =>
    getIt<Plausible>().event(
      name: 'error',
      page: page,
      props: {
        'app_version': getIt<AppInfo>().buildNumber,
        'app_platform': defaultTargetPlatform.name,
      },
    );
