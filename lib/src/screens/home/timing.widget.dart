import 'package:azzan/src/providers/time.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/loading.widget.dart';
import 'time.widget.dart';

class TimingWidget extends StatefulWidget {
  const TimingWidget({super.key});

  @override
  State<TimingWidget> createState() => _TimingWidgetState();
}

class _TimingWidgetState extends State<TimingWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimeProvider>(builder: (provider) {
      if (provider.times.isEmpty) return const Loading();
      return Column(
        children: provider.times.map((e) {
          if (provider.current > e.id) {
            return TimePassedWidget(e);
          } else if (e.id > provider.current) {
            return TimeNextWidget(e);
          }
          return TimeCurrentWidget(e);
        }).toList(),
      );
    });
  }
}
