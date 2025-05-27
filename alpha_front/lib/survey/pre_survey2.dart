import 'package:alpha_front/survey/diet_info.dart';
import 'package:alpha_front/survey/pre_survey3.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class PreSurvey2 extends StatefulWidget {
  const PreSurvey2({super.key});

  @override
  State<PreSurvey2> createState() => _PreSurvey2State();
}

class _PreSurvey2State extends State<PreSurvey2> {
  TextEditingController searchController = TextEditingController();

  List<String> selectedAllergy = [];


  void _addAllergy(String input) {
    if (input.isEmpty) return;
    
    List<String> terms = input
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    
    setState(() {
      for (var term in terms) {
        if (!selectedAllergy.contains(term)) {
          selectedAllergy.add(term);
        }
      }
    });
    
    searchController.clear();
  }

  void _removeAllergy(String term) {
    setState(() {
      selectedAllergy.remove(term);
    });
  }

  void _goToNext() {
    DietInfo.allergies = selectedAllergy;

    print('allergy 저장됨: ${DietInfo.allergies}');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreSurvey3()),
    );
  }

  void _skip() {
    DietInfo.allergies = [];
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreSurvey3()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF3CB196),
            Color(0xFF8ED1C1),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: BaseAppbar(),
        body: Padding(
          padding: EdgeInsets.fromLTRB(33, 78, 33, 31),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text.rich(
                        TextSpan(
                          text: '앓고 계신 ',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith( color: Colors.white),
                          children: [
                            TextSpan(
                              text: '식품 관련 \n알레르기 ',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: 'Pretendard-bold', color: Colors.white),
                            ),
                            TextSpan(
                              text: '질환이 있나요?',
                            ),
                          ],
                        ),
                      )
                  ),
                ),
          
               TextField(
                style: Theme.of(context).textTheme.bodyMedium,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "알러지 검색",
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffffffff)),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffffffff)),
                  ),
                ),
                onSubmitted: _addAllergy,
              ),
              SizedBox(height: 20),
          
                Wrap(
                  spacing: 8.0,
                  children: selectedAllergy.map((term) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color:Colors.white),
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
          
                  SizedBox(height: 150,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            // margin: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                            width: double.infinity,
                            child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffd9d9d9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              minimumSize: const Size(double.infinity, 50),
                              elevation: 3,
                              ),
                            onPressed: _skip,
                              child: Text(
                              '생략할게요',
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Color(0xff4d4d4d)),
                        
                            ),
                            ),
                        )
                      ),
                      SizedBox(width: 14,),
                      Expanded(
                        flex: 2,
                          child: Container(
                            // margin: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                            width: double.infinity,
                            child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffffffff),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              minimumSize: const Size(double.infinity, 50),
                              elevation: 3,
                              ),
                            onPressed: _goToNext,
                              child: Text(
                              '다음',
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Color(0xff3CB196),
                                  )
                              ),
                            ),
                        ),
                      ),
                    ],
                  ),
              ]
              
            ),
        )
      ),
    );
  }
}