import 'package:json_annotation/json_annotation.dart';

part 'response_api.g.dart';

@JsonSerializable(
  explicitToJson: true,
  genericArgumentFactories: true,
  fieldRename: FieldRename.snake,
)
class ResponseApi<DataType> {
  int? errorCode;
  bool? success;
  String message;
  String? msgCode;
  DataType? data;

  ResponseApi({
    this.errorCode,
    this.success,
    this.message = '',
    this.msgCode,
    this.data,
  });

  bool get isSuccess => success ?? false;

  factory ResponseApi.fromJson(
    Map<String, dynamic> json,
    DataType Function(Object? json) fromJsonDataType,
  ) =>
      _$ResponseApiFromJson<DataType>(
        json,
        fromJsonDataType,
      );

  Map<String, dynamic> toJson(
    Object? Function(DataType value) toJsonDataType,
  ) =>
      _$ResponseApiToJson<DataType>(
        this,
        toJsonDataType,
      );
}
