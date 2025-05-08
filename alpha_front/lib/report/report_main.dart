import 'package:alpha_front/widgets/baseappbar.dart';
import 'package:alpha_front/widgets/basenavigationbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportMain extends StatefulWidget {
  const ReportMain({super.key});

  @override
  State<ReportMain> createState() => _ReportMainState();
}

class _ReportMainState extends State<ReportMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(title: '결과리포트'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Color(0xfffafafa),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: 8)
                ],
              ),
              child: Column(
                children: [
                  Text('오늘의 리포트',
                  style: TextStyle(
                    fontFamily: 'yg-jalnan',
                  ),)
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Color(0xfffafafa),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: 8)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}