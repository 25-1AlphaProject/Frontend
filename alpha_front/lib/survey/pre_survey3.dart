import 'package:alpha_front/survey/pre_survey4.dart';
import 'package:flutter/material.dart';

class PreSurvey3 extends StatefulWidget {
  const PreSurvey3({super.key});

  @override
  State<PreSurvey3> createState() => _PreSurvey3State();
}

class _PreSurvey3State extends State<PreSurvey3> {
  TextEditingController searchController = TextEditingController();

  List<String> selectedLikeFood = [];

  void _addLikeFood(String term) {
    if (term.isNotEmpty && !selectedLikeFood.contains(term)) {
      setState(() {
        selectedLikeFood.add(term);
      });
      searchController.clear();
    }
  }

  void _removeLikeFood(String term) {
    setState(() {
      selectedLikeFood.remove(term);
    });
  }



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
                  '선호 혹은 기피 식품이 \n있으신가요?',
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
                labelText: "선호 식품 검색",
                border: UnderlineInputBorder(
                ),
              ),
              onChanged: (value) {
                setState(() {}); // 검색어가 변경될 때 UI 업데이트
              },
            ),
            SizedBox(height: 20),



            Wrap(
              spacing: 8.0,
              children: selectedLikeFood.map((term) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff118B50), 
                  foregroundColor: Colors.white, 
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(term),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _removeLikeFood(term),
                      child: Icon(Icons.close, color: Colors.white, size: 16),
                    ),
                  ],
                ),
              )).toList(),
            ),
            SizedBox(height: 20),

          //   // 선호 식품 리스트 (검색 결과 기반)
          // if(searchController.text.isNotEmpty)
          //   Wrap(
          //     spacing: 10,
          //     children: allergyMap.keys
          //         .where((k) =>
          //             k.contains(searchController.text) ||
          //             allergyMap[k].toString().contains(searchController.text))
          //         .map((k) => ElevatedButton(
          //               onPressed: () {
          //                 if (!selectedLikeFood.contains(k)) {
          //                   setState(() {
          //                     selectedLikeFood.add(k);
          //                   });
          //                 }
          //               },
          //               style: ElevatedButton.styleFrom(
          //                 backgroundColor: selectedLikeFood.contains(k) ? Color(0xff118B50) : Colors.white,
          //                 foregroundColor: selectedLikeFood.contains(k) ? Colors.white : Colors.black,
          //               ),
          //               child: Text("$k", 
          //               style: TextStyle(
          //                 fontSize: 15,
          //                 fontFamily: 'PretendardVariable',
          //                 fontWeight: FontWeight.bold,
          //                 )),
          //             ))
          //         .toList(),
          //   ),
          //   SizedBox(height: 20),


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
                        builder: (context) => PreSurvey4())
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
                        builder: (context) => PreSurvey4())
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