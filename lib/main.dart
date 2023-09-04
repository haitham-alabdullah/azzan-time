import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'src/classes/services.class.dart';
import 'src/classes/themes.class.dart';
import 'src/classes/translations.class.dart';
import 'src/core/__main__.dart';
import 'src/providers/main.provider.dart';
import 'src/providers/time.provider.dart';

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

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Get.find<MainProvider>().getLocation().then((value) async {
        if (value != null) Get.find<TimeProvider>().load();
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        FlutterNativeSplash.remove();
        Get.find<MainProvider>().getLocation().then((value) {
          if (value != null) Get.find<TimeProvider>().load();
        });
      },
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
