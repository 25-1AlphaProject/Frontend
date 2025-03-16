import 'package:flutter/material.dart';

class PreSurvey2 extends StatefulWidget {
  const PreSurvey2({super.key});

  @override
  State<PreSurvey2> createState() => _PreSurvey2State();
}

class _PreSurvey2State extends State<PreSurvey2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(31, 78, 31, 31),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '앓고 계신 식품 관련 \n알레르기 질환이 있나요?',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'yg-jalnan',
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}