import 'package:azzan/src/classes/themes.class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/classes/services.class.dart';
import 'src/classes/translations.class.dart';
import 'src/core/__main__.dart';

void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  await Services.registerProviders();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Azzan-Timing',
      theme: Themes.themeData,
      locale: const Locale('ar', 'SA'),
      fallbackLocale: const Locale('en', 'US'),
      home: const MainScreen(),
      translations: AzzanTranslations(),
    );
  }
}
