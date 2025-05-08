import 'package:alpha_front/survey/pre_survey.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/SignUp/signup.dart';
import 'package:alpha_front/Home/home.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool isPasswordVisible = false;
  bool showSuffixIcon = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '척척밥사',
                  style: TextStyle(
                    fontFamily: 'yg-jalnan',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ), //앱명
                const SizedBox(height: 100),
                TextField(
                  decoration: InputDecoration(
                    hintText: '아이디를 입력해주세요',
                    hintStyle: TextStyle(
                      fontFamily: 'Pretendard-light',
                      color: Colors.grey.shade400,
                    ),
                    // filled: true,
                    // fillColor: Colors.white,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ), // 아이디
                const SizedBox(height: 20),
                TextField(
                  obscureText: !isPasswordVisible,
                  onChanged: (value) {
                    setState(() {
                      showSuffixIcon = value.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력해주세요',
                    hintStyle: TextStyle(
                      fontFamily: 'Pretendard-light',
                      color: Colors.grey.shade400,
                    ),
                    suffixIcon: showSuffixIcon
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off_rounded,
                              color: const Color.fromRGBO(121, 121, 121, 1.0),
                              size: 16,
                            ),
                          )
                        : null,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ), // 비번
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    minimumSize: const Size(double.infinity, 50),
                    elevation: 0,
                  ),
                  child: const Text(
                    "로그인하기",
                    style: TextStyle(
                      fontFamily: 'Pretendard-light',
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ), //로그인 버튼
                const SizedBox(height: 70),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '아이디 / 비밀번호 찾기',
                    style: TextStyle(
                      fontFamily: 'Pretendard-light',
                      color: Colors.green.shade700,
                      decorationColor: Colors.green.shade700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ), //아이디/비밀번호 찾기 버튼
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const signupScreen()),
                    );
                  },
                  child: Text(
                    '아직 회원이 아니신가요? 회원가입 하기',
                    style: TextStyle(
                      fontFamily: 'Pretendard-light',
                      color: Colors.green.shade700,
                      decorationColor: Colors.green.shade700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ), // 회원가입 버튼
              ],
            ),
          ),
        ),
      ),
    );
  }
}
