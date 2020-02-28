

class ResponseDio{
  final dynamic data;
  final String message;

  ResponseDio(this.data, this.message);

  @override
  String toString() {
    return 'ResponseDio{data: $data, message: $message}';
  }
}