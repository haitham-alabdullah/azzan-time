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

  set setCurrent(value) => _current.value = value;
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
      for (var i = 0; i < timing.length; i++) {
        final time = PrayTime.fromJson(timing[i]);
        times.add(time);
      }
      updateTime(times);
    });
  }

  updateTime(List<PrayTime> times) {
    _times.value = times;
    update();
  }

  setCountry() {}
}
