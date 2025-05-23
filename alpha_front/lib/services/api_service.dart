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
          log("token: $token");
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
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        if (token != null) {
          await AuthManager.saveToken(token);
          log("Token: $token");
          log("회원가입 완료: ${response.statusCode} ${response.body}");
        }
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
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
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
        if (token != null) log("Token: $token");
        log("저장 완료: ${response.statusCode} ${response.body}");
        return true;
      } else {
        if (token != null) log("Token: $token");
        log("저장 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("저장 에러: $e");
      return false;
    }
  }

  static Future<bool> updateUser({
    required String password,
    required String nickname,
  }) async {
    try {
      final token = await AuthManager.getToken();
      final response = await http.put(
        Uri.parse('http://43.203.32.75:8080/api/users/info'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',        
        },
        body: jsonEncode({
          'password': password,
          'nickname': nickname,
        }),
      );

      if (response.statusCode == 200) {
        log("회원정보 수정 완료: ${response.statusCode} ${response.body}");
        return true;
      } else {
        log("회원정보 수정 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("회원정보 수정 에러: $e");
      return false;
    }
  }

static Future<Map<String, dynamic>?> getUserInfo() async {    // if (id.isEmpty) {
    //   log("회원정보 조회 실패");
    //   return null;
    // }
    try {
      final token = await AuthManager.getToken();
      final uri = Uri.parse('http://43.203.32.75:8080/api/users/info');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        log("회원정보 조회 성공: ${response.body}");
        return decoded['data'];
      } else {
        log("회원정보 조회 실패: ${response.statusCode} ${response.body}");
        return null;
      }
    } catch (e) {
      log("회원정보 조회 에러: $e");
      return null;
    }
  }

  static Future<bool> foodinfo(
    String name,
    double foodCalories,
    String amount,
    DateTime mealDate,
    String mealType,
    String mealPhoto,

  ) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.post(
        Uri.parse('http://43.203.32.75:8080/api/meal/real-eat/write'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'foodCalories': foodCalories,
          'amount' : amount,
          'mealDate' : mealDate,
          'mealType' : mealType,
          'mealPhoto': mealPhoto,
        }),
      );

      if (response.statusCode == 200) {
        if (token != null) log("Token: $token");
        log("전달 완료: ${response.statusCode} ${response.body}");
        return true;
      } else {
        if (token != null) log("Token: $token");
        log("전달 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("전달 에러: $e");
      return false;
    }
  }

}
