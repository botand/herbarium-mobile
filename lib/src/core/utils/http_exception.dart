class HttpException implements Exception {
  final String url;

  final int httpCode;

  final String message;

  const HttpException(
      {required this.url, required this.httpCode, required this.message});

  @override
  String toString() => "$url - $httpCode: $message";
}
