import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/auth/logout/ui/logout_widget.dart';
import 'package:grocerlytics/features/auth/ui/auth_cubit.dart';
import 'package:grocerlytics/router/router.gr.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return context.read<AuthCubit>().state.isNotLoggedIn
        ? ListTile(
            leading: const Icon(LucideIcons.logIn),
            onTap: () => context.router.navigate(const SignInRoute()),
            trailing: const Icon(LucideIcons.chevronRight),
            title: const Text('Login'),
          )
        : const LogoutWidget();
  }
}
