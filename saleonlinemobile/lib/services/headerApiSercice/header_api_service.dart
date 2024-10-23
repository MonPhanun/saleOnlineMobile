class HeaderApiService {
  static Map<String, String>? header({String? token = ''}) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    };
  }
}
