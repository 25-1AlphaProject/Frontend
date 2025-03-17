import 'package:flutter/material.dart';

class PreSurvey6 extends StatefulWidget {
  const PreSurvey6({super.key});

  @override
  State<PreSurvey6> createState() => _PreSurvey6State();
}

class _PreSurvey6State extends State<PreSurvey6> {
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
                  '건강 목표는?',
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