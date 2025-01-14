import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/ui/primary_button.dart';
import 'package:grocerlytics/features/sign_in/ui/sign_in_cubit.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/ui/toasts.dart';
import 'package:grocerlytics/features/dependency_injection/injectable.dart';
import 'package:grocerlytics/router/router.gr.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final _formKey = GlobalKey<ShadFormState>();

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (context) => getIt.get<SignInCubit>(),
      child: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          switch (state.status) {
            case InitialStatus<SignInState>():
            case LoadingStatus<SignInState>():
            case EmptyStatus<SignInState>():
              break;
            case LoadedStatus<SignInState>():
              context.router.replace(VerifyOtpSignInRoute(email: state.email));
            case ErrorStatus<SignInState>():
              ShadToaster.of(context).show(
                errorToast(
                  body: 'There was a problem logging you in, please try again',
                ),
              );
          }
        },
        child: const SignInScreen(),
      ),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final state = context.select((SignInCubit c) => c.state);

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
                        LucideIcons.logIn,
                        size: 80,
                      ),
                      Text(
                        'By signing in you are tying all the data that you entered to your email, meaning if you decide to log out you will start from an empty state.',
                        style: theme.textTheme.muted,
                        textAlign: TextAlign.center,
                      ),
                      ShadInputFormField(
                        onSubmitted: (_) {
                          if (_formKey.currentState!.saveAndValidate()) {
                            context.read<SignInCubit>().signIn();
                          }
                        },
                        autofillHints: [AutofillHints.email],
                        enabled: !state.status.isLoading,
                        keyboardType: TextInputType.emailAddress,
                        placeholder: const Text('Email'),
                        onChanged: context.read<SignInCubit>().onEmailChanged,
                        validator: (v) {
                          const emailRegexPattern =
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                          final emailRegex = RegExp(emailRegexPattern);
                          if (v.isEmpty) {
                            return 'Email must not be empty';
                          } else if (!emailRegex.hasMatch(v)) {
                            return 'Email must be valid';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: PrimaryButton(
                  isEnabled: !state.status.isLoading,
                  isLoading: state.status.isLoading,
                  label: 'Continue',
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      context.read<SignInCubit>().signIn();
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
