import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  //user
  static Future<bool> login(String id, String pw) async {
    try {
      final response = await http.post(
        Uri.parse('http://43.203.32.75:8080/api/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': id,
          'password': pw,
        }),
      );

      if (response.statusCode == 200) {
        log("로그인 성공: ${response.statusCode} ${response.body}");
        return true;
      } else {
        log("로그인 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("로그인 에러: $e");
      return false;
    }
  }

  static Future<bool> signup(
    String id,
    String pw,
    String name,
    String nickname,
    String email,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('http://43.203.32.75:8080/api/users/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': id,
          'password': pw,
          'name': name,
          'nickname': nickname,
          'phoneNumber': email,
        }),
      );

      if (response.statusCode == 200) {
        log("회원가입 완료: ${response.statusCode} ${response.body}");
        return true;
      } else {
        log("회원가입 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("회원가입 에러: $e");
      return false;
    }
  }
}
