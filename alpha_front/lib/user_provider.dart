import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _nickname = '';
  String _name = '';
  String _id = '';
  String _password = '';
  String _email = '';

  // Getter
  String get nickname => _nickname;
  String get name => _name;
  String get id => _id;
  String get password => _password;
  String get email => _email;



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

  // Setter (정보 수정)
  void updateUserInfo({
    required String nickname,
    required String password,
  }) {
    _nickname = nickname;
    _password = password;
    notifyListeners();
  }
}
