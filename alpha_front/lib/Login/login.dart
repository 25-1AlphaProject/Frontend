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
            padding:
                const EdgeInsets.symmetric(horizontal: 33.0, vertical: 33.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(
                    // image 변경 - url => network
                    'alpha_front/assets/images/character.png',
                  ),
                ),
                const SizedBox(height: 11),
                const Text(
                  '척척밥사',
                  style: TextStyle(
                    fontFamily: 'yg-jalnan',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(60, 177, 150, 1.0),
                  ),
                ), //앱명
                const SizedBox(height: 99),
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    hintText: '아이디를 입력해주세요',
                    // hintStyle: TextStyle(
                    //   fontFamily: 'Pretendard-light',
                    //   fontSize: 15,
                    //   color: Color.fromRGBO(182, 182, 182, 1),
                    // ),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: const Color(0xffb6b6b6)),
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
                const SizedBox(height: 35),
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
                    // hintStyle: const TextStyle(
                    //   fontFamily: 'Pretendard-light',
                    //   fontSize: 15,
                    //   color: Color.fromRGBO(182, 182, 182, 1.0),
                    // ),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: const Color(0xffb6b6b6)),
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
                              color: const Color.fromRGBO(182, 182, 182, 1.0),
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
                const SizedBox(height: 51),
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
                    backgroundColor: const Color.fromRGBO(60, 177, 150, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    minimumSize: const Size(double.infinity, 50),
                    elevation: 0,
                  ),
                  child: Text(
                    "로그인하기",
                    // style: TextStyle(
                    //   fontFamily: 'Pretendard-light',
                    //   fontSize: 20,
                    //   color: Colors.black87,
                    // ),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ), //로그인 버튼
                const SizedBox(height: 23),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '아이디 / 비밀번호 찾기',
                    style: TextStyle(
                      fontFamily: 'Pretendard-light',
                      fontSize: 15,
                      color: Color.fromRGBO(60, 177, 150, 1.0),
                      decorationColor: Color.fromRGBO(60, 177, 150, 1.0),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ), //아이디/비밀번호 찾기 버튼
                const SizedBox(height: 11),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const signupScreen()),
                    );
                  },
                  child: const Text(
                    '아직 회원이 아니신가요? 회원가입 하기',
                    style: TextStyle(
                      fontFamily: 'Pretendard-light',
                      fontSize: 15,
                      color: Color.fromRGBO(60, 177, 150, 1.0),
                      decorationColor: Color.fromRGBO(60, 177, 150, 1.0),
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
