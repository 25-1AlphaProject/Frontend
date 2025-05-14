import 'package:alpha_front/survey/pre_survey.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/SignUp/signup.dart';
import 'package:alpha_front/Home/home.dart';
import 'package:alpha_front/services/api_service.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool isPasswordVisible = false;
  bool showSuffixIcon = false;
  bool isID = false;
  bool isPW = false;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  // final success = await ApiService.login(id, pw);
  // bool isLogin = isID && isPW; // 로그인 조건

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
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3CB196),
                  ),
                ), //앱명
                const SizedBox(height: 100),
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    hintText: '아이디를 입력해주세요',
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    //   color: Colors.grey.shade400,
                    // ),
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
                  controller: _pwController,
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
                  onPressed: () async {
                    final id = _idController.text.trim();
                    final pw = _pwController.text.trim();

                    if (id.isEmpty || pw.isEmpty) {
                      if (!mounted) return; // context 안전 확인
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("입력 오류"),
                          content: const Text("아이디와 비밀번호를 모두 입력해주세요."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("확인"),
                            ),
                          ],
                        ),
                      );
                      return; // alert로 or textfield
                    }
                    final success = await ApiService.login(id, pw);

                    if (!mounted) return;

                    if (success) {
                      // 로그인 성공 시 홈으로 이동
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    } else {
                      // 로그인 실패 시 경고창
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("로그인 실패"),
                          content: const Text("아이디 또는 비밀번호가 올바르지 않습니다."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("확인"),
                            ),
                          ],
                        ),
                      );
                    }
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
                    Navigator.pushReplacement(
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
