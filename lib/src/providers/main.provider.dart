import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
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

  final Rx<LocationData?> _location = Rx<LocationData?>(null);

  bool get isLoading => _isLoading.value;
  bool get isSettings => _isSettings.value;
  Locale get locale => _locale.value.locale;
  Language get lang => _locale.value;
  Method get method => _method.value;
  LocationData? get location => _location.value;

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

  void toggleLocation(LocationData location) {
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

  storeLocation(LocationData location) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'location', "${location.latitude}|${location.longitude}");
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
      _location.value = LocationData.fromMap({
        "latitude": double.tryParse(location.split('|')[0]),
        "longitude": double.tryParse(location.split('|')[1]),
      });
    }
  }

  Future<LocationData?> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    final locationData = await location.getLocation();
    Get.find<MainProvider>().toggleLocation(locationData);

    return locationData;
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
