import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'animated_container_hand.dart';

class SecondHand extends StatelessWidget {
  const SecondHand({
    Key? key,
    required this.now,
    required this.unit,
    required this.customTheme,
  }) : super(key: key);

  final DateTime now;
  final double unit;
  final ThemeData customTheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainerHand(
      now: now.second,
      size: 0.6,
      child: Transform.translate(
        offset: Offset(0.0, -4 * unit),
        child: Semantics.fromProperties(
          properties: SemanticsProperties(
              value: '${now.second}',
              label:
                  'Seconds hand of the clock at position ${now.second} sec.'),
          child: Container(
            width: unit / 2,
            height: double.infinity,
            decoration: BoxDecoration(
              color: customTheme.colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
