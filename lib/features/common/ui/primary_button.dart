import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.label = '',
    this.isEnabled = true,
    this.isLoading = false,
  });

  final String label;
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadButton(
      enabled: isEnabled,
      onPressed: onPressed,
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                backgroundColor: theme.colorScheme.background,
              ),
            )
          : Text(label),
    );
  }
}
