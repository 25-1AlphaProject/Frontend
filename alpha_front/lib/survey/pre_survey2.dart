import 'package:alpha_front/survey/pre_survey3.dart';
import 'package:flutter/material.dart';

class PreSurvey2 extends StatefulWidget {
  const PreSurvey2({super.key});

  @override
  State<PreSurvey2> createState() => _PreSurvey2State();
}

class _PreSurvey2State extends State<PreSurvey2> {
  TextEditingController searchController = TextEditingController();

    Map<String, int> allergyMap = {
    "가": 1,
    "나": 2,
    "다": 3,
    "라": 4,
  };

  List<String> selectedAllergy = [];

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

           TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "알러지 검색 (가~라)",
                border: UnderlineInputBorder(
                ),
              ),
              onChanged: (value) {
                setState(() {}); // 검색어가 변경될 때 UI 업데이트
              },
            ),
            SizedBox(height: 20),

            // 알러지지 리스트 (검색 결과 기반)
            Wrap(
              spacing: 10,
              children: allergyMap.keys
                  .where((k) =>
                      k.contains(searchController.text) ||
                      allergyMap[k].toString().contains(searchController.text))
                  .map((k) => ElevatedButton(
                        onPressed: () {
                          if (!selectedAllergy.contains(k)) {
                            setState(() {
                              selectedAllergy.add(k);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedAllergy.contains(k) ? Color(0xff118B50) : Colors.white,
                          foregroundColor: selectedAllergy.contains(k) ? Colors.white : Colors.black,
                        ),
                        child: Text("$k", 
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'PretendardVariable',
                          fontWeight: FontWeight.bold,
                          )),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),

            // 선택된 항목 목록 (박스 안)
            Text("선택된 항목", 
            style: TextStyle(
              fontSize: 15,
              color: Color(0xff115B50))),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff118B50)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(
                spacing: 10,
                children: selectedAllergy
                    .map((k) => Chip(
                          label: Text("$k", 
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'PretendardVariable',
                            fontWeight: FontWeight.bold,
                            )),
                          backgroundColor: Color(0xff118B50),
                          deleteIcon: Icon(Icons.close, color: Colors.white),
                          onDeleted: () {
                            setState(() {
                              selectedAllergy.remove(k);
                            });
                          },
                        ))
                    .toList(),
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
                        builder: (context) => PreSurvey3())
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
                        builder: (context) => PreSurvey3())
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