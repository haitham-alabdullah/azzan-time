import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/language.model.dart';
import '../models/method.model.dart';

class MainProvider extends GetxController {
  final RxBool _isLoading = RxBool(false);
  final RxBool _isSettings = RxBool(false);

  final Rx<Language> _locale = Rx<Language>(
    Language('العربية', const Locale('ar')),
  );
  final Rx<Method> _method = Rx<Method>(
    Method('4', 'Umm Al-Qura University, Makkah'),
  );

  final Rx<Position> _location = Rx<Position>(Position.fromMap({
    "latitude": 0.0,
    "longitude": 0.0,
  }));

  bool get isLoading => _isLoading.value;
  bool get isSettings => _isSettings.value;
  Locale get locale => _locale.value.locale;
  Language get lang => _locale.value;
  Method get method => _method.value;
  Position get location => _location.value;
  bool get hasLocation =>
      _location.value.altitude != 0.0 || _location.value.longitude != 0.0;

  List<Language> get languages => [
        Language('العربية', const Locale('ar')),
        Language('English', const Locale('en'))
      ];
  List<Method> get allMethods => [
        Method('4', 'Umm Al-Qura University, Makkah'),
        Method('8', 'Gulf Region'),
        Method('3', 'Muslim World League'),
        Method('10', 'Qatar'),
        Method('9', 'Kuwait'),
        Method('5', 'Egyptian General Authority of Survey'),
        Method('1', 'University of Islamic Sciences, Karachi'),
        Method('2', 'Islamic Society of North America'),
        Method('7', 'Institute of Geophysics, University of Tehran'),
        Method('11', 'Majlis Ugama Islam Singapura, Singapore'),
        Method('12', 'Union Organization islamic de France'),
        Method('13', 'Diyanet İşleri Başkanlığı, Turkey'),
        Method('14', 'Spiritual Administration of Muslims of Russia'),
      ];

  toggleSettings() {
    _isSettings.value = !_isSettings.value;
    update();
  }

  void toggleLang(Language locale) {
    Get.updateLocale(locale.locale);
    _locale.value = locale;
    update();
    storeLanguage(locale);
  }

  void toggleMethod(Method method) {
    _method.value = method;
    update();
    storeMethod(method);
  }

  void toggleLocation(Position location) {
    _location.value = location;
    update();
    storeLocation(location);
  }

  storeLanguage(Language locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', locale.toString());
  }

  storeMethod(Method method) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('method', method.toString());
  }

  storeLocation(Position location) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'location', "${location.altitude}|${location.longitude}");
  }

  Future<void> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _locale.value =
        Language.fromStore(prefs.getString('language') ?? 'العربية-ar');
    Get.updateLocale(_locale.value.locale);
  }

  Future<void> getMethod() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _method.value = Method.fromStore(
        prefs.getString('method') ?? '4--Umm Al-Qura University, Makkah');
  }

  Future<void> getLocalLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final location = prefs.getString('location');
    if (location is String) {
      _location.value = Position.fromMap({
        "latitude": double.tryParse(location.split('|')[0]),
        "longitude": double.tryParse(location.split('|')[1]),
      });
    }
  }

  Future<bool> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }

    return true;
  }

  Future<Position?> getLocation() async {
    if (await getLocationPermission()) {
      final locationData = await Geolocator.getCurrentPosition();
      Get.find<MainProvider>().toggleLocation(locationData);
      return locationData;
    }
    return null;
  }

  @override
  void onInit() async {
    await load();
    super.onInit();
  }

  Future<void> load() async {
    await getLanguage();
    await getMethod();
    getLocalLocation();
    update();
  }
}
