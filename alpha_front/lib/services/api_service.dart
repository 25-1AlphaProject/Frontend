import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alpha_front/Home/home.dart';

class ApiService {
  static Future<bool> login(String id, String pw) async {
    try {
      final response = await http.post(
        Uri.parse('https://8080/api/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': id,
          'password': pw,
        }),
      );

      if (response.statusCode == 200) {
        // 토큰 저장
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("로그인 에러: $e");
      return false;
    }
  }
}
