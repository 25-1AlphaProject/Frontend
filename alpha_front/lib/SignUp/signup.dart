import 'package:flutter/material.dart';

class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  _signupScreenState createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  int currentStep = 1; //텍스트필드 순서
  String username = '';

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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '척척밥사',
                    style: TextStyle(
                      fontFamily: 'yg-jalnan',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ), //앱명
                const SizedBox(height: 48),
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
                                          ? " 이메일을"
                                          : currentStep == 7
                                              ? "전화번호를"
                                              : "인증번호를",
                  style: const TextStyle(
                      fontFamily: 'yg-jalnan',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "입력해주세요",
                  style: TextStyle(
                      fontFamily: 'yg-jalnan',
                      fontSize: 30,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 39),

                TextField(
                  decoration: const InputDecoration(labelText: "이름을 입력해주세요"),
                  onSubmitted: (value) {
                    setState(() {
                      username = value;
                      currentStep = 2; // 다음 단계로 이동
                    });
                  },
                ), //이름
                const SizedBox(height: 15),

                Visibility(
                  visible: currentStep >= 2,
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            labelText: "$username님을 어떻게 불러드릴까요?"),
                        onSubmitted: (value) {
                          setState(() {
                            currentStep = 3; // 다음 단계로 이동
                          });
                        },
                      ), //이름
                      const SizedBox(height: 10),
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
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade400,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  minimumSize: const Size(70, 40),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "중복확인",
                                  style: TextStyle(
                                    fontFamily: "PretenderardVariable",
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            currentStep = 4; // 다음 단계로 이동
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),

                Visibility(
                  visible: currentStep >= 4,
                  child: Column(
                    children: [
                      TextField(
                        decoration:
                            const InputDecoration(labelText: "비밀번호를 입력해주세요"),
                        obscureText: true,
                        onSubmitted: (value) {
                          setState(() {
                            currentStep = 5; // 다음 단계로 이동
                          });
                        },
                      ), //비번
                      const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          "영문 / 숫자 / 기호 중 2가지 이상 조합, 8자리 이상으로 설정해주세요",
                          style: TextStyle(
                            fontFamily: "PretendardVariable",
                            fontSize: 8,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),

                Visibility(
                  visible: currentStep >= 5,
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                            labelText: "비밀번호를 한 번 더 입력해주세요"),
                        obscureText: true,
                        onSubmitted: (value) {
                          setState(() {
                            currentStep = 6; // 다음 단계로 이동
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ), //비번 재확인

                Visibility(
                  visible: currentStep >= 6,
                  child: Column(
                    children: [
                      TextField(
                        decoration:
                            const InputDecoration(labelText: "이메일을 입력해주세요"),
                        onSubmitted: (value) {
                          setState(() {
                            currentStep = 7; // 다음 단계로 이동
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ), //이메일

                Visibility(
                  visible: currentStep >= 7,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "전화번호를 입력해주세요",
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade400,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  minimumSize: const Size(70, 40),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "인증번호 발송",
                                  style: TextStyle(
                                    fontFamily: "PretenderardVariable",
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            currentStep = 8; // 다음 단계로 이동
                          });
                        },
                      ),
                      const SizedBox(height: 10),
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
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade400,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  minimumSize: const Size(70, 40),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "인증 확인",
                                  style: TextStyle(
                                    fontFamily: "PretenderardVariable",
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            currentStep = 9; // 다음 단계로 이동
                          });
                        },
                      ),
                      const SizedBox(height: 74),
                    ],
                  ),
                ),

                Visibility(
                  visible: currentStep >= 8,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // 둥글게 조정
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12), // 좌우 패딩 조정
                      minimumSize: const Size(double.infinity, 43), // 크기 조정
                      elevation: 0,
                    ),
                    child: const Text(
                      "회원가입하기",
                      style: TextStyle(
                        fontFamily: "PretenderardVariable",
                        fontSize: 14,
                        color: Colors.black87,
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
