import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../providers/main.provider.dart';
import '../providers/time.provider.dart';

class Services {
  static Future<dynamic> getData(String url) async {
    // final status = await isNotConnected();
    // if (status) return;
    final dio = Dio();
    return await dio
        .get(
          url,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        )
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw 'CONNECTION_TIMED_OUT'.tr,
        )
        .then((response) {
      return filterResponse(response.data);
    }).catchError((error) {
      if (error is SocketException) {
        throw 'NO_INTERNET'.tr;
      }
      throw error;
    });
  }

  static Future<dynamic> postData(String url, dynamic body) async {
    // final status = await isNotConnected();
    // if (status) return;
    final dio = Dio();
    return await dio
        .post(
          url,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
          data: jsonEncode(body),
        )
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw 'CONNECTION_TIMED_OUT'.tr,
        )
        .then((response) {
      return filterResponse(response.data);
    }).catchError((error) {
      if (error is SocketException) {
        throw 'NO_INTERNET'.tr;
      }
      throw error;
    });
  }

  static filterResponse(body) {
    try {
      // final res = jsonDecode(body);
      if (body != null) {
        return body['data'];
      } else {
        // if (res['message'] == 'INVALID_TOKEN') {
        //   Get.find<AuthProvider>().logout();
        // } else {
        // }
        throw body['data'];
      }
    } catch (e) {
      if (e is FormatException) {
        throw 'UNKNOWN_ERROR';
      }
      rethrow;
    }
  }

  static registerProviders() async {
    final main = Get.put(MainProvider());
    main.getLocationPermission();
    Get.put(TimeProvider());
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

  String removeWords(String input, List<String> wordsToRemove) {
    String result = input;

    for (String word in wordsToRemove) {
      result = result.replaceAll(word, '');
    }

    return result;
  }
}
