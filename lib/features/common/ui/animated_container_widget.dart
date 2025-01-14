import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/ui/custom_animated_cross_fade.dart';

class AnimatedContainerWidget extends StatelessWidget {
  const AnimatedContainerWidget({
    super.key,
    required this.firstChild,
    required this.secondChild,
    required this.isLoading,
    this.layoutBuilder,
  });

  /// Loading widget
  final Widget firstChild;

  /// Loaded widget
  final Widget secondChild;
  final Widget Function(Widget, Key, Widget, Key)? layoutBuilder;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      firstChild: firstChild,
      secondChild: secondChild,
      layoutBuilder: layoutBuilder ?? defaultLayoutBuilder,
      crossFadeState:
          isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  Widget defaultLayoutBuilder(Widget topChild, Key topChildKey,
      Widget bottomChild, Key bottomChildKey) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          key: bottomChildKey,
          left: 0.0,
          top: 0.0,
          right: 0.0,
          child: bottomChild,
        ),
        Positioned(
          key: topChildKey,
          child: topChild,
        ),
      ],
    );
  }
}
