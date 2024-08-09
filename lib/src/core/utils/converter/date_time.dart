import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampOrNullToDateTimeOrNullConverter implements JsonConverter<DateTime?, int?> {
  const TimestampOrNullToDateTimeOrNullConverter();

  @override
  DateTime? fromJson(int? json) {
    try {
      if (json == null || json <= 0) return null;
      return DateTime.fromMillisecondsSinceEpoch(json * 1000);
    } catch (e) {
      return null;
    }
  }

  @override
  int? toJson(DateTime? data) => data != null ? data.millisecondsSinceEpoch ~/ 1000 : null;
}

class GMTOrNullToDateTimeOrNullConverter implements JsonConverter<DateTime?, String?> {
  const GMTOrNullToDateTimeOrNullConverter();

  @override
  DateTime? fromJson(String? json) {
    if (json == null) return null;

    DateFormat gmtFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss", "en_US");
    DateTime gmtDateTime = gmtFormat.parse(json);

    // Convert GMT DateTime to ICT DateTime
    DateTime ictDateTime = gmtDateTime.toLocal().add(
          Duration(seconds: gmtDateTime.timeZoneOffset.inSeconds),
        );
    return ictDateTime;
  }

  @override
  String? toJson(DateTime? data) {
    if (data == null) return null;
    String gmtHour = DateFormat("EEE, dd MMM yyyy HH:mm:ss GMT", "en_US").format(data);
    return gmtHour;
  }
}
