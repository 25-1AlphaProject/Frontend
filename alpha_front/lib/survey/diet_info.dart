import 'package:alpha_front/services/api_service.dart';

class DietInfo{
  static String gender = '';
  static int age = 0;
  static double height = 0.0;
  static double weight = 0.0;
  static List<String> mealCount = [];
  static int targetCalories = 0;
  static List<String> allergies = [];
  static List<String> diseases = [];
  static List<String> preferredMenus = [];
  static List<String> avoidIngredients = [];
  static String healthGoal = '';

  static Future<bool> submitToBackend() async {
    return await ApiService.dietinfo(
      gender,
      age,
      height,
      weight,
      mealCount,
      targetCalories,
      allergies,
      diseases,
      preferredMenus,
      avoidIngredients,
      healthGoal,
    );
  }
}