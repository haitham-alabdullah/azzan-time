import 'package:get/get.dart';

class TimeProvider extends GetxController {
  final RxInt _currentSalah = RxInt(0);
  final Rx<List<DateTime>> _times = Rx<List<DateTime>>([]);

  int get current => _currentSalah.value;
  List<DateTime> get times => _times.value;

  @override
  void onInit() {
    load();
    super.onInit();
  }

  load() async {}
}
