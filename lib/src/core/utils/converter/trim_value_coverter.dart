import 'package:json_annotation/json_annotation.dart';

class TrimValueConverter implements JsonConverter<String?, String?> {
  const TrimValueConverter();

  @override
  String? fromJson(String? json) {
    return json?.trim();
  }

  @override
  String? toJson(String? object) {
    return object?.trim();
  }
}
