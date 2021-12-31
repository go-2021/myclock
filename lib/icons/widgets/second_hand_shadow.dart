import 'package:flutter/material.dart';

import 'animated_container_hand.dart';

class SecondHandShadow extends StatelessWidget {
  const SecondHandShadow({
    Key? key,
    required this.unit,
    required this.now,
    required this.customTheme,
  }) : super(key: key);

  final double unit;
  final DateTime now;
  final ThemeData customTheme;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(unit / 2, unit / 1.9),
      child: AnimatedContainerHand(
        now: now.second,
        size: 0.6,
        child: Transform.translate(
          offset: Offset(0.0, -4 * unit),
          child: Container(
            width: unit / 3,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: customTheme.canvasColor,
                  blurRadius: unit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
