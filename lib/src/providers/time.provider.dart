import 'package:azzan/src/providers/main.provider.dart';
import 'package:get/get.dart';

import '../classes/services.class.dart';
import '../models/praytime.model.dart';

class TimeProvider extends GetxController {
  final RxBool _isLoading = RxBool(false);
  final RxInt _current = RxInt(0);
  final Rx<List<PrayTime>> _times = Rx<List<PrayTime>>([]);

  bool get isLoading => _isLoading.value;
  int get current => _current.value;
  List<PrayTime> get times => _times.value;
  PrayTime? currentTime() {
    if (_times.value.isEmpty) return null;
    PrayTime currentTime = _times.value[current];
    return currentTime;
  }

  set setTimes(value) => _times.value = value;
  set setLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  @override
  void onInit() {
    load();
    super.onInit();
  }

  load() async {
    setLoading = true;
    final main = Get.find<MainProvider>();
    final url =
        'http://api.aladhan.com/v1/timingsByCity?country=${main.country.id}&city=${main.city.title.replaceAll(' ', '')}&method=${main.method.id}';
    await Services.getData(url).then((value) {
      if (value == null) return;
      final timing = value['timings'] as Map<String, dynamic>;
      final List<PrayTime> times = [];
      final List<String> keys = [
        'Fajr',
        'Sunrise',
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
    }).catchError((e) {
      setLoading = false;
      throw e;
    });
    setLoading = false;
  }

  updateTimes(List<PrayTime> times) {
    _times.value = times;
    update();
  }

  PrayTime? setCurrentTime() {
    final now = DateTime.now();
    for (var time in _times.value) {
      if (now.isBefore(time.getDateTime(now))) {
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
    final timing = currentTime();
    if (timing == null) return Duration.zero;
    if (_current.value == 0 && now.hour > 6) {
      return DateTime(now.year, now.month, now.day + 1, timing.hours(),
              timing.minutes())
          .difference(now);
    }
    return DateTime(
            now.year, now.month, now.day, timing.hours(), timing.minutes())
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
