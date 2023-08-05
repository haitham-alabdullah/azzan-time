// ignore_for_file: hash_and_equals

import 'dart:convert';

import 'package:azzan/src/providers/main.provider.dart';
import 'package:get/get.dart';

class Country {
  final String id;
  final String title;
  final List<City> cities;

  Country(this.id, this.title, this.cities);

  @override
  bool operator ==(Object other) {
    return (other is Country) && other.id == id;
  }

  @override
  String toString() {
    return jsonEncode({
      'id': id,
      'title': title,
    });
  }

  factory Country.fromStore(String lang) {
    final values = jsonDecode(lang);
    return Country(
        values['id'],
        values['title'],
        Get.find<MainProvider>()
                .allCountries
                .firstWhereOrNull((element) => element.id == values['id'])
                ?.cities ??
            []);
  }
}

class City {
  final String title;

  City(this.title);

  @override
  bool operator ==(Object other) {
    return (other is City) && other.title == title;
  }

  @override
  String toString() {
    return title;
  }

  factory City.fromStore(String lang) {
    return City(lang);
  }
}
