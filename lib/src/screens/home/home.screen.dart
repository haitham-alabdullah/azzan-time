import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/time.provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<TimeProvider>().load();
    });
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) Get.find<TimeProvider>().updateCurrentTime();
    });

    timer2 = Timer.periodic(
      const Duration(hours: 1),
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
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    DateWidget(),
                    SizedBox(height: 10),
                    TimingWidget(),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(child: ReminingTimeWidget()),
            )
          ],
        ),
      ),
    );
  }
}
