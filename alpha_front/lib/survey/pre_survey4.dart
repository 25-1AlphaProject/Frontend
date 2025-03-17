import 'package:alpha_front/survey/pre_survey5.dart';
import 'package:flutter/material.dart';

class PreSurvey4 extends StatefulWidget {
  const PreSurvey4({super.key});

  @override
  State<PreSurvey4> createState() => _PreSurvey4State();
}

class _PreSurvey4State extends State<PreSurvey4> {
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
                  '식이요법 관리가 필요한 \n질환이 있나요?',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'yg-jalnan',
                    fontSize: 30,
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: TextField(
                keyboardType : TextInputType.number,
                decoration: InputDecoration(
                  hintText: '질환명',
                  enabledBorder : UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff000000),
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff118B50),
                    ),  
                  ),
                ), 
              ),
            ),

            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: Color(0xff118B50), width: 1),
                    elevation: 3,
                    
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreSurvey5())
                    );
                  }, 
                    child: Text(
                    '다음',
                      style: TextStyle(
                      fontFamily: 'PretendartVariable',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff118B50),
                
                    ),
                  ),
                  ),
              ),
            ),

            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff118B50),
                    shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: Color(0xff118B50), width: 1),
                    elevation: 3,
                    
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreSurvey5())
                    );
                  }, 
                    child: Text(
                    '생략할게요',
                      style: TextStyle(
                      fontFamily: 'PretendartVariable',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                
                    ),
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