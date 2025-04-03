import 'package:flutter/material.dart';
import 'package:alpha_front/SignUp/signup_loading.dart';

class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  _signupScreenState createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  int currentStep = 1;
  String username = '';
  bool showSuffixIcon = false;
  bool isPasswordVisible = false;
  bool isPasswordVisible2 = false;

  bool name = false;
  bool id = false;
  bool nickname = false;
  bool password = false;
  bool email = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(44.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    '척척밥사',
                    style: TextStyle(
                      fontFamily: 'yg-jalnan',
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(17, 139, 80, 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  currentStep == 1
                      ? "이름을"
                      : currentStep == 2
                          ? "닉네임을"
                          : currentStep == 3
                              ? "아이디를"
                              : currentStep == 4
                                  ? "비밀번호를"
                                  : "이메일을",
                  style: const TextStyle(
                      fontFamily: 'yg-jalnan',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  "입력해주세요",
                  style: TextStyle(
                      fontFamily: 'yg-jalnan',
                      fontSize: 30,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 30),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "이름을 입력해주세요",
                    hintStyle: TextStyle(
                      fontFamily: "PretenderardVariable",
                      fontSize: 12,
                      color: Color.fromRGBO(182, 182, 182, 100.0),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      username = value;
                      if (currentStep == 1) {
                        currentStep = 2;
                      }
                      name = value.isNotEmpty;
                    });
                  },
                ),
                const SizedBox(height: 21),
                Visibility(
                  visible: currentStep >= 2,
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: "$username님을 어떻게 불러드릴까요?",
                          labelStyle: const TextStyle(
                            fontFamily: "PretenderardVariable",
                            fontSize: 12,
                            color: Color.fromRGBO(182, 182, 182, 100.0),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            if (currentStep == 2) {
                              currentStep = 3;
                            }
                            nickname = value.isNotEmpty;
                          });
                        },
                      ),
                      const SizedBox(height: 21),
                    ],
                  ),
                ),
                Visibility(
                  visible: currentStep >= 3,
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: "아이디를 입력해주세요",
                          labelStyle: TextStyle(
                            fontFamily: "PretenderardVariable",
                            fontSize: 12,
                            color: Color.fromRGBO(182, 182, 182, 100.0),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            if (currentStep == 3) {
                              currentStep = 4;
                            }
                            id = value.isNotEmpty;
                          });
                        },
                      ),
                      const SizedBox(height: 21),
                    ],
                  ),
                ),
                Visibility(
                  visible: currentStep >= 4,
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: "비밀번호를 입력해주세요",
                          labelStyle: const TextStyle(
                            fontFamily: "PretenderardVariable",
                            fontSize: 12,
                            color: Color.fromRGBO(182, 182, 182, 100.0),
                            fontWeight: FontWeight.normal,
                          ),
                          helperText:
                              "영문 / 숫자 / 기호 중 2가지 이상 조합, 8자리 이상으로 설정해주세요",
                          helperStyle: const TextStyle(
                            fontFamily: "PretenderardVariable",
                            fontSize: 8,
                            color: Color.fromRGBO(182, 182, 182, 100.0),
                            fontWeight: FontWeight.normal,
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
                                    color: const Color.fromRGBO(
                                        121, 121, 121, 100.0),
                                    size: 16,
                                  ),
                                )
                              : null,
                        ),
                        obscureText: !isPasswordVisible,
                        onChanged: (text) {
                          setState(() {
                            showSuffixIcon = text.isNotEmpty;
                          });
                        },
                        onSubmitted: (value) {
                          setState(() {
                            if (currentStep == 4) {
                              currentStep = 5;
                            }
                            password = value.isNotEmpty;
                          });
                        },
                      ),
                      const SizedBox(height: 21),
                    ],
                  ),
                ),
                Visibility(
                  visible: currentStep >= 5,
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: "이메일을 입력해주세요",
                          labelStyle: TextStyle(
                            fontFamily: "PretenderardVariable",
                            fontSize: 12,
                            color: Color.fromRGBO(182, 182, 182, 100.0),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            if (currentStep == 5) {
                              currentStep = 6;
                            }
                            email = value.isNotEmpty;
                          });
                        },
                      ),
                      const SizedBox(height: 21),
                    ],
                  ),
                ),
                Visibility(
                  visible: currentStep >= 6 &&
                      name &&
                      nickname &&
                      id &&
                      password &&
                      email,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const signuploading()),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          const Color.fromRGBO(226, 226, 226, 100.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      minimumSize: const Size(double.infinity, 43),
                      elevation: 0,
                    ),
                    child: const Text(
                      "회원가입하기",
                      style: TextStyle(
                        fontFamily: "PretenderardVariable",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(136, 136, 136, 100.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
