import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/app/app_cubit.dart';
import 'package:grocerlytics/features/auth/ui/auth_cubit.dart';
import 'package:grocerlytics/features/common/categories/categories_cubit.dart';
import 'package:grocerlytics/features/common/currencies/ui/currencies_cubit.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/quantity_units/ui/quantity_units_cubit.dart';
import 'package:grocerlytics/features/common/receipt_details/ui/delete_receipt_details_cubit.dart';
import 'package:grocerlytics/features/common/ui/dialogs.dart';
import 'package:grocerlytics/features/common/ui/toasts.dart';
import 'package:grocerlytics/features/dependency_injection/injectable.dart';
import 'package:grocerlytics/features/settings/ui/settings_page.dart';
import 'package:grocerlytics/features/sync/ui/sync_cubit.dart';
import 'package:grocerlytics/router/router.gr.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DeleteDataWidget extends StatelessWidget {
  const DeleteDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return BlocProvider<DeleteReceiptDetailsCubit>(
      create: (_) => getIt.get<DeleteReceiptDetailsCubit>(),
      child: BlocConsumer<DeleteReceiptDetailsCubit, DeleteReceiptDetailsState>(
        listener: (_, state) {
          switch (state.status) {
            case InitialStatus<DeleteReceiptDetailsState>():
            case LoadingStatus<DeleteReceiptDetailsState>():
            case EmptyStatus<DeleteReceiptDetailsState>():
              break;
            case ErrorStatus<DeleteReceiptDetailsState>():
              ShadToaster.of(context).show(
                errorToast(
                  body:
                      'There was a problem deleting your data, please try again',
                ),
              );
            case LoadedStatus<DeleteReceiptDetailsState>():
              context.read<AuthCubit>().resetAuth();
              context.router
                  .pushAndPopUntil(const HomeRoute(), predicate: (_) => false);

              context.read<AppCubit>().init(
                    context.read<CurrenciesCubit>().init,
                    context.read<QuantityUnitsCubit>().init,
                    context.read<CategoriesCubit>().init,
                    context.read<AuthCubit>().fetchUser,
                    context.read<SyncCubit>().syncWithServer,
                  );
          }
        },
        builder: (context, state) => ListTile(
          enabled: !state.status.isLoading,
          leading: state.status.isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.destructive,
                  ),
                )
              : Icon(
                  LucideIcons.trash2,
                  color: theme.colorScheme.destructive,
                ),
          onTap: () async {
            final res = await showShadDialog(
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(18),
                child: confirmDialog(
                  context: context,
                  title: 'Are you absolutely sure?',
                  description:
                      'This action cannot be undone. This will permanently delete your data locally and remove your data from our servers if you are logged in, along with your account.',
                  trackingPage: '$SettingsPage',
                ),
              ),
            );

            if (res && context.mounted) {
              context.read<DeleteReceiptDetailsCubit>().deleteData(
                    context.read<AuthCubit>().state.user.id,
                  );
            }
          },
          title: Text(
            'Delete data',
            style: TextStyle(
              color: theme.colorScheme.destructive,
            ),
          ),
        ),
      ),
    );
  }
}
