import 'package:alpha_front/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/Login/login.dart';
import 'dart:async';

class PreSurveyFinal extends StatefulWidget {
  const PreSurveyFinal({super.key});

  @override
  State<PreSurveyFinal> createState() => _PreSurveyFinalState();
}

class _PreSurveyFinalState extends State<PreSurveyFinal> {
  @override
  void initState() {
    super.initState();
    // 3초 후에 HomeScreen으로 이동
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const loginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(31, 78, 31, 31),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: const Center(
                child: Text(
                  '김유진님, \n일주일치 식단 추천이 \n완료되었습니다!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff3CB196),
                    fontFamily: 'Pretendard-bold',
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Image(
                image: AssetImage(
                  '../assets/images/character.png'
                  )
                ),
            ),
          ],
        ),
      ),
    );
  }
}
