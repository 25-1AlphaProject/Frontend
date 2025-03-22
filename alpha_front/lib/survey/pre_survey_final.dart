import 'package:flutter/material.dart';

class PreSurveyFinal extends StatefulWidget {
  const PreSurveyFinal({super.key});

  @override
  State<PreSurveyFinal> createState() => _PreSurveyFinalState();
}

class _PreSurveyFinalState extends State<PreSurveyFinal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(31, 78, 31, 31),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Center(
                child: Text(
                  '김유진님, \n일주일치 식단 추천이 \n완료되었습니다!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff118B50),
                    fontFamily: 'yg-jalnan',
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Icon(
                Icons.check_circle_rounded,
              color: Color(0xff118B50),
              size: 70,
              ),
            ),
          ],

        ),
      ),
    );
  }
}