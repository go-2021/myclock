import 'package:flutter/cupertino.dart';

import 'analog_clock.dart';
import 'helper/model.dart';

class MyClock extends StatefulWidget {
  const MyClock({Key? key}) : super(key: key);

  @override
  _MyClockState createState() {
    return _MyClockState();
  }
}

class _MyClockState extends State<MyClock> {
  final _model = ClockModel();

  @override
  void initState() {
    super.initState();
    _model.addListener(_handleModelChange);
  }

  @override
  void dispose() {
    _model.removeListener(_handleModelChange);
    _model.dispose();
    super.dispose();
  }

  void _handleModelChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return AnalogClock(_model);
  }
}
