import 'package:azzan/src/models/language.model.dart';
import 'package:azzan/src/providers/main.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/country.model.dart';
import '../../models/method.model.dart';
import 'select_menu.widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
              children: [
                const SizedBox(height: 10),
                // ElevatedButton(
                //     onPressed: () {
                //       print(Get.locale);
                //       // if (Get.locale == const Locale('en')) {
                //       //   Get.find<MainProvider>().toggleLang(const Locale('ar'));
                //       // } else {
                //       //   Get.find<MainProvider>().toggleLang(const Locale('en'));
                //       // }
                //     },
                //     child: const Text('data')),
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

                const SizedBox(height: 10),
                const SizedBox(height: 60),
              ],
            );
          }),
        ),
      ),
    );
  }
}
