import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Shimmer.fromColors(
      baseColor: theme.colorScheme.border,
      highlightColor: theme.colorScheme.border.withValues(alpha: 0.6),
      child: child,
    );
  }
}
