import 'package:flutter/material.dart';

import 'clock.dart';
import 'icons/weather_icons_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var icons = [
      WeatherIcons.cloudSunRainSolid,
      WeatherIcons.cloudSunSolid,
      WeatherIcons.cloudRainSolid,
      WeatherIcons.cloudShowersHeavySolid,
      WeatherIcons.cloudSolid,
      WeatherIcons.cloudMoonRainSolid,
      WeatherIcons.cloudMoonSolid,
      WeatherIcons.cloudMeatballSolid,
      WeatherIcons.windSolid,
      WeatherIcons.boltSolid,
      WeatherIcons.sunSolid,
      WeatherIcons.sun,
      WeatherIcons.tintSlashSolid,
      WeatherIcons.tintSolid,
      WeatherIcons.smogSolid,
      WeatherIcons.moonSolid,
      WeatherIcons.moon,
    ];

    List<Widget> children = icons
        .map((e) => Icon(
              e,
              color: Colors.red,
              size: 50,
            ))
        .toList();

    // children.add(const SizedBox(
    //   width: 400,
    //   height: 400,
    //   child: MyClock(),
    // ));

    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 400,
            height: 400,
            child: MyClock(),
          ),
          // child: SingleChildScrollView(
          //   child: Column(
          //     children: children,
          //   ),
          // ),
        ),
      ),
    );
  }
}
