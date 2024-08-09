extension MapStringStringExtension on Map<String, String> {
  String get convertToParams {
    if (isEmpty) return '';
    final params = StringBuffer();
    forEach((key, value) {
      params.write('$key=$value&');
    });
    return params.toString().substring(0, params.length - 1);
  }
}