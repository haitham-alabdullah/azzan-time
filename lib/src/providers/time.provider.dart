import 'package:get/get.dart';

import '../classes/services.class.dart';
import '../models/method.model.dart';
import '../models/praytime.model.dart';

class TimeProvider extends GetxController {
  final RxInt _current = RxInt(0);
  final Rx<List<PrayTime>> _times = Rx<List<PrayTime>>([]);
  final Rx<Method> _method = Rx<Method>(
    Method('4', 'Umm Al-Qura University, Makkah', ''),
  );
  final RxString _country = RxString('SA');
  final RxString _city = RxString('Makkah');

  int get current => _current.value;
  List<PrayTime> get times => _times.value;
  PrayTime get currentTime => _times.value[current];

  Method get method => _method.value;
  String get city => _city.value;
  String get country => _country.value;

  List<Method> get allMethods => [
        Method('1', 'University of Islamic Sciences, Karachi', ''),
        Method('2', 'Islamic Society of North America', ''),
        Method('3', 'Muslim World League', ''),
        Method('4', 'Umm Al-Qura University, Makkah', ''),
        Method('5', 'Egyptian General Authority of Survey', ''),
        Method('7', 'Institute of Geophysics, University of Tehran', ''),
        Method('8', 'Gulf Region', ''),
        Method('9', 'Kuwait', ''),
        Method('10', 'Qatar', ''),
        Method('11', 'Majlis Ugama Islam Singapura, Singapore', ''),
        Method('12', 'nion Organization islamic de France', ''),
        Method('13', 'Diyanet İşleri Başkanlığı, Turkey', ''),
        Method('14', 'Spiritual Administration of Muslims of Russia', ''),
        Method(
            '15',
            'Moonsighting Committee Worldwide (also requires shafaq parameter)',
            ''),
      ];
  List<String> get allCountries => ['SA', 'AE'];
  List<String> get allCities => ['Makkah', 'Dubai'];

  set setTimes(value) => _times.value = value;
  set setMethod(value) => _method.value = value;

  @override
  void onInit() {
    load();
    super.onInit();
  }

  load() async {
    await Services.getData('?country=$country&city=$city').then((value) {
      if (value == null) return;
      final timing = value['timings'] as Map<String, dynamic>;
      final List<PrayTime> times = [];
      final List<String> keys = [
        'Fajr',
        'Dhuhr',
        'Asr',
        'Maghrib',
        'Isha',
      ];
      timing.forEach((key, value) {
        if (keys.contains(key)) {
          times.add(PrayTime(keys.indexOf(key), key, value));
        }
      });
      updateTimes(times);
    });
  }

  updateTimes(List<PrayTime> times) {
    _times.value = times;
    update();
  }

  PrayTime? setCurrentTime() {
    final now = DateTime.now();
    for (var time in _times.value) {
      if (now.isBefore(time.getDateTime())) {
        return time;
      }
    }
    return null;
  }

  updateCurrentTime() {
    _current.value = setCurrentTime()?.id ?? 0;
    update();
  }

  Duration getRemining() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, currentTime.hours(),
            currentTime.minutes())
        .difference(now);
  }

  lessThenTen() {
    final remining = getRemining();
    return remining.inMinutes < 10;
  }

  remining() {
    final remining = getRemining();
    final hrs = remining.inHours;

    final min = remining.inMinutes > 59
        ? (remining.inMinutes % 60)
        : remining.inMinutes;

    if (hrs == 0 && min < 2) {
      return '${'Minute'.tr} ';
    }

    if (hrs == 0) {
      return '$min ${min > 10 ? 'min'.tr : 'min2'.tr}';
    }

    if (hrs > 0 && min == 0) {
      return '$hrs ${'Hour'.tr}';
    }
    return '$hrs ${'Hour'.tr} ${'and'.tr} $min ${min > 10 ? 'min'.tr : 'min2'.tr}';
  }
}
