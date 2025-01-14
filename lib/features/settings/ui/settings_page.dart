import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:grocerlytics/features/settings/ui/widgets/auth_widget.dart';
import 'package:grocerlytics/features/settings/ui/widgets/contact_us_widget.dart';
import 'package:grocerlytics/features/settings/ui/widgets/delete_data_widget.dart';
import 'package:grocerlytics/features/settings/ui/widgets/license_widget.dart';
import 'package:grocerlytics/features/settings/ui/widgets/theme_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen();
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'General',
                style: theme.textTheme.large,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: ThemeWidget()),
          const SliverToBoxAdapter(child: Divider()),
          const SliverToBoxAdapter(child: ContactUsWidget()),
          const SliverToBoxAdapter(child: Divider()),
          const SliverToBoxAdapter(child: LicenseWidget()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Account',
                style: theme.textTheme.large,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: AuthWidget()),
          const SliverToBoxAdapter(child: DeleteDataWidget()),
        ],
      ),
    );
  }
}
