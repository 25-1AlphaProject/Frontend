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

            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: TextField(
                keyboardType : TextInputType.number,
                decoration: InputDecoration(
                  hintText: '칼로리',
                  enabledBorder : UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff000000),
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff3CB196),
                    ),  
                  ),
                ), 
              ),
            ),

            Center(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green[50],

                ),
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '계산식\n',
                            style: TextStyle(fontFamily: 'PretendardVariable', fontSize: 15,fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '체중(kg) x 24 x 활동계수 = 하루 섭취량\n남자: 66.47 + (13.75 x 체중) + (5 x 키) - (6.76 x 나이)\n여자: 655.1 + (9.56 x 체중) + (1.85 x 키) - (4.68 x 나이)\n',
                            style: TextStyle(fontFamily: 'PretendardVariable', fontSize: 15,fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: '활동계수\n',
                            style: TextStyle(fontFamily: 'PretendardVariable', fontSize: 15,fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '좌식 생활자 : 1.2\n회사원 : 1.5\n노동 강도 높은 사람 : 1.7\n을 활동계수에 넣습니다.',
                            style: TextStyle(fontFamily: 'PretendardVariable', fontSize: 15,fontWeight: FontWeight.w500),
                          )
                        ]
                        )
                    )
                  ],
                )
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
                    side: BorderSide(color: Color(0xff3CB196), width: 1),
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
                      color: Color(0xff3CB196),
                
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
                    backgroundColor: Color(0xff3CB196),
                    shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: Color(0xff3CB196), width: 1),
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