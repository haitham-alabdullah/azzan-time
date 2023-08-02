import 'package:azzan/src/models/language.model.dart';
import 'package:azzan/src/providers/main.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../classes/themes.class.dart';
import '../../models/country.model.dart';
import '../../models/method.model.dart';
import 'select_menu.widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          child: GetBuilder<MainProvider>(builder: (provider) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 70),
                SelectMenu<Language>(
                  title: 'Language',
                  def: provider.lang,
                  list: provider.languages,
                  onChange: provider.toggleLang,
                ),
                const SizedBox(height: 10),
                SelectMenu<Method>(
                  title: 'Method',
                  def: provider.method,
                  list: provider.allMethods,
                  onChange: provider.toggleMethod,
                ),
                const SizedBox(height: 10),
                SelectMenu<Country>(
                  title: 'Country',
                  def: provider.country,
                  list: provider.allCountries,
                  onChange: provider.toggleCountry,
                ),
                const SizedBox(height: 10),
                SelectMenu<City>(
                  key: ValueKey(provider.country),
                  title: 'City',
                  def: provider.city,
                  list: provider.country.cities,
                  onChange: provider.toggleCity,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () => _launchUrl('DevAbdullah7'),
                        child: Text(
                          '${'X'.tr}: DevAbdullah7',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Tajawal',
                            color: Themes.textColor,
                            fontWeight: FontWeight.w500,
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () => _launchUrl('HaithamDev_'),
                        child: Text(
                          '${'X'.tr}: HaithamDev_',
                          textAlign: TextAlign.start,
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
                const SizedBox(height: 70),
              ],
            );
          }),
        ),
      ),
    );
  }
}
