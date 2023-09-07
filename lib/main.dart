import 'package:azzantime/src/widgets/loading.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'src/classes/services.class.dart';
import 'src/classes/themes.class.dart';
import 'src/classes/translations.class.dart';
import 'src/core/__main__.dart';
import 'src/providers/main.provider.dart';
import 'src/providers/time.provider.dart';
import 'src/widgets/wrapper.widget.dart';

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
  final main = Get.find<MainProvider>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (main.hasLocation) {
        main.getLocation().then((value) {
          if (value != null) Get.find<TimeProvider>().load();
        });
      }
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Azzan-Timing',
      theme: Themes.themeData,
      locale: main.locale,
      fallbackLocale: const Locale('en'),
      home: FutureBuilder(
          future: main.getLocation(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return GetBuilder<TimeProvider>(builder: (provider) {
                return provider.times.isNotEmpty
                    ? const MainScreen()
                    : const WrapperWidget(Center(child: Loading()));
              });
            } else if (snap.hasData) {
              return const MainScreen();
            }
            return WrapperWidget(
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'accessMessage'.tr,
                        textAlign: TextAlign.center,
                        style: Themes.textStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          final main = Get.find<MainProvider>();
                          if (await main.getLocationPermission()) {
                            await main.getLocation();
                          } else {
                            if (await Geolocator.isLocationServiceEnabled()) {
                              await Geolocator.openAppSettings();
                            } else {
                              await Geolocator.openLocationSettings();
                            }
                          }
                          if (main.hasLocation) {
                            Get.find<TimeProvider>()
                                .load()
                                .then((value) => setState(() {}));
                          }
                        },
                        child: Text(
                          'Request Location Access'.tr,
                          textAlign: TextAlign.center,
                          style: Themes.textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      translations: AzzanTranslations(),
    );
  }
}
