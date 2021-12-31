import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import '../../analog_clock.dart';
import 'container_hand.dart';

class HourHand extends StatelessWidget {
  const HourHand({
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
    return Padding(
      padding: EdgeInsets.all(2 * unit),
      child: ContainerHand(
        color: Colors.transparent,
        size: 0.5,
        angleRadians:
            now.hour * radiansPerHour + (now.minute / 60) * radiansPerHour,
        child: Transform.translate(
          offset: Offset(0.0, -3 * unit),
          child: Semantics.fromProperties(
            properties: SemanticsProperties(
                value: '${now.hour}',
                label: 'Hour hand of the clock at position ${now.hour} hrs.'),
            child: Container(
              width: 1.5 * unit,
              height: 7 * unit,
              decoration: BoxDecoration(
                color: customTheme.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
