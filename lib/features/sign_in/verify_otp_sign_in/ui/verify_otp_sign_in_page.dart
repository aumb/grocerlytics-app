import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/app/app_cubit.dart';
import 'package:grocerlytics/features/auth/ui/auth_cubit.dart';
import 'package:grocerlytics/features/common/categories/categories_cubit.dart';
import 'package:grocerlytics/features/common/currencies/ui/currencies_cubit.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/quantity_units/ui/quantity_units_cubit.dart';
import 'package:grocerlytics/features/common/ui/primary_button.dart';
import 'package:grocerlytics/features/common/ui/toasts.dart';
import 'package:grocerlytics/features/dependency_injection/injectable.dart';
import 'package:grocerlytics/features/sign_in/verify_otp_sign_in/ui/verify_otp_sign_in_cubit.dart';
import 'package:grocerlytics/features/sync/ui/sync_cubit.dart';
import 'package:grocerlytics/router/router.gr.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final _formKey = GlobalKey<ShadFormState>();

@RoutePage()
class VerifyOtpSignInPage extends StatelessWidget {
  const VerifyOtpSignInPage({
    super.key,
    @PathParam('email') required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerifyOtpSignInCubit>(
      create: (context) => getIt.get<VerifyOtpSignInCubit>(),
      child: BlocListener<VerifyOtpSignInCubit, VerifyOtpSignInState>(
        listener: (context, state) {
          switch (state.status) {
            case InitialStatus<VerifyOtpSignInState>():
            case LoadingStatus<VerifyOtpSignInState>():
            case EmptyStatus<VerifyOtpSignInState>():
              break;
            case LoadedStatus<VerifyOtpSignInState>():
              context.router
                  .pushAndPopUntil(const HomeRoute(), predicate: (_) => false);
              context.read<AppCubit>().init(
                    context.read<CurrenciesCubit>().init,
                    context.read<QuantityUnitsCubit>().init,
                    context.read<CategoriesCubit>().init,
                    context.read<AuthCubit>().fetchUser,
                    context.read<SyncCubit>().syncWithServer,
                  );

            case ErrorStatus<VerifyOtpSignInState>():
              ShadToaster.of(context).show(
                errorToast(
                  body:
                      'There was a problem verifying your account, please try again',
                ),
              );
          }
        },
        child: VerifyOtpSignInScreen(
          email: email,
        ),
      ),
    );
  }
}

class VerifyOtpSignInScreen extends StatelessWidget {
  const VerifyOtpSignInScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final state = context.select((VerifyOtpSignInCubit c) => c.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        leading: const AutoLeadingButton(),
      ),
      body: SafeArea(
        child: ShadForm(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 16,
                    children: [
                      const Icon(
                        LucideIcons.binary,
                        size: 80,
                      ),
                      Text(
                        'We have sent a single-use code to $email - please enter it below',
                        style: theme.textTheme.muted,
                        textAlign: TextAlign.center,
                      ),
                      ShadInputOTPFormField(
                        enabled: !state.status.isLoading,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (v) {
                          if (v.contains(' ')) {
                            return 'Fill the whole OTP code';
                          }
                          return null;
                        },
                        onChanged:
                            context.read<VerifyOtpSignInCubit>().onOtpChanged,
                        children: const [
                          ShadInputOTPGroup(
                            children: [
                              ShadInputOTPSlot(),
                              ShadInputOTPSlot(),
                              ShadInputOTPSlot(),
                            ],
                          ),
                          ShadImage.square(size: 24, LucideIcons.dot),
                          ShadInputOTPGroup(
                            children: [
                              ShadInputOTPSlot(),
                              ShadInputOTPSlot(),
                              ShadInputOTPSlot(),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: PrimaryButton(
                  label: 'Submit',
                  isEnabled: !state.status.isLoading,
                  isLoading: state.status.isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      context.read<VerifyOtpSignInCubit>().submit(email);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
