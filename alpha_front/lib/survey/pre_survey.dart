import 'package:alpha_front/survey/pre_survey2.dart';
import 'package:flutter/material.dart';

class Survey extends StatefulWidget {
  const Survey({super.key});

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  int selectedGender = 0; 
  List<int> selectedDish = [];
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
                  '김유진님에 대해 \n알려주세요!',
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
                  hintText: '나이를 입력해주세요.',
                  hintStyle: TextStyle(
                    fontFamily: 'PretendartVariable',
                  ),
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

            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Text(
                '성별',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'yg-jalnan',
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedGender == 1 ? Color(0xff118B50) : Colors.white,
                    shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: Color(0xff118B50), width: 1),
                    elevation: 3,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedGender = 1;
                    });
                  }, 
                  child: Text(
                    '여자',
                    style: TextStyle(
                      fontFamily: 'PretendartVariable',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: selectedGender == 1 ? Colors.white : Color(0xff118B50),

                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedGender == 2 ? Color(0xff118B50) : Colors.white,                    
                    shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: Color(0xff118B50), width: 1),
                    elevation: 3,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedGender = 2;
                    });
                  }, 
                  child: Text(
                    '남자',
                    style: TextStyle(
                      fontFamily: 'PretendartVariable',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: selectedGender == 2 ? Colors.white : Color(0xff118B50),

                    ),
                  ),
                ),
                ],  
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: TextField(
                keyboardType : TextInputType.number,
                decoration: InputDecoration(
                  hintText: '체중을 입력해주세요.',
                  hintStyle: TextStyle(
                    fontFamily: 'PretendartVariable',
                  ),
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

            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Text(
                '하루 섭취 끼니 수',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'yg-jalnan',
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedDish.contains(1) ? Color(0xff118B50) : Colors.white,
                    shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: Color(0xff118B50), width: 1),
                    elevation: 3,
                  ),
                  onPressed: () {
                    setState(() {
                      if (selectedDish.contains(1)) {
                        // 이미 선택된 상태이면 리스트에서 제거
                        selectedDish.remove(1);
                      } else {
                        // 선택되지 않은 상태이면 리스트에 추가
                        selectedDish.add(1);
                      }
                    }); 
                  }, 
                  child: Text(
                    '아침',
                    style: TextStyle(
                      fontFamily: 'PretendartVariable',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: selectedDish.contains(1) ? Colors.white : Color(0xff118B50),

                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedDish.contains(2)? Color(0xff118B50) : Colors.white,                    
                    shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: Color(0xff118B50), width: 1),
                    elevation: 3,
                  ),
                  onPressed: () {
                    setState(() {
                      if (selectedDish.contains(2)) {
                        // 이미 선택된 상태이면 리스트에서 제거
                        selectedDish.remove(2);
                      } else {
                        // 선택되지 않은 상태이면 리스트에 추가
                        selectedDish.add(2);
                      }
                    });
                  }, 
                  child: Text(
                    '점심',
                    style: TextStyle(
                      fontFamily: 'PretendartVariable',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: selectedDish.contains(2) ? Colors.white : Color(0xff118B50),

                    ),
                  ),
                ),
                ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedDish.contains(3) ? Color(0xff118B50) : Colors.white,
                        shape : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(color: Color(0xff118B50), width: 1),
                        elevation: 3,
                      ),
                      onPressed: () {
                        setState(() {
                          if (selectedDish.contains(3)) {
                            // 이미 선택된 상태이면 리스트에서 제거
                            selectedDish.remove(3);
                          } else {
                            // 선택되지 않은 상태이면 리스트에 추가
                            selectedDish.add(3);
                          }
                        });
                      }, 
                      child: Text(
                        '저녁',
                        style: TextStyle(
                          fontFamily: 'PretendartVariable',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: selectedDish.contains(3) ? Colors.white : Color(0xff118B50),

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
                        builder: (context) => PreSurvey2())
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
          ],
          

        ),
      ),
    );
  }
}