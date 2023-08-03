import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../classes/themes.class.dart';
import '../../providers/time.provider.dart';

class ReminingTimeWidget extends StatefulWidget {
  const ReminingTimeWidget({super.key});

  @override
  State<ReminingTimeWidget> createState() => _ReminingTimeWidgetState();
}

class _ReminingTimeWidgetState extends State<ReminingTimeWidget>
    with SingleTickerProviderStateMixin {
  late final Timer timer;
  late final AnimationController controller;
  final provider = Get.find<TimeProvider>();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) {
        final fade = provider.lessThenTen();
        if (fade && !controller.isAnimating) {
          controller.repeat(
            reverse: true,
            period: const Duration(milliseconds: 500),
          );
        } else if (!fade && controller.isAnimating) {
          controller.reset();
        }
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimeProvider>(builder: (provider) {
      final timing = provider.currentTime();
      if (timing == null) return const SizedBox();
      final remining = provider.remining();
      return FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(controller),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Themes.selected,
            boxShadow: [
              Themes.cardShadow(),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Remining for '.tr + timing.title.tr,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Tajawal',
                  color: Themes.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 3),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: Text(
                  remining.toString(),
                  key: ValueKey(remining.toString()),
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Tajawal',
                    color: Themes.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
