import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  _signupScreenState createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  int currentStep = 1;
  String username = '';
  String password = '';
  String checkPassword = '';
  bool isPasswordVisible = false;
  bool isPasswordVisible2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(),
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
                // const Center(
                //   child: Text(
                //     '척척밥사',
                //     style: TextStyle(
                //       fontFamily: 'yg-jalnan',
                //       fontSize: 30,
                //       fontWeight: FontWeight.normal,
                //       color: Color.fromRGBO(17, 139, 80, 1.0),
                //     ),
                //   ),
                // ),
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
                                  : currentStep == 5
                                      ? "비밀번호를 한 번 더"
                                      : currentStep == 6
                                          ? "이메일을"
                                          : currentStep == 7
                                              ? "전화번호를"
                                              : "인증번호를",
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
                      color: Color.fromRGBO(182, 182, 182, 1.0),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      username = value;
                      currentStep = 2;
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
                            color: Color.fromRGBO(182, 182, 182, 1.0),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            if (currentStep == 2) {
                              currentStep = 3;
                            }
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
                        decoration: InputDecoration(
                          labelText: "아이디를 입력해주세요",
                          labelStyle: const TextStyle(
                            fontFamily: "PretenderardVariable",
                            fontSize: 12,
                            color: Color.fromRGBO(182, 182, 182, 1.0),
                            fontWeight: FontWeight.normal,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 6, bottom: 4),
                            child: SizedBox(
                              height: 22,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(217, 217, 217, 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  minimumSize: const Size(60, 22),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "중복확인",
                                  style: TextStyle(
                                    fontFamily: "PretenderardVariable",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Color.fromRGBO(121, 121, 121, 1.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            if (currentStep == 3) {
                              currentStep = 4;
                            }
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
                            color: Color.fromRGBO(182, 182, 182, 1.0),
                            fontWeight: FontWeight.normal,
                          ),
                          helperText:
                              "영문 / 숫자 / 기호 중 2가지 이상 조합, 8자리 이상으로 설정해주세요",
                          helperStyle: const TextStyle(
                            fontFamily: "PretenderardVariable",
                            fontSize: 8,
                            color: Color.fromRGBO(182, 182, 182, 1.0),
                            fontWeight: FontWeight.normal,
                          ),
                          suffixIcon: IconButton(
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
                          ),
                        ),
                        obscureText: !isPasswordVisible,
                        onSubmitted: (value) {
                          setState(() {
                            if (currentStep == 4) {
                              currentStep = 5;
                            }
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
                        decoration: InputDecoration(
                          labelText: "비밀번호를 한 번 더 입력해주세요",
                          labelStyle: const TextStyle(
                            fontFamily: "PretenderardVariable",
                            fontSize: 12,
                            color: Color.fromRGBO(182, 182, 182, 1.0),
                            fontWeight: FontWeight.normal,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible2 = !isPasswordVisible2;
                              });
                            },
                            icon: Icon(
                              isPasswordVisible2
                                  ? Icons.visibility
                                  : Icons.visibility_off_rounded,
                              color: const Color.fromRGBO(121, 121, 121, 1.0),
                              size: 16,
                            ),
                          ),
                        ),
                        obscureText: !isPasswordVisible2,
                        onSubmitted: (value) {
                          setState(() {
                            if (currentStep == 5) {
                              currentStep = 6;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 21),
                    ],
                  ),
                ),
                Visibility(
                  visible: currentStep >= 6,
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: "이메일을 입력해주세요",
                          labelStyle: TextStyle(
                            fontFamily: "PretenderardVariable",
                            fontSize: 12,
                            color: Color.fromRGBO(182, 182, 182, 1.0),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            if (currentStep == 6) {
                              currentStep = 7;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 21),
                    ],
                  ),
                ),
                Visibility(
                  visible: currentStep >= 7,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "전화번호를 입력해주세요",
                          labelStyle: const TextStyle(
                            fontFamily: "PretenderardVariable",
                            fontSize: 12,
                            color: Color.fromRGBO(182, 182, 182, 1.0),
                            fontWeight: FontWeight.normal,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 6, bottom: 4),
                            child: SizedBox(
                              height: 22,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(217, 217, 217, 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  minimumSize: const Size(77, 22),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "인증번호 발송",
                                  style: TextStyle(
                                    fontFamily: "PretenderardVariable",
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(121, 121, 121, 1.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            if (currentStep == 7) {
                              currentStep = 8;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 21),
                    ],
                  ),
                ),
                Visibility(
                  visible: currentStep >= 8,
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: "인증번호를 입력해주세요",
                          labelStyle: const TextStyle(
                            fontFamily: "PretenderardVariable",
                            fontSize: 12,
                            color: Color.fromRGBO(182, 182, 182, 1.0),
                            fontWeight: FontWeight.normal,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 6, bottom: 4),
                            child: SizedBox(
                              height: 22,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(217, 217, 217, 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  minimumSize: const Size(60, 22),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "인증 확인",
                                  style: TextStyle(
                                    fontFamily: "PretenderardVariable",
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(121, 121, 121, 1.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            if (currentStep == 8) {
                              currentStep = 9;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
                Visibility(
                  visible: currentStep >= 9,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(226, 226, 226, 1.0),
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
                        color: Color.fromRGBO(136, 136, 136, 1.0),
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
