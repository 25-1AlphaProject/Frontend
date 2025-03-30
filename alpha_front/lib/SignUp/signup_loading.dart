import 'package:flutter/material.dart';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';

class signuploading extends StatefulWidget {
  const signuploading({super.key});

  @override
  _signuploadingState createState() => _signuploadingState();
}

class _signuploadingState extends State<signuploading> {
  @override
  Widget build(BuildContext context) {
    double percentbarWidth = max(233, MediaQuery.of(context).size.width - 160);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(71),
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
            const SizedBox(height: 195 - 71),
            const Text(
              '회원가입이 완료되었어요',
              style: TextStyle(
                  fontFamily: 'yg-jalnan',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              '곧 로그인 페이지로 이동할게요',
              style: TextStyle(
                  fontFamily: 'yg-jalnan',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 58,
            ),
            Padding(
              padding: EdgeInsets.only(left: max(0, 80), right: max(0, 80)),
              child: LinearPercentIndicator(
                  width: percentbarWidth,
                  animation: true,
                  lineHeight: 8.0,
                  percent: 0.5, // 서버와 통신(percent 변수 추후 수정)
                  barRadius: const Radius.circular(10),
                  backgroundColor: const Color.fromRGBO(227, 227, 227, 100.0),
                  progressColor: const Color.fromRGBO(17, 139, 80, 100.0)),
            ),
          ],
        ),
      ),
    );
  }
}
