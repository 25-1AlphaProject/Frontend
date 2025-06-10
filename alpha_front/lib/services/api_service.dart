import 'dart:convert';
import 'dart:developer';
import 'package:alpha_front/auth/auth_manager.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiService {
  static const _baseUrl = 'http://3.38.66.123:8080';

  //로그인
  static Future<bool> login(String id, String pw) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/users/login'),
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

  //회원가입
  static Future<Map<String, dynamic>> signup(
    String id,
    String pw,
    String name,
    String nickname,
    String email,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/users/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': id,
          'password': pw,
          'name': name,
          'nickname': nickname,
          'email': email,
        }),
      );

      final responseData = jsonDecode(response.body);
      final token = responseData['token'];
      final responseMessage = responseData['message'] ?? '에러가 발생했습니다.';

      if (response.statusCode == 200) {
        if (token != null) {
          await AuthManager.saveToken(token);
          log("Token: $token");
          log("회원가입 완료: ${response.statusCode} ${response.body}");
        }
        return {'success': true};
      } else if (response.statusCode == 409) {
        log("중복된 아이디: ${response.statusCode} ${response.body}");
        return {'success': false, 'message': responseMessage};
      } else {
        log("회원가입 실패: ${response.statusCode} ${response.body}");
        return {'success': false, 'message': responseMessage};
      }
    } catch (e) {
      log("회원가입 에러: $e");
      return {'success': false};
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
        Uri.parse('$_baseUrl/api/users/diet-info'),
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
      }
      if (response.statusCode == 401) {
        await AuthManager.clearToken();
        return false;
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
        Uri.parse('$_baseUrl/api/users/info'),
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

  static Future<Map<String, dynamic>?> getUserInfo() async {
    // if (id.isEmpty) {
    //   log("회원정보 조회 실패");
    //   return null;
    // }
    try {
      final token = await AuthManager.getToken();
      final uri = Uri.parse('$_baseUrl/api/users/info');
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

  static Future<bool> updateDiet({
    required String selectedGender,
    required int age,
    required double height,
    required double weight,
    required List<String> mealCount,
    required int targetCalories,
    required List<String> allergies,
    required List<String> diseases,
    required List<String> preferredMenus,
    required List<String> avoidIngredients,
    required String healthGoal,
  }) async {
    try {
      final token = await AuthManager.getToken();
      final response = await http.put(
        Uri.parse('$_baseUrl/api/users/diet-info'),
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
        log("회원 다이어트 정보 수정 완료: ${response.statusCode} ${response.body}");
        return true;
      } else {
        log("회원 다이어트 정보 수정 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("회원 다이어트 정보 수정 에러: $e");
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getUserDietInfo() async {
    // if (id.isEmpty) {
    //   log("회원정보 조회 실패");
    //   return null;
    // }
    try {
      final token = await AuthManager.getToken();
      final uri = Uri.parse('$_baseUrl/api/users/diet-info');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        log("회원 다이어트 정보 조회 성공: ${response.body}");
        return decoded['data'];
      } else {
        log("회원 다이어트 정보 조회 실패: ${response.statusCode} ${response.body}");
        return null;
      }
    } catch (e) {
      log("회원 다이어트 정보 조회 에러: $e");
      return null;
    }
  }

  //실제 먹은 식단 추가하기[수기로 추가하는 경우]
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
        Uri.parse('$_baseUrl/api/meal/real-eat/write'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'foodCalories': foodCalories,
          'amount': amount,
          'mealDate': DateFormat('yyyy-MM-dd').format(mealDate),
          'mealType': mealType,
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

  static Future<Map<String, dynamic>?> foodinfoCustom(
    double amount,
    DateTime mealDate,
    String mealType,
    String mealPhoto,
  ) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.post(
        Uri.parse('$_baseUrl/api/meal/real-eat/custom'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'amount': amount,
          'mealDate': DateFormat('yyyy-MM-dd').format(mealDate),
          'mealType': mealType,
          'mealPhoto': mealPhoto,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (token != null) log("Token: $token");
        log("전달 완료: ${response.statusCode} ${response.body}");
        return responseData['message'];
      } else {
        if (token != null) log("Token: $token");
        log("전달 실패: ${response.statusCode} ${response.body}");
        return null;
      }
    } catch (e) {
      log("전달 에러: $e");
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> getRecipeList(
      String keyword) async {
    try {
      final token = await AuthManager.getToken();
      final uri = Uri.parse('$_baseUrl/api/recipe/search?keyword=$keyword');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        log("레시피 검색 성공: ${response.body}");

        final message = decoded['message'];
        if (message is List) {
          return List<Map<String, dynamic>>.from(message);
        } else {
          log("message가 리스트가 아님: $message");
          return null;
        }
      } else {
        log("레시피 검색 실패: ${response.statusCode} ${response.body}");
        return null;
      }
    } catch (e) {
      log("레시피 검색 에러: $e");
      return null;
    }
  }

  //해당 날짜 실제 먹은 식단 조회
  static Future<List<dynamic>> fetchkcalData(String date) async {
    try {
      final token = await AuthManager.getToken();
      final response = await http.get(
        Uri.parse('$_baseUrl/api/meal/real-eat/$date'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log("실제로 먹은 음식: $data");

        // 1. message 필드가 List인지 확인
        if (data['message'] is! List) {
          throw const FormatException(
              'Invalid response format: message is not a list');
        }

        // 2. message 배열 반환
        return data['message'] as List<dynamic>;
        // return data;
      } else {
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      log("요청 실패: $e");
      rethrow;
    }
  }

  //해당 날짜 생성된 식단 조회
  static Future<Map<String, dynamic>> mealDayData(String date) async {
    try {
      final token = await AuthManager.getToken();
      final response = await http.get(
        Uri.parse('$_baseUrl/api/meal/$date'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log("생성된 식단 조회: $data");
        return data;
      } else {
        log("서버 응답 오류: ${response.statusCode}");
        throw Exception("서버 응답 오류: ${response.statusCode}");
      }
    } catch (e) {
      log("요청 실패: $e");
      throw Exception("요청 실패: $e");
    }
  }

  //일주일 식단 생성하기
  static Future<Map<String, dynamic>> createMealData() async {
    try {
      final token = await AuthManager.getToken();
      final response = await http.get(
        Uri.parse('$_baseUrl/api/meal/weekly'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log("일주일치 식단 생성: $data");
        return data;
      } else {
        log("서버 응답 오류: ${response.statusCode}");
        throw Exception("서버 응답 오류: ${response.statusCode}");
      }
    } catch (e) {
      log("요청 실패: $e");
      throw Exception("요청 실패: $e");
    }
  }

  //게시글 목록 조회
  static Future<bool> write(
    String title,
    String content,
    List imageUrlsList,
  ) async {
    try {
      final token = await AuthManager.getToken();
      final response = await http.post(
        Uri.parse('$_baseUrl/api/community/posts'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "title": title,
          "content": content,
          "imageUrls": imageUrlsList,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log("글 작성 성공: $data");
        return true;
      } else {
        log("서버 응답 오류: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      log("요청 실패: $e");
      return false;
    }
  }

  Future<String?> fetchPresignedUrl(String objectKey) async {
    final token = await AuthManager.getToken();
    final uri =
        Uri.parse('$_baseUrl/api/s3/presigned-url?objectKey=$objectKey');

    log('objectKey: $objectKey');
    log('token: $token');
    log('uri: $uri');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded['message'] as String?;
    }
    return null;
  }

  //재료 링크 조회하기
  static Future<Map<String, dynamic>?> linksIngredient(int recipeId) async {
    try {
      final token = await AuthManager.getToken();
      final response = await http.get(
        Uri.parse('$_baseUrl/api/meal/ingredient-links/$recipeId'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log("재료링크 조회하기: $data");
        return data;
      } else {
        log("서버 응답 오류: ${response.statusCode}");
        throw Exception("서버 응답 오류: ${response.statusCode}");
      }
    } catch (e) {
      log("요청 실패: $e");
      throw Exception("요청 실패: $e");
    }
  }

  static Future<bool> updateProfileImage({
    required String imageURL,
  }) async {
    try {
      final token = await AuthManager.getToken();
      final response = await http.put(
        Uri.parse('$_baseUrl/api/users/profile-image'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'profileImageUrl': imageURL,
        }),
      );

      if (response.statusCode == 200) {
        log("프로필이미지 수정 완료: ${response.statusCode} ${response.body}");
        return true;
      } else {
        log("프로필이미지 수정 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("프로필이미지 수정 에러: $e");
      return false;
    }
  }

  //게시글 키워드 검색
  static Future<List<Map<String, dynamic>>?> getPostList(String keyword) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.get(
        Uri.parse('$_baseUrl/api/community/posts/search?keyword=$keyword'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        log("커뮤니티 검색 성공: ${response.body}");
        // final List<Map<String, dynamic>> result =
        //     decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
        // return result;
        // print(List<Map<String, dynamic>>.from(decoded));
        return List<Map<String, dynamic>>.from(decoded);
      } else {
        log("커뮤니티 검색 실패: ${response.statusCode} ${response.body}");
        return null;
      }
    } catch (e) {
      log("커뮤니티 검색 에러: $e");
      return null;
    }
  }

  //게시글 목록 조회
  static Future<List<Map<String, dynamic>>?> sortSearchPost(
    String sort,
    int page,
    int size,
  ) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.get(
        Uri.parse(
            '$_baseUrl/api/community/posts?sort=$sort&page=$page&size=$size'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        log("커뮤니티 검색 정렬 성공: ${response.body}");
        return List<Map<String, dynamic>>.from(decoded['posts'] ?? decoded);
      } else {
        log("커뮤니티 검색 정렬 실패: ${response.statusCode} ${response.body}");
        return null;
      }
    } catch (e) {
      log("커뮤니티 검색 정렬 에러: $e");
      return null;
    }
  }

  //레시피 조회하기
  static Future<List<Map<String, dynamic>>?> getRecipeDetail(
      String recipeId) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.get(
        Uri.parse('$_baseUrl/api/recipe?recipeId=$recipeId'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        log("레시피 조회 성공: ${response.body}");
        return decoded;
      } else {
        log("레시피 조회 실패: ${response.statusCode} ${response.body}");
        return null;
      }
    } catch (e) {
      log("레시피 조회 에러: $e");
      return null;
    }
  }

  //레시피 이미지 조회하기
  static Future<String> getImage(String imageURL) async {
    try {
      final token = await AuthManager.getToken();
      final response = await http.get(
        Uri.parse('$_baseUrl/api/recipe/image?url=$imageURL'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // log("이미지 조회하기: $data");
        return data['message'];
      } else {
        log("서버 응답 오류: ${response.statusCode}");
        throw Exception("서버 응답 오류: ${response.statusCode}");
      }
    } catch (e) {
      log("요청 실패: $e");
      throw Exception("요청 실패: $e");
    }
  }

  // 추천 식단을 실제 섭취로 추가
  static Future<bool> postRealEat({
    required int recipeId,
    required DateTime mealDate,
    required String mealType,
    required double calories,
  }) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.post(
        Uri.parse('$_baseUrl/api/meal/real-eat'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'recipeId': recipeId,
          'mealDate': DateFormat('yyyy-MM-dd').format(mealDate),
          'mealType': mealType,
          'calories': calories,
        }),
      );

      if (response.statusCode == 200) {
        if (token != null) log("Token: $token");
        log("추천 식단을 실제 섭취로 추가 완료: ${response.statusCode} ${response.body}");
        return true;
      } else {
        if (token != null) log("Token: $token");
        log("추천 식단을 실제 섭취로 추가 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("추천 식단을 실제 섭취로 추가 에러: $e");
      return false;
    }
  }

  static Future<bool> deleteRealEat(int realEatId) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.delete(
        Uri.parse('$_baseUrl/api/meal/real-eat/$realEatId'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        if (token != null) log("Token: $token");
        log("실제 섭취 식단 삭제 완료: ${response.statusCode} ${response.body}");
        return true;
      } else {
        if (token != null) log("Token: $token");
        log("실제 섭취 식단 삭제 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("실제 섭취 식단 삭제 에러: $e");
      return false;
    }
  }

  static Future<bool> deleteRecipeFavorite(int recipeId) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.delete(
        Uri.parse('$_baseUrl/api/recipe/favorite/$recipeId'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        if (token != null) log("Token: $token");
        log("좋아하는 레시피 삭제 완료: ${response.statusCode} ${response.body}");
        return true;
      } else {
        if (token != null) log("Token: $token");
        log("좋아하는 레시피 삭제 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("좋아하는 레시피 삭제 에러: $e");
      return false;
    }
  }

  static Future<bool> postRecipeFavorite(int recipeId) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.post(
        Uri.parse('$_baseUrl/api/recipe/favorite/$recipeId'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("좋아하는 레시피 등록 완료: ${response.statusCode} ${response.body}");
        return true;
      } else {
        log("좋아하는 레시피 등록 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      log("좋아하는 레시피 등록 에러: $e");
      return false;
    }
  }

  static Future<List<dynamic>> getRecipeFavorite() async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.get(
        Uri.parse('$_baseUrl/api/recipe/favorite'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("좋아하는 레시피 불러오기 완료: ${response.statusCode} ${response.body}");

        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        final message = jsonData['message'];

        // message 자체가 리스트인 경우
        if (message is List) {
          return message;
        }

        // message 안에 recipes 키가 있고 리스트인 경우
        if (message is Map && message['recipes'] is List) {
          return message['recipes'] as List<dynamic>;
        }

        // 그 외 → 빈 리스트 반환
        return [];
      } else {
        log("좋아하는 레시피 불러오기 실패: ${response.statusCode} ${response.body}");
        return [];
      }
    } catch (e) {
      log("좋아하는 레시피 불러오기 에러: $e");
      return [];
    }
  }

  // 좋아요 토글
  static Future<Map<String, dynamic>> postCommunityFavorite(int postId) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.post(
        Uri.parse('$_baseUrl/api/community/posts/$postId/likes'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("좋아하는 게시글 토글상태 등록 완료: ${response.statusCode} ${response.body}");
        final decoded = jsonDecode(response.body);
        return Map<String, dynamic>.from(decoded);
      } else {
        log("좋아하는 게시글 토글상태 등록 실패: ${response.statusCode} ${response.body}");
        throw Exception("서버 응답 오류: ${response.statusCode}");
      }
    } catch (e) {
      log("좋아하는 게시글 토글상태 등록 에러: $e");
      throw Exception("요청 실패: $e");
    }
  }

  // 스크랩 토글
  static Future<Map<String, dynamic>> postCommunityScrap(int postId) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.post(
        Uri.parse('$_baseUrl/api/community/posts/$postId/scraps'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("좋아하는 게시글 토글상태 등록 완료: ${response.statusCode} ${response.body}");
        final decoded = jsonDecode(response.body);
        return Map<String, dynamic>.from(decoded);
      } else {
        log("좋아하는 게시글 토글상태 등록 실패: ${response.statusCode} ${response.body}");
        throw Exception("서버 응답 오류: ${response.statusCode}");
      }
    } catch (e) {
      log("좋아하는 게시글 토글상태 등록 에러: $e");
      throw Exception("요청 실패: $e");
    }
  }

  // 게시글 상세 조회
  static Future<Map<String, dynamic>> getPostDetail(int postId) async {
    try {
      final token = await AuthManager.getToken();

      final response = await http.get(
        Uri.parse('$_baseUrl/api/community/posts/$postId'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        log("게시글 상세 조회 성공: ${response.body}");
        return Map<String, dynamic>.from(decoded);
      } else {
        log("게시글 상세 조회 실패: ${response.statusCode} ${response.body}");
        throw Exception("서버 응답 오류: ${response.statusCode}");
      }
    } catch (e) {
      log("게시글 상세 조회 에러: $e");
      throw Exception("요청 실패: $e");
    }
  }

static Future<List<dynamic>> getCommunityFavorite() async {
  try {
    final token = await AuthManager.getToken();

    final response = await http.get(
      Uri.parse('$_baseUrl/api/community/posts/liked'),
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log("좋아하는 게시글 불러오기 완료: ${response.statusCode} ${response.body}");

      final List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData;  // List를 바로 반환
    } else {
      log("좋아하는 게시글 불러오기 실패: ${response.statusCode} ${response.body}");
      return [];
    }
  } catch (e) {
    log("좋아하는 게시글 불러오기 에러: $e");
    return [];
  }
}


}
