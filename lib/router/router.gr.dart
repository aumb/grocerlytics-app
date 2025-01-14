// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:grocerlytics/features/common/theme/ui/theme_page.dart' as _i13;
import 'package:grocerlytics/features/common/ui/empty_page.dart' as _i4;
import 'package:grocerlytics/features/common/ui/not_found_page.dart' as _i6;
import 'package:grocerlytics/features/home/ui/home_page.dart' as _i5;
import 'package:grocerlytics/features/receipt/add_receipt/add_receipt_navigation_screen.dart'
    as _i1;
import 'package:grocerlytics/features/receipt/add_receipt/ui/add_receipt_page.dart'
    as _i2;
import 'package:grocerlytics/features/receipt/analyze_receipt/ui/analyze_receipt_page.dart'
    as _i3;
import 'package:grocerlytics/features/receipt/review_receipt/ui/review_receipt_page.dart'
    as _i7;
import 'package:grocerlytics/features/settings/ui/settings_page.dart' as _i8;
import 'package:grocerlytics/features/sign_in/sign_in_navigation_screen.dart'
    as _i9;
import 'package:grocerlytics/features/sign_in/ui/sign_in_page.dart' as _i10;
import 'package:grocerlytics/features/sign_in/verify_otp_sign_in/ui/verify_otp_sign_in_page.dart'
    as _i14;
import 'package:grocerlytics/features/spending/spending_category/ui/spending_category_page.dart'
    as _i11;
import 'package:grocerlytics/features/spending/ui/spending_cubit.dart' as _i17;
import 'package:grocerlytics/features/spending/ui/spending_page.dart' as _i12;
import 'package:image_picker/image_picker.dart' as _i18;

/// generated route for
/// [_i1.AddReceiptNavigationScreen]
class AddReceiptNavigationRoute
    extends _i15.PageRouteInfo<AddReceiptNavigationRouteArgs> {
  AddReceiptNavigationRoute({
    _i16.Key? key,
    required _i17.SpendingCubit spendingCubit,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          AddReceiptNavigationRoute.name,
          args: AddReceiptNavigationRouteArgs(
            key: key,
            spendingCubit: spendingCubit,
          ),
          initialChildren: children,
        );

  static const String name = 'AddReceiptNavigationRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddReceiptNavigationRouteArgs>();
      return _i1.AddReceiptNavigationScreen(
        key: args.key,
        spendingCubit: args.spendingCubit,
      );
    },
  );
}

class AddReceiptNavigationRouteArgs {
  const AddReceiptNavigationRouteArgs({
    this.key,
    required this.spendingCubit,
  });

  final _i16.Key? key;

  final _i17.SpendingCubit spendingCubit;

  @override
  String toString() {
    return 'AddReceiptNavigationRouteArgs{key: $key, spendingCubit: $spendingCubit}';
  }
}

/// generated route for
/// [_i2.AddReceiptPage]
class AddReceiptRoute extends _i15.PageRouteInfo<void> {
  const AddReceiptRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AddReceiptRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddReceiptRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.AddReceiptPage();
    },
  );
}

/// generated route for
/// [_i3.AnalyzeReceiptPage]
class AnalyzeReceiptRoute extends _i15.PageRouteInfo<AnalyzeReceiptRouteArgs> {
  AnalyzeReceiptRoute({
    _i16.Key? key,
    required _i18.XFile file,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          AnalyzeReceiptRoute.name,
          args: AnalyzeReceiptRouteArgs(
            key: key,
            file: file,
          ),
          initialChildren: children,
        );

  static const String name = 'AnalyzeReceiptRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnalyzeReceiptRouteArgs>();
      return _i3.AnalyzeReceiptPage(
        key: args.key,
        file: args.file,
      );
    },
  );
}

class AnalyzeReceiptRouteArgs {
  const AnalyzeReceiptRouteArgs({
    this.key,
    required this.file,
  });

  final _i16.Key? key;

  final _i18.XFile file;

  @override
  String toString() {
    return 'AnalyzeReceiptRouteArgs{key: $key, file: $file}';
  }
}

/// generated route for
/// [_i4.EmptyPage]
class EmptyRoute extends _i15.PageRouteInfo<void> {
  const EmptyRoute({List<_i15.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.EmptyPage();
    },
  );
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomePage();
    },
  );
}

/// generated route for
/// [_i6.NotFoundPage]
class NotFoundRoute extends _i15.PageRouteInfo<void> {
  const NotFoundRoute({List<_i15.PageRouteInfo>? children})
      : super(
          NotFoundRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotFoundRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i6.NotFoundPage();
    },
  );
}

/// generated route for
/// [_i7.ReviewReceiptPage]
class ReviewReceiptRoute extends _i15.PageRouteInfo<void> {
  const ReviewReceiptRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ReviewReceiptRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReviewReceiptRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.ReviewReceiptPage();
    },
  );
}

/// generated route for
/// [_i8.SettingsPage]
class SettingsRoute extends _i15.PageRouteInfo<void> {
  const SettingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i8.SettingsPage();
    },
  );
}

/// generated route for
/// [_i9.SignInNavigationScreen]
class SignInNavigationRoute extends _i15.PageRouteInfo<void> {
  const SignInNavigationRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SignInNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInNavigationRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i9.SignInNavigationScreen();
    },
  );
}

/// generated route for
/// [_i10.SignInPage]
class SignInRoute extends _i15.PageRouteInfo<void> {
  const SignInRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.SignInPage();
    },
  );
}

/// generated route for
/// [_i11.SpendingCategoryPage]
class SpendingCategoryRoute
    extends _i15.PageRouteInfo<SpendingCategoryRouteArgs> {
  SpendingCategoryRoute({
    _i16.Key? key,
    required int id,
    required String startDate,
    required String endDate,
    required int count,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          SpendingCategoryRoute.name,
          args: SpendingCategoryRouteArgs(
            key: key,
            id: id,
            startDate: startDate,
            endDate: endDate,
            count: count,
          ),
          rawPathParams: {
            'id': id,
            'start_date': startDate,
            'end_date': endDate,
            'count': count,
          },
          initialChildren: children,
        );

  static const String name = 'SpendingCategoryRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SpendingCategoryRouteArgs>(
          orElse: () => SpendingCategoryRouteArgs(
                id: pathParams.getInt('id'),
                startDate: pathParams.getString('start_date'),
                endDate: pathParams.getString('end_date'),
                count: pathParams.getInt('count'),
              ));
      return _i11.SpendingCategoryPage(
        key: args.key,
        id: args.id,
        startDate: args.startDate,
        endDate: args.endDate,
        count: args.count,
      );
    },
  );
}

class SpendingCategoryRouteArgs {
  const SpendingCategoryRouteArgs({
    this.key,
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.count,
  });

  final _i16.Key? key;

  final int id;

  final String startDate;

  final String endDate;

  final int count;

  @override
  String toString() {
    return 'SpendingCategoryRouteArgs{key: $key, id: $id, startDate: $startDate, endDate: $endDate, count: $count}';
  }
}

/// generated route for
/// [_i12.SpendingPage]
class SpendingRoute extends _i15.PageRouteInfo<void> {
  const SpendingRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SpendingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SpendingRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i12.SpendingPage();
    },
  );
}

/// generated route for
/// [_i13.ThemePage]
class ThemeRoute extends _i15.PageRouteInfo<void> {
  const ThemeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ThemeRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThemeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i13.ThemePage();
    },
  );
}

/// generated route for
/// [_i14.VerifyOtpSignInPage]
class VerifyOtpSignInRoute
    extends _i15.PageRouteInfo<VerifyOtpSignInRouteArgs> {
  VerifyOtpSignInRoute({
    _i16.Key? key,
    required String email,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          VerifyOtpSignInRoute.name,
          args: VerifyOtpSignInRouteArgs(
            key: key,
            email: email,
          ),
          rawPathParams: {'email': email},
          initialChildren: children,
        );

  static const String name = 'VerifyOtpSignInRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<VerifyOtpSignInRouteArgs>(
          orElse: () =>
              VerifyOtpSignInRouteArgs(email: pathParams.getString('email')));
      return _i14.VerifyOtpSignInPage(
        key: args.key,
        email: args.email,
      );
    },
  );
}

class VerifyOtpSignInRouteArgs {
  const VerifyOtpSignInRouteArgs({
    this.key,
    required this.email,
  });

  final _i16.Key? key;

  final String email;

  @override
  String toString() {
    return 'VerifyOtpSignInRouteArgs{key: $key, email: $email}';
  }
}
