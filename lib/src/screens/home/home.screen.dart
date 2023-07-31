import 'dart:async';

import 'package:azzan/src/providers/time.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'date.widget.dart';
import 'remining_time.widget.dart';
import 'timing.widget.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Timer timer;
  late final Timer timer2;

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => Get.find<TimeProvider>().updateCurrentTime(),
    );

    timer2 = Timer.periodic(
      const Duration(minutes: 10),
      (Timer t) => Get.find<TimeProvider>().load(),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        child: Column(
          children: [
            DateWidget(),
            SizedBox(height: 10),
            TimingWidget(),
            Spacer(),
            ReminingTimeWidget(),
          ],
        ),
      ),
    );
  }
}
