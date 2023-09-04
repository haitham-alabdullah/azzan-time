import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/language.model.dart';
import '../../models/method.model.dart';
import '../../providers/main.provider.dart';
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
