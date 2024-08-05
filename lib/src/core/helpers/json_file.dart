import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class JsonFileHelpers {
  const JsonFileHelpers._();

  static Future<String> getJsonString(String address) async {
    return await rootBundle.loadString(address);
  }

  /// * read file json from assets
  static Future readAssetsJsonFile(String address) async {
    final String jsonString = await rootBundle.loadString(address);
    final data = await json.decode(jsonString);
    return data;
  }

  /// * read file json without declare path assets in pubspec.yaml
  /// * use for unit test
  /// * use only mobile
  static Future readOutSidesJsonFile(String address) async {
    final String jsonString = File(address).readAsStringSync();
    final data = await json.decode(jsonString);
    return data;
  }
}
