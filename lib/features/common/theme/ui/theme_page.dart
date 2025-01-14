import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/theme/ui/theme_cubit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModes = ThemeMode.values;
    final state = context.select((ThemeCubit c) => c.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
        leading: const AutoLeadingButton(),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: themeModes.length,
          separatorBuilder: (_, index) => const Divider(),
          itemBuilder: (_, index) => ListTile(
            onTap: () => context.read<ThemeCubit>().setTheme(themeModes[index]),
            title: Text(themeModes[index].label),
            trailing: themeModes[index] == state
                ? const Icon(LucideIcons.check)
                : null,
          ),
        ),
      ),
    );
  }
}

extension ThemeModeX on ThemeMode {
  String get label => switch (this) {
        ThemeMode.system => 'System',
        ThemeMode.light => 'Light',
        ThemeMode.dark => 'Dark',
      };
}
