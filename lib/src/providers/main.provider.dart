import 'package:get/get.dart';

class MainProvider extends GetxController {
  final RxBool _isSettings = RxBool(false);

  get isSettings => _isSettings.value;

  toggleSettings() {
    _isSettings.value = !_isSettings.value;
    update();
  }
}
