// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../app/app_cubit.dart' as _i180;
import '../auth/data/user_service.dart' as _i80;
import '../auth/domain/get_access_token_use_case.dart' as _i197;
import '../auth/domain/get_refresh_token_use_case.dart' as _i1018;
import '../auth/domain/get_user_id.dart' as _i222;
import '../auth/domain/get_user_use_case.dart' as _i801;
import '../auth/domain/save_access_token_use_case.dart' as _i824;
import '../auth/domain/save_refresh_token_use_case.dart' as _i142;
import '../auth/domain/save_user_id_use_case.dart' as _i733;
import '../auth/logout/data/logout_service.dart' as _i393;
import '../auth/logout/domain/logout_use_case.dart' as _i61;
import '../auth/logout/ui/logout_cubit.dart' as _i739;
import '../auth/ui/auth_cubit.dart' as _i752;
import '../common/categories/categories_cubit.dart' as _i234;
import '../common/categories/data/categories_service.dart' as _i129;
import '../common/categories/data/get_categories_local_service.dart' as _i1039;
import '../common/categories/data/save_categories_local_service.dart' as _i981;
import '../common/categories/domain/get_categories_use_case.dart' as _i55;
import '../common/currencies/data/currencies_service.dart' as _i817;
import '../common/currencies/data/get_currencies_local_service.dart' as _i500;
import '../common/currencies/data/save_currencies_local_service.dart' as _i1066;
import '../common/currencies/domain/get_currencies_use_case.dart' as _i404;
import '../common/currencies/ui/currencies_cubit.dart' as _i1026;
import '../common/local_storage/local_database.dart' as _i862;
import '../common/local_storage/local_storage.dart' as _i886;
import '../common/quantity_units/data/get_quantity_units_local_service.dart'
    as _i984;
import '../common/quantity_units/data/quantity_units_service.dart' as _i13;
import '../common/quantity_units/data/save_quantity_units_local_service.dart'
    as _i1011;
import '../common/quantity_units/domain/get_quantity_units_use_case.dart'
    as _i552;
import '../common/quantity_units/ui/quantity_units_cubit.dart' as _i961;
import '../common/receipt_details/data/delete_all_receipt_data_local_service.dart'
    as _i704;
import '../common/receipt_details/data/delete_all_receipt_data_service.dart'
    as _i930;
import '../common/receipt_details/data/get_receipt_details_service.dart'
    as _i449;
import '../common/receipt_details/data/save_receipt_details_local_service.dart'
    as _i176;
import '../common/receipt_details/data/sync_unassigned_receipts_details_service.dart'
    as _i870;
import '../common/receipt_details/data/unassigned_receipts_details_local_service.dart'
    as _i186;
import '../common/receipt_details/domain/delete_all_receipt_data_use_case.dart'
    as _i113;
import '../common/receipt_details/domain/get_receipt_details_use_case.dart'
    as _i563;
import '../common/receipt_details/domain/get_unassigned_receipts_details_use_case.dart'
    as _i582;
import '../common/receipt_details/domain/save_receipt_details_local_use_case.dart'
    as _i476;
import '../common/receipt_details/domain/sync_unassigned_receipts_details_use_case.dart'
    as _i679;
import '../common/receipt_details/ui/delete_receipt_details_cubit.dart'
    as _i1001;
import '../common/services/network_service.dart' as _i658;
import '../common/services/refresh_token/refresh_token_cubit.dart' as _i470;
import '../common/services/refresh_token/refresh_token_service.dart' as _i543;
import '../common/services/refresh_token/refresh_token_use_case.dart' as _i23;
import '../common/theme/domain/get_theme_use_case.dart' as _i923;
import '../common/theme/domain/save_theme_use_case.dart' as _i392;
import '../common/theme/ui/theme_cubit.dart' as _i562;
import '../receipt/add_receipt/ui/add_receipt_cubit.dart' as _i143;
import '../receipt/analyze_receipt/data/analyze_receipt_service.dart' as _i71;
import '../receipt/analyze_receipt/domain/analyze_receipt_use_case.dart'
    as _i616;
import '../receipt/analyze_receipt/ui/analyze_receipt_cubit.dart' as _i412;
import '../receipt/review_receipt/data/create_receipt_local_service.dart'
    as _i629;
import '../receipt/review_receipt/data/create_receipt_service.dart' as _i402;
import '../receipt/review_receipt/domain/create_receipt_use_case.dart' as _i715;
import '../receipt/review_receipt/ui/review_receipt_cubit.dart' as _i744;
import '../sign_in/data/sign_in_service.dart' as _i1052;
import '../sign_in/domain/sign_in_use_case.dart' as _i442;
import '../sign_in/ui/sign_in_cubit.dart' as _i848;
import '../sign_in/verify_otp_sign_in/data/verify_otp_sign_in_service.dart'
    as _i683;
import '../sign_in/verify_otp_sign_in/domain/verify_otp_sign_in_use_case.dart'
    as _i203;
import '../sign_in/verify_otp_sign_in/ui/verify_otp_sign_in_cubit.dart'
    as _i102;
import '../spending/data/spending_local_service.dart' as _i495;
import '../spending/data/spending_service.dart' as _i186;
import '../spending/domain/get_spending_use_case.dart' as _i141;
import '../spending/spending_category/data/spending_category_local_service.dart'
    as _i785;
import '../spending/spending_category/domain/get_spending_category_use_case.dart'
    as _i1008;
import '../spending/spending_category/ui/spending_category_cubit.dart' as _i695;
import '../spending/ui/spending_cubit.dart' as _i536;
import '../sync/ui/sync_cubit.dart' as _i37;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i180.AppCubit>(() => _i180.AppCubit());
    gh.factory<_i143.AddReceiptCubit>(() => _i143.AddReceiptCubit());
    gh.lazySingleton<_i1066.SaveCurrenciesLocalService>(
        () => _i1066.SaveCurrenciesLocalService(gh<_i862.LocalDatabase>()));
    gh.lazySingleton<_i500.GetCurrenciesLocalService>(
        () => _i500.GetCurrenciesLocalService(gh<_i862.LocalDatabase>()));
    gh.lazySingleton<_i1011.SaveQuantityUnitsLocalService>(
        () => _i1011.SaveQuantityUnitsLocalService(gh<_i862.LocalDatabase>()));
    gh.lazySingleton<_i984.GetQuantityUnitsLocalService>(
        () => _i984.GetQuantityUnitsLocalService(gh<_i862.LocalDatabase>()));
    gh.lazySingleton<_i981.SaveCategoriesLocalService>(
        () => _i981.SaveCategoriesLocalService(gh<_i862.LocalDatabase>()));
    gh.lazySingleton<_i1039.GetCategoriesLocalService>(
        () => _i1039.GetCategoriesLocalService(gh<_i862.LocalDatabase>()));
    gh.lazySingleton<_i785.SpendingCategoryLocalService>(() =>
        _i785.SpendingCategoryLocalService(
            localDatabase: gh<_i862.LocalDatabase>()));
    gh.lazySingleton<_i495.SpendingLocalService>(() =>
        _i495.SpendingLocalService(localDatabase: gh<_i862.LocalDatabase>()));
    gh.lazySingleton<_i176.SaveReceiptDetailsLocalService>(() =>
        _i176.SaveReceiptDetailsLocalService(
            localDatabase: gh<_i862.LocalDatabase>()));
    gh.lazySingleton<_i186.UnassignedReceiptsDetailsLocalService>(() =>
        _i186.UnassignedReceiptsDetailsLocalService(
            localDatabase: gh<_i862.LocalDatabase>()));
    gh.lazySingleton<_i629.CreateReceiptLocalService>(() =>
        _i629.CreateReceiptLocalService(
            localDatabase: gh<_i862.LocalDatabase>()));
    gh.lazySingleton<_i704.DeleteAllReceiptDataLocalService>(() =>
        _i704.DeleteAllReceiptDataLocalService(
            localDatabase: gh<_i862.LocalDatabase>()));
    gh.lazySingleton<_i1008.GetSpendingCategoryUseCase>(() =>
        _i1008.GetSpendingCategoryUseCase(
            spendingCategoryLocalService:
                gh<_i785.SpendingCategoryLocalService>()));
    gh.lazySingleton<_i886.LocalStorage>(() =>
        _i886.LocalStorage(sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i582.GetUnassignedReceiptsDetailsUseCase>(() =>
        _i582.GetUnassignedReceiptsDetailsUseCase(
            unassignedReceiptsDetailsLocalService:
                gh<_i186.UnassignedReceiptsDetailsLocalService>()));
    gh.lazySingleton<_i476.SaveReceiptDetailsLocalUseCase>(() =>
        _i476.SaveReceiptDetailsLocalUseCase(
            saveReceiptDetailsLocalService:
                gh<_i176.SaveReceiptDetailsLocalService>()));
    gh.lazySingleton<_i658.NetworkService>(() => _i658.NetworkService(
          dio: gh<_i361.Dio>(),
          localStorage: gh<_i886.LocalStorage>(),
        ));
    gh.lazySingleton<_i141.GetSpendingUseCase>(() => _i141.GetSpendingUseCase(
        spendingLocalService: gh<_i495.SpendingLocalService>()));
    gh.lazySingleton<_i1018.GetRefreshTokenUseCase>(() =>
        _i1018.GetRefreshTokenUseCase(localStorage: gh<_i886.LocalStorage>()));
    gh.lazySingleton<_i222.GetUserIdUseCase>(
        () => _i222.GetUserIdUseCase(localStorage: gh<_i886.LocalStorage>()));
    gh.lazySingleton<_i142.SaveRefreshTokenUseCase>(() =>
        _i142.SaveRefreshTokenUseCase(localStorage: gh<_i886.LocalStorage>()));
    gh.lazySingleton<_i824.SaveAccessTokenUseCase>(() =>
        _i824.SaveAccessTokenUseCase(localStorage: gh<_i886.LocalStorage>()));
    gh.lazySingleton<_i733.SaveUserIdUseCase>(
        () => _i733.SaveUserIdUseCase(localStorage: gh<_i886.LocalStorage>()));
    gh.lazySingleton<_i197.GetAccessTokenUseCase>(() =>
        _i197.GetAccessTokenUseCase(localStorage: gh<_i886.LocalStorage>()));
    gh.lazySingleton<_i923.GetSavedThemeUseCase>(() =>
        _i923.GetSavedThemeUseCase(localStorage: gh<_i886.LocalStorage>()));
    gh.lazySingleton<_i392.SaveThemeUseCase>(
        () => _i392.SaveThemeUseCase(localStorage: gh<_i886.LocalStorage>()));
    gh.factory<_i695.SpendingCategoryCubit>(() => _i695.SpendingCategoryCubit(
        spendingCategoryUseCase: gh<_i1008.GetSpendingCategoryUseCase>()));
    gh.lazySingleton<_i543.RefreshTokenService>(() =>
        _i543.RefreshTokenService(networkService: gh<_i658.NetworkService>()));
    gh.factory<_i536.SpendingCubit>(() => _i536.SpendingCubit(
        getSpendingUseCase: gh<_i141.GetSpendingUseCase>()));
    gh.factory<_i562.ThemeCubit>(() => _i562.ThemeCubit(
          getSavedThemeUseCase: gh<_i923.GetSavedThemeUseCase>(),
          saveThemeUseCase: gh<_i392.SaveThemeUseCase>(),
        ));
    gh.lazySingleton<_i683.VerifyOtpSignInService>(
        () => _i683.VerifyOtpSignInService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i1052.SignInService>(
        () => _i1052.SignInService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i80.UserService>(
        () => _i80.UserService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i186.SpendingService>(
        () => _i186.SpendingService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i817.CurrenciesService>(
        () => _i817.CurrenciesService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i13.QuantityUnitsService>(
        () => _i13.QuantityUnitsService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i129.CategoriesService>(
        () => _i129.CategoriesService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i449.GetReceiptDetailsService>(
        () => _i449.GetReceiptDetailsService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i870.SyncUnassignedReceiptsDetailsService>(() =>
        _i870.SyncUnassignedReceiptsDetailsService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i402.CreateReceiptService>(
        () => _i402.CreateReceiptService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i71.AnalyzeReceiptService>(
        () => _i71.AnalyzeReceiptService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i393.LogoutService>(
        () => _i393.LogoutService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i930.DeleteAllReceiptDataService>(
        () => _i930.DeleteAllReceiptDataService(gh<_i658.NetworkService>()));
    gh.lazySingleton<_i23.RefreshTokenUseCase>(() => _i23.RefreshTokenUseCase(
          localStorage: gh<_i886.LocalStorage>(),
          refreshTokenService: gh<_i543.RefreshTokenService>(),
        ));
    gh.lazySingleton<_i715.CreateReceiptUseCase>(
        () => _i715.CreateReceiptUseCase(
              createReceiptService: gh<_i402.CreateReceiptService>(),
              createReceiptLocalService: gh<_i629.CreateReceiptLocalService>(),
            ));
    gh.lazySingleton<_i442.SignInUseCase>(
        () => _i442.SignInUseCase(signInService: gh<_i1052.SignInService>()));
    gh.lazySingleton<_i113.DeleteAllReceiptDataUseCase>(() =>
        _i113.DeleteAllReceiptDataUseCase(
          deleteAllReceiptDataLocalService:
              gh<_i704.DeleteAllReceiptDataLocalService>(),
          deleteAllReceiptDataService: gh<_i930.DeleteAllReceiptDataService>(),
          localStorage: gh<_i886.LocalStorage>(),
        ));
    gh.lazySingleton<_i203.VerifyOtpSignInUseCase>(() =>
        _i203.VerifyOtpSignInUseCase(
            verifyOtpSignInService: gh<_i683.VerifyOtpSignInService>()));
    gh.lazySingleton<_i563.GetReceiptDetailsUseCase>(() =>
        _i563.GetReceiptDetailsUseCase(
            getReceiptDetailsService: gh<_i449.GetReceiptDetailsService>()));
    gh.lazySingleton<_i55.GetCategoriesUseCase>(() => _i55.GetCategoriesUseCase(
          service: gh<_i129.CategoriesService>(),
          getCategoriesLocalService: gh<_i1039.GetCategoriesLocalService>(),
          saveCategoriesLocalService: gh<_i981.SaveCategoriesLocalService>(),
        ));
    gh.factory<_i102.VerifyOtpSignInCubit>(() => _i102.VerifyOtpSignInCubit(
          verifyOtpSignInUseCase: gh<_i203.VerifyOtpSignInUseCase>(),
          saveAccessTokenCase: gh<_i824.SaveAccessTokenUseCase>(),
          saveRefreshTokenCase: gh<_i142.SaveRefreshTokenUseCase>(),
          saveUserIdUseCase: gh<_i733.SaveUserIdUseCase>(),
        ));
    gh.factory<_i744.ReviewReceiptCubit>(() => _i744.ReviewReceiptCubit(
        createReceiptUseCase: gh<_i715.CreateReceiptUseCase>()));
    gh.lazySingleton<_i61.LogoutUseCase>(() => _i61.LogoutUseCase(
          logoutService: gh<_i393.LogoutService>(),
          localStorage: gh<_i886.LocalStorage>(),
        ));
    gh.lazySingleton<_i679.SyncUnassignedReceiptsDetailsUseCase>(() =>
        _i679.SyncUnassignedReceiptsDetailsUseCase(
            syncUnassignedReceiptsDetailsService:
                gh<_i870.SyncUnassignedReceiptsDetailsService>()));
    gh.lazySingleton<_i801.GetUserUseCase>(
        () => _i801.GetUserUseCase(userService: gh<_i80.UserService>()));
    gh.lazySingleton<_i404.GetCurrenciesUseCase>(() =>
        _i404.GetCurrenciesUseCase(
          service: gh<_i817.CurrenciesService>(),
          saveCurrenciesLocalService: gh<_i1066.SaveCurrenciesLocalService>(),
          getCurrenciesLocalService: gh<_i500.GetCurrenciesLocalService>(),
        ));
    gh.lazySingleton<_i616.AnalyzeReceiptUseCase>(() =>
        _i616.AnalyzeReceiptUseCase(
            analyzeReceiptService: gh<_i71.AnalyzeReceiptService>()));
    gh.factory<_i1026.CurrenciesCubit>(() => _i1026.CurrenciesCubit(
        getCurrenciesUseCase: gh<_i404.GetCurrenciesUseCase>()));
    gh.lazySingleton<_i470.RefreshTokenCubit>(() => _i470.RefreshTokenCubit(
        refreshTokenUseCase: gh<_i23.RefreshTokenUseCase>()));
    gh.factory<_i37.SyncCubit>(() => _i37.SyncCubit(
          getUserUseCase: gh<_i801.GetUserUseCase>(),
          getAccessTokenUseCase: gh<_i197.GetAccessTokenUseCase>(),
          getUnassignedReceiptsDetailsUseCase:
              gh<_i582.GetUnassignedReceiptsDetailsUseCase>(),
          syncUnassignedReceiptsDetailsUseCase:
              gh<_i679.SyncUnassignedReceiptsDetailsUseCase>(),
          getReceiptDetailsUseCase: gh<_i563.GetReceiptDetailsUseCase>(),
          saveReceiptDetailsLocalUseCase:
              gh<_i476.SaveReceiptDetailsLocalUseCase>(),
          getUserIdUseCase: gh<_i222.GetUserIdUseCase>(),
        ));
    gh.lazySingleton<_i552.GetQuantityUnitsUseCase>(
        () => _i552.GetQuantityUnitsUseCase(
              service: gh<_i13.QuantityUnitsService>(),
              getQuantityUnitsLocalService:
                  gh<_i984.GetQuantityUnitsLocalService>(),
              saveQuantityUnitsLocalService:
                  gh<_i1011.SaveQuantityUnitsLocalService>(),
            ));
    gh.factory<_i848.SignInCubit>(() => _i848.SignInCubit(
          signInUseCase: gh<_i442.SignInUseCase>(),
          getUnassignedReceiptsDetailsUseCase:
              gh<_i582.GetUnassignedReceiptsDetailsUseCase>(),
        ));
    gh.factory<_i752.AuthCubit>(() => _i752.AuthCubit(
          getUserUseCase: gh<_i801.GetUserUseCase>(),
          logoutUseCase: gh<_i61.LogoutUseCase>(),
          getAccessTokenUseCase: gh<_i197.GetAccessTokenUseCase>(),
        ));
    gh.factory<_i234.CategoriesCubit>(() => _i234.CategoriesCubit(
        getCategoriesUseCase: gh<_i55.GetCategoriesUseCase>()));
    gh.factory<_i1001.DeleteReceiptDetailsCubit>(() =>
        _i1001.DeleteReceiptDetailsCubit(
            deleteAllReceiptDataUseCase:
                gh<_i113.DeleteAllReceiptDataUseCase>()));
    gh.factory<_i739.LogoutCubit>(
        () => _i739.LogoutCubit(logoutUseCase: gh<_i61.LogoutUseCase>()));
    gh.factory<_i412.AnalyzeReceiptCubit>(() => _i412.AnalyzeReceiptCubit(
        analyzeReceiptUseCase: gh<_i616.AnalyzeReceiptUseCase>()));
    gh.factory<_i961.QuantityUnitsCubit>(() => _i961.QuantityUnitsCubit(
        getQuantityUnitsUseCase: gh<_i552.GetQuantityUnitsUseCase>()));
    return this;
  }
}
