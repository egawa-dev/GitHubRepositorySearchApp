/// WebAPIのレスポンス
class ApiResponse {
  ApiResponse({required this.body, required this.headers});

  final Map<String, dynamic> body;
  final Map<String, dynamic> headers;
}
