import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:grocerlytics/router/router.gr.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(LucideIcons.palette),
      onTap: () => context.router.navigate(const ThemeRoute()),
      trailing: const Icon(LucideIcons.chevronRight),
      title: const Text('Theme'),
    );
  }
}
