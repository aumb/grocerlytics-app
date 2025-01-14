import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CircularIconWidget extends StatelessWidget {
  const CircularIconWidget({
    super.key,
    required this.icon,
    this.size = 40,
    this.iconSize = 24,
    this.backgroundColor,
    this.heroTag,
  });

  final IconData icon;
  final double iconSize;
  final double size;
  final Color? backgroundColor;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadDecorator(
      decoration: ShadDecoration(
        merge: false,
        color: backgroundColor ?? theme.colorScheme.ring,
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: heroTag != null
            ? Hero(
                tag: heroTag!,
                child: Icon(
                  icon,
                  color: theme.colorScheme.background,
                  size: iconSize,
                ),
              )
            : Icon(
                icon,
                color: theme.colorScheme.background,
                size: iconSize,
              ),
      ),
    );
  }
}
