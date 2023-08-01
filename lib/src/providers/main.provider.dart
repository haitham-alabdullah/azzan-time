import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/country.model.dart';
import '../models/language.model.dart';
import '../models/method.model.dart';

class MainProvider extends GetxController {
  final RxBool _isSettings = RxBool(false);
  final Rx<Language> _locale = Rx<Language>(
    Language('العربية', const Locale('ar')),
  );
  final Rx<Method> _method = Rx<Method>(
    Method('4', 'Umm Al-Qura University, Makkah'),
  );
  final Rx<Country> _country = Rx<Country>(Country(
    'SA',
    'Saudi Arabia',
    [
      City('Makka'),
      City('Riyadh'),
      City('Jeddah'),
      City('Medina'),
      City('Dammam'),
      City('Khobar'),
      City('Taif'),
    ],
  ));

  final Rx<City> _city = Rx<City>(City('Makka'));

  bool get isSettings => _isSettings.value;
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
        Method('1', 'University of Islamic Sciences, Karachi'),
        Method('2', 'Islamic Society of North America'),
        Method('3', 'Muslim World League'),
        Method('4', 'Umm Al-Qura University, Makkah'),
        Method('5', 'Egyptian General Authority of Survey'),
        Method('7', 'Institute of Geophysics, University of Tehran'),
        Method('8', 'Gulf Region'),
        Method('9', 'Kuwait'),
        Method('10', 'Qatar'),
        Method('11', 'Majlis Ugama Islam Singapura, Singapore'),
        Method('12', 'nion Organization islamic de France'),
        Method('13', 'Diyanet İşleri Başkanlığı, Turkey'),
        Method('14', 'Spiritual Administration of Muslims of Russia'),
      ];

  List<Country> allCountries = [
    Country(
      'BH',
      'Bahrain',
      [
        City('Manama'),
        City('Muharraq'),
        City('Riffa'),
        City('Isa Town'),
        City('Jidhafs'),
      ],
    ),
    Country(
      'KW',
      'Kuwait',
      [
        City('Kuwait'),
        City('Al Ahmadi'),
        City('Hawalli'),
        City('Farwaniya'),
        City('Mubarak Al-Kabeer'),
      ],
    ),
    Country(
      'QA',
      'Qatar',
      [
        City('Doha'),
        City('Al Wakrah'),
        City('Al Rayyan'),
        City('Umm Salal'),
        City('Al Khor'),
      ],
    ),
    Country(
      'OM',
      'Oman',
      [
        City('Muscat'),
        City('Salalah'),
        City('Sohar'),
        City('Nizwa'),
        City('Sur'),
      ],
    ),
    Country(
      'AE',
      'United Arab Emirates',
      [
        City('Abu Dhabi'),
        City('Dubai'),
        City('Sharjah'),
        City('Ajman'),
        City('Fujairah'),
        City('Ras Al Khaimah'),
      ],
    ),
    Country(
      'SA',
      'Saudi Arabia',
      [
        City('Riyadh'),
        City('Jeddah'),
        City('Makka'),
        City('Medina'),
        City('Dammam'),
        City('Khobar'),
        City('Taif'),
      ],
    ),
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

  void toggleCountry(Country country) {
    _city.value = country.cities.first;
    _country.value = country;
    update();
    storeCity(country.cities.first);
    storeCountry(country);
  }

  void toggleCity(City city) {
    _city.value = city;
    update();
    storeCity(city);
  }

  storeLanguage(locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', locale.toString());
  }

  storeMethod(method) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('method', method.toString());
  }

  storeCountry(country) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('country', country.toString());
  }

  storeCity(city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', city.toString());
  }

  void getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _locale.value =
        Language.fromStore(prefs.getString('language') ?? 'العربية-ar');
    Get.updateLocale(_locale.value.locale);
    update();
  }

  void getMethod() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _method.value = Method.fromStore(
        prefs.getString('method') ?? '4--Umm Al-Qura University, Makkah');
    update();
  }

  void getCountry() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _country.value = Country.fromStore(prefs.getString('country') ??
        Country(
          'SA',
          'Saudi Arabia',
          [
            City('Makka'),
            City('Riyadh'),
            City('Jeddah'),
            City('Medina'),
            City('Dammam'),
            City('Khobar'),
            City('Taif'),
          ],
        ).toString());
    update();
  }

  void getCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _city.value =
        City.fromStore(prefs.getString('city') ?? City('Makka').toString());
    update();
  }

  @override
  void onInit() {
    getLanguage();
    getMethod();
    getCountry();
    getCity();
    super.onInit();
  }
}
