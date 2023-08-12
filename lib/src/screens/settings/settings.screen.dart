import 'package:azzan/src/models/language.model.dart';
import 'package:azzan/src/providers/main.provider.dart';
import 'package:azzan/src/widgets/loading.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/country.model.dart';
import '../../models/method.model.dart';
import '../home/note.widget.dart';
import 'dev_card.widget.dart';
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
        child: GetBuilder<MainProvider>(builder: (provider) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
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
                  withSrearch: true,
                  title: 'Country',
                  def: provider.country,
                  list: provider.allCountries,
                  onChange: provider.toggleCountry,
                ),
                const SizedBox(height: 10),
                provider.isLoading
                    ? const Center(child: Loading())
                    : SelectMenu<City>(
                        key: ValueKey(provider.country),
                        withSrearch: true,
                        title: 'City',
                        def: provider.city,
                        list: provider.allCities,
                        onChange: provider.toggleCity,
                      ),
                const SizedBox(height: 30),
                const NoteWidget(),
                const SizedBox(height: 40),
                const DevCard(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
