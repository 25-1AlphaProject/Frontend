import 'package:alpha_front/survey/pre_survey3.dart';
import 'package:flutter/material.dart';

class PreSurvey2 extends StatefulWidget {
  const PreSurvey2({super.key});

  @override
  State<PreSurvey2> createState() => _PreSurvey2State();
}

class _PreSurvey2State extends State<PreSurvey2> {
  TextEditingController searchController = TextEditingController();

  List<String> selectedAllergy = [];

    void _addAllergy(String term) {
    if (term.isNotEmpty && !selectedAllergy.contains(term)) {
      setState(() {
        selectedAllergy.add(term);
      });
      searchController.clear();
    }
  }

  void _removeAllergy(String term) {
    setState(() {
      selectedAllergy.remove(term);
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
                labelText: "알러지 검색",
                border: UnderlineInputBorder(
                ),
              ),
              onSubmitted: _addAllergy,
            ),
            SizedBox(height: 20),

            Wrap(
              spacing: 8.0,
              children: selectedAllergy.map((term) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff3CB196), 
                  foregroundColor: Colors.white, 
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(term),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _removeAllergy(term),
                      child: Icon(Icons.close, color: Colors.white, size: 16),
                    ),
                  ],
                ),
              )).toList(),
            ),
            SizedBox(height: 20),

            // // 선택된 항목 목록 (박스 안)
            // Text("선택된 항목", 
            // style: TextStyle(
            //   fontSize: 15,
            //   color: Color(0xff115B50))),
            // SizedBox(height: 10),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Color(0xff3CB196)),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Wrap(
            //     spacing: 10,
            //     children: selectedAllergy
            //         .map((k) => Chip(
            //               label: Text("$k", 
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontFamily: 'PretendardVariable',
            //                 fontWeight: FontWeight.bold,
            //                 )),
            //               backgroundColor: Color(0xff3CB196),
            //               deleteIcon: Icon(Icons.close, color: Colors.white),
            //               onDeleted: () {
            //                 setState(() {
            //                   selectedAllergy.remove(k);
            //                 });
            //               },
            //             ))
            //         .toList(),
            //   ),
            // ),

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
                        builder: (context) => PreSurvey3())
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