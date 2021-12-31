import 'package:flutter/material.dart';

import '../../analog_clock.dart';
import 'container_hand.dart';

class AnimatedContainerHand extends StatelessWidget {
  const AnimatedContainerHand({
    Key? key,
    required this.now,
    required this.child,
    required this.size,
  }) : super(key: key);

  final int now;
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (now == 0) {
      return TweenAnimationBuilder<double>(
        key: const ValueKey('special_case_when_overflowing'),
        duration: const Duration(milliseconds: 300),
        tween: Tween<double>(
          begin: value(now - 1),
          end: value(now),
        ),
        curve: Curves.easeInQuint,
        builder: (context, anim, child) {
          return ContainerHand(
            color: Colors.transparent,
            size: size,
            angleRadians: anim,
            child: child ?? const SizedBox(),
          );
        },
        child: child,
      );
    }
    return TweenAnimationBuilder<double>(
      key: const ValueKey('normal_case'),
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(
        begin: value(now - 1),
        end: value(now),
      ),
      curve: Curves.easeInQuint,
      builder: (context, anim, child) {
        return ContainerHand(
          color: Colors.transparent,
          size: size,
          angleRadians: anim,
          child: child ?? const SizedBox(),
        );
      },
      child: child,
    );
  }

  double value(int second) {
    return second * radiansPerTick;
  }
}
