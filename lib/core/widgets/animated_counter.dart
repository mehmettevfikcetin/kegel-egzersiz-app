import 'package:flutter/material.dart';

/// An integer that rolls smoothly to a new [value] whenever it changes.
///
/// Used for the home-screen streak so an increment animates rather than
/// snapping. Built on [TweenAnimationBuilder] keyed on the target value, so a
/// new value retargets the tween from the current displayed number.
class AnimatedCounter extends StatelessWidget {
  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
    this.builder,
  });

  final int value;
  final TextStyle? style;
  final Duration duration;
  final Curve curve;

  /// Optional formatter — receives the in-flight integer and returns the text
  /// to render (e.g. to wrap it in a localized string). Defaults to the number.
  final String Function(int current)? builder;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: value, end: value),
      duration: duration,
      curve: curve,
      builder: (context, current, _) => Text(
        builder?.call(current) ?? '$current',
        style: style,
      ),
    );
  }
}
