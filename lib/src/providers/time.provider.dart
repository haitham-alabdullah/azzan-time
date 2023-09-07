import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/services.class.dart';
import '../models/praytime.model.dart';
import 'main.provider.dart';

class TimeProvider extends GetxController {
  final RxBool _isLoading = RxBool(false);
  final RxInt _current = RxInt(0);
  final Rx<List<PrayTime>> _times = Rx<List<PrayTime>>([]);
  final Rx<String?> _timeZone = Rx<String?>(null);

  bool get isLoading => _isLoading.value;
  int get current => _current.value;
  List<PrayTime> get times => _times.value;
  String? get timeZone => _timeZone.value;

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

  Future<void> load() async {
    setLoading = true;
    final main = Get.find<MainProvider>();
    final latitude = main.location.latitude;
    final longitude = main.location.longitude;
    final method = main.method.id;
    if (latitude == 0.0 || longitude == 0.0) {
      setLoading = false;
      return;
    }
    final data =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    final params = '?latitude=$latitude&longitude=$longitude&method=$method';
    final url = 'http://api.aladhan.com/v1/timings/$data$params';

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
        if (value.toString().contains(' ')) {
          value = value.toString().split(' ')[0];
        }
        if (keys.contains(key)) {
          times.add(
            PrayTime(
              keys.indexOf(key),
              key,
              value,
            ),
          );
        }
      });
      setTimeZone(value['meta']['timezone']);
      updateTimes(times);
    }).catchError((e) {
      setLoading = false;
    });
    setLoading = false;
  }

  updateTimes(List<PrayTime> times) {
    _times.value = times;
    update();
    storeTimes(times);
  }

  setTimeZone(String? timeZone) {
    if (timeZone == _timeZone.value) return;
    _timeZone.value = timeZone;
    update();
  }

  Future<void> storeTimes(List<PrayTime> times) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> timesToStore = [];
    for (var time in times) {
      timesToStore.add(time.storeString());
    }
    await prefs.setStringList('times', timesToStore);
  }

  Future<void> readTimes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? timesToRead = prefs.getStringList('times');
    if (timesToRead is List<String>) {
      final List<PrayTime> times = [];
      for (var time in timesToRead) {
        times.add(PrayTime.fromString(time));
      }
      _times.value = times;
      update();
    }
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
