import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../classes/themes.class.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Themes.primary.withOpacity(.3),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(200, 255, 255, 255),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            'Important Note'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Tajawal',
              color: Themes.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'pray_note'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Tajawal',
              color: Themes.textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
