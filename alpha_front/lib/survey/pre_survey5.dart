import 'package:alpha_front/survey/pre_survey6.dart';
import 'package:flutter/material.dart';

class PreSurvey5 extends StatefulWidget {
  const PreSurvey5({super.key});

  @override
  State<PreSurvey5> createState() => _PreSurvey5State();
}

class _PreSurvey5State extends State<PreSurvey5> {
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
                  '한 끼당 \n희망 섭취 칼로리 수는?',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'yg-jalnan',
                    fontSize: 30,
                  ),
                ),
              ),
            ),

            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: TextField(
                    keyboardType : TextInputType.number,
                    decoration: InputDecoration(
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
                SizedBox(
                  child: Text(
                    'kcal',
                    style: TextStyle(
                      fontFamily: 'yg-jalnan',
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
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
                        builder: (context) => PreSurvey6())
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
          ]
        )
      )
    );
  }
}