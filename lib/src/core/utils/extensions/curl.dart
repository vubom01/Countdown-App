import 'dart:convert';

import 'package:dio/dio.dart';

extension Curl on RequestOptions {
  String toCurlCmd() {
    String cmd = "curl";

    /// template curl --location 'uri' \
    /// --header 'Content-type: application/json' \
    /// --header 'Authorizi...
    ///
    String header = headers
        .map((key, value) {
          if (key == "content-type" && value.toString().contains("multipart/form-data")) {
            value = "multipart/form-data;";
          }
          return MapEntry(key, "--header '$key: $value'");
        })
        .values
        .join(" \\\n");
    String url = "$baseUrl$path";
    if (queryParameters.isNotEmpty) {
      String query = queryParameters
          .map((key, value) {
            return MapEntry(key, "$key=$value");
          })
          .values
          .join("&");

      url += (url.contains("?")) ? query : "?$query";
    }
    if (method == "GET") {
      cmd += " --location '$url' \\\n$header ";
    } else {
      Map<String, dynamic> files = {};
      String postData = "-d ''";
      if (data != null) {
        if (data is FormData) {
          FormData fdata = data as FormData;
          for (var element in fdata.files) {
            MultipartFile file = element.value;
            files[element.key] = "@${file.filename}";
          }
          for (var element in fdata.fields) {
            files[element.key] = element.value;
          }
          if (files.isNotEmpty) {
            postData =
                files.map((key, value) => MapEntry(key, "--form '$key=$value'")).values.join(" ");
          }
        } else if (data is Map<String, dynamic>) {
          files.addAll(data);

          if (files.isNotEmpty) {
            postData = "-d '${json.encode(files).toString()}'";
          }
        }
      }

      String method = this.method.toString();
      cmd += " --location '$url' \\\n--request $method \\\n$header \\\n$postData";
    }

    return cmd;
  }
}
