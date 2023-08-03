import 'package:azzan/src/classes/themes.class.dart';
import 'package:azzan/src/providers/main.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'src/classes/services.class.dart';
import 'src/classes/translations.class.dart';
import 'src/core/__main__.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Services.registerProviders();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => FlutterNativeSplash.remove(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Get.find<MainProvider>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Azzan-Timing',
      theme: Themes.themeData,
      locale: provider.locale,
      fallbackLocale: const Locale('en'),
      home: const MainScreen(),
      translations: AzzanTranslations(),
    );
  }
}
