// hinttext랑 button은 통일했고, 작성 text 조절(활성화 되었을 때 색상 0xff3CB196로 / 작성한 text 크기 조절)만 하면 될 것 같아용!

import 'package:alpha_front/widgets/base_app_bar.dart';
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
      backgroundColor: Colors.white,
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
                                  : "이메일을",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: 'Pretendard-bold'),

                  textAlign: TextAlign.left,
                ),
                Text(
                  "입력해주세요",
                  style: Theme.of(context).textTheme.bodyLarge,

                ),
                const SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    hintText: "이름",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),

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
                          hintText: "닉네임",
                          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),

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
                        decoration: InputDecoration(
                          hintText: "아이디",
                          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),

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
                          hintText: "비밀번호",
                          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),

                          helperText:
                              "영문 / 숫자 / 기호 중 2가지 이상 조합, 8자리 이상으로 설정해주세요",
                          helperStyle: const TextStyle(
                            fontFamily: "PretenderardVariable",
                            fontSize: 12,
                            color: Color.fromRGBO(182, 182, 182, 1.0),
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
                                        121, 121, 121, 1.0),
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
                        decoration: InputDecoration(
                          hintText: "이메일",
                          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),

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
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const signuploading()),
                      );
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3CB196),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    minimumSize: const Size(double.infinity, 50),
                    elevation: 0,
                    ),
                    child: Text(
                      "회원가입하기",
                        style: Theme.of(context).textTheme.labelMedium,

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
