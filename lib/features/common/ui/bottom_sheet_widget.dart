import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DraggableBottomSheetWidget extends StatelessWidget {
  const DraggableBottomSheetWidget({
    super.key,
    required this.child,
    required this.scrollController,
    this.persistentHeaderDelegate,
  });

  final SliverPersistentHeaderDelegate? persistentHeaderDelegate;
  final ScrollController scrollController;

  /// Must be a sliver
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadDecorator(
      decoration: ShadDecoration(
        merge: false,
        border: const ShadBorder(
          radius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        shadows: [
          BoxShadow(
            color: theme.colorScheme.primary.withAlpha(30),
            spreadRadius: 4,
            blurRadius: 20,
          ),
        ],
        color: theme.colorScheme.accent,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            if (persistentHeaderDelegate != null)
              SliverPersistentHeader(
                pinned: true,
                delegate: persistentHeaderDelegate!,
              ),
            child,
          ],
        ),
      ),
    );
  }
}
