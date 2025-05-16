import 'package:alpha_front/survey/pre_survey2.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class PreSurvey1 extends StatefulWidget {
  const PreSurvey1({super.key});

  @override
  State<PreSurvey1> createState() => _PreSurvey1State();
}

class _PreSurvey1State extends State<PreSurvey1> {
  int selectedGender = 0; 
  List<int> selectedDish = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(33, 78, 33, 31),
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
                 child: Text.rich(
                    TextSpan(
                      text: '김유진님',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: 'Pretendard-bold'),
                      children: [
                        TextSpan(
                          text: '에 대해 \n알려주세요!',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: TextField(
                keyboardType : TextInputType.number,
                decoration: InputDecoration(
                  hintText: '체중',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),

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

            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Text(
                '하루 섭취 끼니 수',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontFamily: 'Pretendard-bold'),

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedDish.contains(1) ? Color(0xff3CB196) : Colors.white,
                    shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: Color(0xff3CB196), width: 1),
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Pretendard-bold',
                      color: selectedDish.contains(1) ? Colors.white : Color(0xff3CB196),

                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedDish.contains(2)? Color(0xff3CB196) : Colors.white,                    
                    shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: Color(0xff3CB196), width: 1),
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Pretendard-bold',
                      color: selectedDish.contains(2) ? Colors.white : Color(0xff3CB196),

                    ),
                  ),
                ),
                ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedDish.contains(3) ? Color(0xff3CB196) : Colors.white,
                        shape : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(color: Color(0xff3CB196), width: 1),
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Pretendard-bold',
                          color: selectedDish.contains(3) ? Colors.white : Color(0xff3CB196),

                        ),
                      ),
                    ),
                ],
            ),
              SizedBox(height: 150,),
              Center(
                child: Container(
                  // margin: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                  width: double.infinity,
                  child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3CB196),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    minimumSize: const Size(double.infinity, 50),
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
                        style: Theme.of(context).textTheme.labelMedium,

                  ),
                  ),
              ),
            ),

            // Center(
            //   child: Container(
            //     padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
            //     width: double.infinity,
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Color(0xff3CB196),
            //         shape : RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(15),
            //         ),
            //         side: BorderSide(color: Color(0xff3CB196), width: 1),
            //         elevation: 3,
                    
            //       ),
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => PreSurvey2())
            //         );
            //       }, 
            //         child: Text(
            //         '생략할게요',
            //           style: TextStyle(
            //           fontFamily: 'PretendartVariable',
            //           fontSize: 15,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white,
                
            //         ),
            //       ),
            //       ),
            //   ),
            // ),
          ],
          

        ),
      ),
    );
  }
}