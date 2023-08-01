import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../providers/main.provider.dart';
import '../providers/time.provider.dart';

class Services {
  static const String name = 'Fanajeen';
  static const String version = '1.0.0';
  static const String apiKey = '';
  static const String baseUrl = 'https://.ae/';
  static const String baseAppUrl = 'http://api.aladhan.com/v1/timingsByCity';

  static Future<dynamic> getData(String url,
      {bool isApiKey = false, bool global = false}) async {
    // final status = await isNotConnected();
    // if (status) return;
    final uri = Uri.parse((global ? baseUrl : baseAppUrl) + url);
    return await http
        .get(uri, headers: _headers(isApiKey: isApiKey))
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw 'CONNECTION_TIMED_OUT'.tr,
        )
        .then((response) {
      return filterResponse(response.body);
    }).catchError((error) {
      if (error is SocketException) {
        throw 'NO_INTERNET'.tr;
      }
      throw error;
    });
  }

  static Future<dynamic> postData(String url, dynamic body,
      {bool isApiKey = false}) async {
    // final status = await isNotConnected();
    // if (status) return;
    final uri = Uri.parse(baseAppUrl + url);
    return await http
        .post(uri,
            headers: _headers(isApiKey: isApiKey), body: jsonEncode(body))
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw 'CONNECTION_TIMED_OUT'.tr,
        )
        .then((response) {
      return filterResponse(response.body);
    }).catchError((error) {
      if (error is SocketException) {
        throw 'NO_INTERNET'.tr;
      }
      throw error;
    });
  }

  static filterResponse(String body) {
    try {
      final res = jsonDecode(body);
      if (res != null && res['code'] == 200) {
        return res['data'];
      } else {
        // if (res['message'] == 'INVALID_TOKEN') {
        //   Get.find<AuthProvider>().logout();
        // } else {
        // }
        throw res['data'];
      }
    } catch (e) {
      if (e is FormatException) {
        throw 'UNKNOWN_ERROR';
      }
      rethrow;
    }
  }

  // static String? _getToken() {
  //   // try {
  //   //   return Get.find<AuthProvider>().token;
  //   // } catch (e) {
  //   // }
  //   return null;
  // }

  static Map<String, String> _headers({bool isApiKey = false}) {
    // final token = _getToken() ?? apiKey;
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer ${isApiKey ? apiKey : token}',
    };
  }

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
