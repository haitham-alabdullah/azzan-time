import 'package:get/get.dart';

import '../providers/main.provider.dart';
import '../providers/time.provider.dart';

class Services {
  static registerProviders() async {
    Get.lazyPut(() => MainProvider());
    final timeProvider = Get.put(TimeProvider());
    await timeProvider.load();
  }

  static toArNumber(String string) {
    Map<String, String> englishToArabicMap = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    // Create a StringBuffer to store the result
    StringBuffer result = StringBuffer();

    // Iterate through the input characters and replace English numbers with Arabic numbers
    for (int i = 0; i < string.length; i++) {
      String currentChar = string[i];
      String replacement = englishToArabicMap[currentChar] ?? currentChar;
      result.write(replacement);
    }
    return result.toString();
  }
}
