import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:alpha_front/survey/pre_survey.dart';

class signuploading extends StatefulWidget {
  const signuploading({super.key});

  @override
  _signuploadingState createState() => _signuploadingState();
}

class _signuploadingState extends State<signuploading> {
  double percent = 0.0;
  late Timer _timer; // 타이머 변수

  @override
  void initState() {
    super.initState();
    startLoading();
  }

  void startLoading() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) return; // 위젯이 마운트 해제되었으면 실행 방지

      setState(() {
        if (percent >= 1.0) {
          _timer.cancel(); // 타이머 중지
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              // context가 여전히 유효한지 확인
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Survey()),
              );
            }
          });
        } else {
          percent += 0.1;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 타이머 종료
    super.dispose();
  }

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
              '곧 사전설문 페이지로 이동할게요',
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
                  backgroundColor: const Color.fromRGBO(227, 227, 227, 1.0),
                  progressColor: const Color.fromRGBO(17, 139, 80, 1.0)),
            ),
          ],
        ),
      ),
    );
  }
}
