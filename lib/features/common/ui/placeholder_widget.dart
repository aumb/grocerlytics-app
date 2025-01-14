import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({
    super.key,
    this.width,
  });

  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 20,
      width: width,
    );
  }
}
