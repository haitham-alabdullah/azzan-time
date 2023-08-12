import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/services.class.dart';
import '../data/countries.dart' as local_data;
import '../models/country.model.dart';
import '../models/language.model.dart';
import '../models/method.model.dart';

extension StringExtension on String {
  String removeList(List<String> wordsToRemove) {
    String result = this;

    for (String word in wordsToRemove) {
      result = result.replaceAll(word, '');
    }

    return result;
  }
}

class MainProvider extends GetxController {
  final RxBool _isLoading = RxBool(false);
  final RxBool _isSettings = RxBool(false);
  final RxBool _isFirstTime = RxBool(false);

  final Rx<Language> _locale = Rx<Language>(
    Language('العربية', const Locale('ar')),
  );
  final Rx<Method> _method = Rx<Method>(
    Method('4', 'Umm Al-Qura University, Makkah'),
  );
  final Rx<Country> _country = Rx<Country>(Country(
    'SA',
    'Saudi Arabia',
  ));
  final Rx<List<City>> _cities = Rx<List<City>>([
    City('Makka'),
  ]);

  final Rx<City> _city = Rx<City>(City('Makka'));

  bool get isLoading => _isLoading.value;
  bool get isSettings => _isSettings.value;
  bool get isFirstTime => _isFirstTime.value;
  Locale get locale => _locale.value.locale;
  Language get lang => _locale.value;
  Method get method => _method.value;
  City get city => _city.value;
  Country get country => _country.value;

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

  List<Country> allCountries = local_data.countries;
  List<City> get allCities => _cities.value;

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

  void toggleCountry(Country country) async {
    _isLoading.value = true;
    _country.value = country;
    update();
    final params = 'iso2=${_country.value.id}';
    final cities = await Services.getData(
      'https://countriesnow.space/api/v0.1/countries/states/q?$params',
    ).then<List<City>>((value) {
      final List<City> list = [];
      if (value != null) {
        final c = value['states'];
        final extraWords = [
          'Region',
          'Emirate',
          'Governorate',
          'Municipality',
          'District',
          'Province',
          'Border',
          'Borders',
        ];

        for (var city in c) {
          list.add(City(city['name']
              .toString()
              .removeList(extraWords)
              .replaceAll('Al ', 'Al-')
              .trim()));
        }
        return list;
      }
      return [];
    });
    _cities.value = cities;
    _city.value = cities.first;
    _isLoading.value = false;
    update();
    storeCity(cities.first);
    storeCountry(country);
  }

  void toggleCity(City city) {
    _city.value = city;
    update();
    storeCity(city);
  }

  storeLanguage(locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs
        .setString('language', locale.toString())
        .then((value) => print('language stored: $value'));
  }

  storeMethod(method) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs
        .setString('method', method.toString())
        .then((value) => print('method stored: $value'));
  }

  storeCountry(country) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs
        .setString('country', country.toString())
        .then((value) => print('country stored: $value'));
  }

  storeCity(city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs
        .setString('city', city.toString())
        .then((value) => print('city stored: $value'));
  }

  Future<void> getFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstTime.value = prefs.getBool('FirstTime') ?? true;
    if (_isFirstTime.value) {
      prefs.setBool('FirstTime', false);
      _isFirstTime.value = false;
      _isSettings.value = true;
    }
    update();
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

  Future<void> getCountry() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _country.value = Country.fromStore(
        prefs.getString('country') ?? Country('SA', 'Saudi Arabia').toString());
    _isLoading.value = true;
    _country.value = country;
    update();
    final params = 'iso2=${_country.value.id}';
    _cities.value = await Services.getData(
      'https://countriesnow.space/api/v0.1/countries/states/q?$params',
    ).then<List<City>>((value) {
      final List<City> list = [];
      if (value != null) {
        final c = value['states'];
        final extraWords = [
          'Region',
          'Emirate',
          'Governorate',
          'Municipality',
          'District',
          'Province',
          'Border',
          'Borders',
        ];

        for (var city in c) {
          list.add(City(city['name']
              .toString()
              .removeList(extraWords)
              .replaceAll('Al ', 'Al-')
              .trim()));
        }
        return list;
      }
      return [];
    });
    _isLoading.value = false;
    update();
  }

  Future<void> getCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _city.value =
        City.fromStore(prefs.getString('city') ?? City('Makka').toString());
  }

  @override
  void onInit() async {
    await load();
    super.onInit();
  }

  Future<void> load() async {
    await getLanguage();
    await getMethod();
    await getCountry();
    await getCity();
    update();
  }
}
