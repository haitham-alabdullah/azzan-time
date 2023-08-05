import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../classes/themes.class.dart';

class DevCard extends StatelessWidget {
  const DevCard({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse('https://twitter.com/$url');
    try {
      await launchUrl(uri);
    } catch (e) {
      //
    }
  }

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Designer: Abdullah Al-Qahtani'.tr,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Tajawal',
              color: Themes.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          InkWell(
            onTap: () => _launchUrl('DevAbdullah7'),
            child: const Text(
              '@DevAbdullah7',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Tajawal',
                color: Themes.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Developer: Haitham Al-Abdullah'.tr,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Tajawal',
              color: Themes.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          InkWell(
            onTap: () => _launchUrl('HaithamDev_'),
            child: const Text(
              '@HaithamDev_',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Tajawal',
                color: Themes.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
