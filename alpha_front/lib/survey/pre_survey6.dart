import 'package:flutter/material.dart';

class PreSurvey6 extends StatefulWidget {
  const PreSurvey6({super.key});

  @override
  State<PreSurvey6> createState() => _PreSurvey6State();
}

class _PreSurvey6State extends State<PreSurvey6> {
    List<int> selectedGoal = [];
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedGoal.contains(1) ? Color(0xff118B50) : Colors.white,
                        shape : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(color: Color(0xff118B50), width: 1),
                        elevation: 3,
                      ),
                      onPressed: () {
                        setState(() {
                          if (selectedGoal.contains(1)) {
                            // 이미 선택된 상태이면 리스트에서 제거
                            selectedGoal.remove(1);
                          } else {
                            // 선택되지 않은 상태이면 리스트에 추가
                            selectedGoal.add(1);
                          }
                        }); 
                      }, 
                      child: Text(
                        '다이어트',
                        style: TextStyle(
                          fontFamily: 'PretendartVariable',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: selectedGoal.contains(1) ? Colors.white : Color(0xff118B50),
                
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedGoal.contains(2)? Color(0xff118B50) : Colors.white,                    
                        shape : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(color: Color(0xff118B50), width: 1),
                        elevation: 3,
                      ),
                      onPressed: () {
                        setState(() {
                          if (selectedGoal.contains(2)) {
                            // 이미 선택된 상태이면 리스트에서 제거
                            selectedGoal.remove(2);
                          } else {
                            // 선택되지 않은 상태이면 리스트에 추가
                            selectedGoal.add(2);
                          }
                        });
                      }, 
                      child: Text(
                        '질환관리',
                        style: TextStyle(
                          fontFamily: 'PretendartVariable',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: selectedGoal.contains(2) ? Colors.white : Color(0xff118B50),
                
                        ),
                      ),
                    ),
                    
                    Row(
                      children: [
                        ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedGoal.contains(3) ? Color(0xff118B50) : Colors.white,
                                shape : RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                side: BorderSide(color: Color(0xff118B50), width: 1),
                                elevation: 3,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedGoal.contains(3)) {
                                    // 이미 선택된 상태이면 리스트에서 제거
                                    selectedGoal.remove(3);
                                  } else {
                                    // 선택되지 않은 상태이면 리스트에 추가
                                    selectedGoal.add(3);
                                  }
                                });
                              }, 
                              child: Text(
                                '잘 모르겠음',
                                style: TextStyle(
                                  fontFamily: 'PretendartVariable',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: selectedGoal.contains(3) ? Colors.white : Color(0xff118B50),
                        
                                ),
                              ),
                            ),
                        ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedGoal.contains(4) ? Color(0xff118B50) : Colors.white,
                                shape : RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                side: BorderSide(color: Color(0xff118B50), width: 1),
                                elevation: 3,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedGoal.contains(4)) {
                                    // 이미 선택된 상태이면 리스트에서 제거
                                    selectedGoal.remove(4);
                                  } else {
                                    // 선택되지 않은 상태이면 리스트에 추가
                                    selectedGoal.add(4);
                                  }
                                });
                              }, 
                              child: Text(
                                '식습관 개선',
                                style: TextStyle(
                                  fontFamily: 'PretendartVariable',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: selectedGoal.contains(4) ? Colors.white : Color(0xff118B50),
                        
                                ),
                              ),
                            ),
                      ],
                    ),
                    ],
                ),
                            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PreSurvey4())
                    // );
                    print("home");
                  }, 
                    child: Text(
                    '작성 완료',
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
              ],
              
            ),
     
      )
    );
  }
}