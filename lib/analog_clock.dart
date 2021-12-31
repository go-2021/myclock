// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'helper/model.dart';
import 'icons/weather_icons_icons.dart';
import 'icons/widgets/animated_icon.dart';
import 'icons/widgets/clock_pin.dart';
import 'icons/widgets/clock_ticks.dart';
import 'icons/widgets/hour_hand.dart';
import 'icons/widgets/hour_hand_shadow.dart';
import 'icons/widgets/inner_shadows.dart';
import 'icons/widgets/minute_hand.dart';
import 'icons/widgets/minute_hand_shadow.dart';
import 'icons/widgets/outer_shadows.dart';
import 'icons/widgets/second_hand.dart';
import 'icons/widgets/second_hand_circle.dart';
import 'icons/widgets/second_hand_shadow.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// A basic analog clock.
///
/// You can do better than this!
class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model, {Key? key}) : super(key: key);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = DateTime.now();
  late WeatherCondition _condition;
  late Timer _timer;

  final weatherMap = {
    WeatherCondition.sunny: WeatherIcons.sun,
    WeatherCondition.cloudy: WeatherIcons.cloudSolid,
    WeatherCondition.foggy: WeatherIcons.smogSolid,
    WeatherCondition.rainy: WeatherIcons.cloudRainSolid,
    WeatherCondition.thunderstorm: WeatherIcons.boltSolid,
    WeatherCondition.snowy: WeatherIcons.cloudMeatballSolid,
    WeatherCondition.windy: WeatherIcons.windSolid,
  };

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _condition = widget.model.weatherCondition;
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        const Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            // Hour hand.
            primaryColor: Colors.grey[800],
            // Minute hand.
            highlightColor: Colors.grey[800],
            // Second hand.
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.red[800]),
            // Tick color
            cursorColor: Colors.grey[900],
            // Shadow color
            canvasColor: Colors.grey[500],
            // Inner shadow color
            dividerColor: Colors.grey[400],
            // Icon color:
            errorColor: Colors.grey[800]!.withOpacity(0.1),
            backgroundColor: Colors.grey[300],
          )
        : Theme.of(context).copyWith(
            // Hour hand.
            primaryColor: Colors.grey[400],
            // Minute hand.
            highlightColor: Colors.grey[400],
            // Second hand.
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.red[800]),
            // Tick color
            cursorColor: Colors.grey[900],
            // Shadow color
            canvasColor: Colors.grey[900],
            // Inner shadow color
            dividerColor: Colors.grey[900],
            // Icon color:
            errorColor: Colors.grey[400]!.withOpacity(0.1),
            backgroundColor: const Color(0xFF3C4043),
          );

    // final time = DateFormat.Hms().format(DateTime.now());

    IconData icon = weatherMap[_condition] ?? WeatherIcons.sun;
    // icon = WeatherIcons.moon; // 月亮

    return LayoutBuilder(
      builder: (context, constraints) {
        // final unit = constraints.biggest.width / 50;
        final unit = constraints.biggest.width / 26;

        return Semantics.fromProperties(
          properties: const SemanticsProperties(
            label: 'Analog clock with time',
            value: "2021-12-24",
          ),
          child: Container(
            // padding: EdgeInsets.all(2 * unit),
            // color: customTheme.backgroundColor,
            child: Stack(
              children: [
                OuterShadows(customTheme: customTheme, unit: unit),
                AnimatedClockIcon(
                    customTheme: customTheme, unit: unit, icon: icon),
                InnerShadows(customTheme: customTheme, unit: unit),
                ClockTicks(customTheme: customTheme, unit: unit),
                HourHandShadow(customTheme: customTheme, unit: unit, now: _now),
                MinuteHandShadow(
                    customTheme: customTheme, unit: unit, now: _now),
                SecondHandShadow(
                    customTheme: customTheme, unit: unit, now: _now),
                HourHand(customTheme: customTheme, unit: unit, now: _now),
                MinuteHand(customTheme: customTheme, unit: unit, now: _now),
                SecondHand(customTheme: customTheme, now: _now, unit: unit),
                SecondHandCircle(
                    customTheme: customTheme, now: _now, unit: unit),
                ClockPin(customTheme: customTheme, unit: unit),
              ],
            ),
          ),
        );
      },
    );
  }
}
