import 'dart:convert';
import 'dart:developer';
import 'package:alpha_front/auth/auth_manager.dart';
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
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        if (token != null) {
          await AuthManager.saveToken(token);
          log("로그인 성공: ${response.statusCode} ${response.body}");
        }
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
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        log("회원가입 완료: ${response.statusCode} ${response.body}");
        return true;
      } else if (response.statusCode == 409) {
        log("중복된 아이디: ${response.statusCode} ${response.body}");
        return false;
      } else {
        log("회원가입 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("회원가입 에러: $e");
      return false;
    }
  }

  static Future<bool> dietinfo(
    String selectedGender,
    int age,
    double height,
    double weight,
    List<String> mealCount,
    int targetCalories,
    List<String> allergies,
    List<String> diseases,
    List<String> preferredMenus,
    List<String> avoidIngredients,
    String healthGoal,
  ) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.post(
        Uri.parse('http://43.203.32.75:8080/api/users/diet-info'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'age': age,
          'height': height,
          'weight': weight,
          'gender': selectedGender,
          'mealCount': mealCount,
          'targetCalories': targetCalories,
          'userDietInfo': {
            'allergies': allergies,
            'diseases': diseases,
            'preferredMenus': preferredMenus,
            'avoidIngredients': avoidIngredients,
          },
          'healthGoal': healthGoal,
        }),
      );

      if (response.statusCode == 200) {
        log("저장 완료: ${response.statusCode} ${response.body}");
        return true;
      } else {
        log("저장 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("저장 에러: $e");
      return false;
    }
  }
}
