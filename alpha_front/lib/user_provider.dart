import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _nickname = '';
  String _name = '';
  String _id = '';
  String _password = '';
  String _email = '';

  int _age = 0;
  double _weight = 0.0;
  double _height = 0.0;
  String _gender = '';
  int _targetCalories = 0;
  String _healthGoal = '';
  List<String> _mealCount =[];
  List<String> _allergies =[];
  List<String> _diseases=[];
  List<String> _preferredMenus =[];
  List<String> _avoidIngredients=[];


  // Getter
  String get nickname => _nickname;
  String get name => _name;
  String get id => _id;
  String get password => _password;
  String get email => _email;

  int get age => _age ?? 22;
  int get targetCalories => _targetCalories ?? 1800;
  double get height => _height ?? 170.0;
  double get weight => _weight ?? 60.0;
  String get gender => _gender ?? "F";
  String get healthGoal => _healthGoal ?? "DIET";
  List<String> get mealCount => _mealCount ?? ['BREAKFAST', 'LUNCH'];
  List<String> get allergies => _allergies ?? [];
  List<String> get diseases => _diseases ?? [];
  List<String> get preferredMenus => _preferredMenus ?? [];
  List<String> get avoidIngredients => _avoidIngredients ?? [];


  void setUserInfo({
    required String nickname,
    required String name,
    required String id,
    required String password,
    required String email,
  }) {

    _nickname = nickname;
    _name = name;
    _id = id;
    _password = password;
    _email = email;
    notifyListeners();
  }

  void setUserDietInfo({
    required int age,
    required double height,
    required double weight,
    required int targetCalories,
    required String gender, 
    required List<String> mealCount,
    required List<String> allergies,
    required List<String> diseases,
    required List<String> preferredMenus,
    required List<String> avoidIngredients,
    required String healthGoal,    


  }) {
    _age = age;
    _weight = weight;
    _height = height;
    _targetCalories = targetCalories;
    _gender = gender;
    _mealCount = mealCount;
    _allergies = allergies;
    _diseases = diseases;
    _preferredMenus = preferredMenus;
    _avoidIngredients = avoidIngredients;
    _healthGoal = healthGoal;
    notifyListeners();
  }


  // Setter (정보 수정)
  void updateUserInfo({
    required String nickname,
    required String password,
  }) {
    _nickname = nickname;
    _password = password;
    notifyListeners();
  }

  void updateUserDietInfo({
    required int age,
    required double weight,
    required double height,
    required int targetCalories,
    required String gender,
    required List<String> mealCount,
    required List<String> allergies,
    required List<String> diseases,
    required List<String> preferredMenus,
    required List<String> avoidIngredients,
    required String healthGoal,

  }) {
    _age = age;
    _weight = weight;
    _height = height;
    _targetCalories = targetCalories;
    _gender = gender; 
    _allergies = allergies;
    _diseases = diseases;
    _avoidIngredients = avoidIngredients;
    _preferredMenus = preferredMenus;
    _healthGoal = healthGoal;

    notifyListeners();
  }
}
