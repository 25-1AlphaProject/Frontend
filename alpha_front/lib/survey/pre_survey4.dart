import 'package:alpha_front/survey/diet_info.dart';
import 'package:alpha_front/survey/pre_survey5.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class PreSurvey4 extends StatefulWidget {
  const PreSurvey4({super.key});

  @override
  State<PreSurvey4> createState() => _PreSurvey4State();
}

class _PreSurvey4State extends State<PreSurvey4> {
  TextEditingController searchController = TextEditingController();

  List<String> selectedDisease = [];

  void _addDisease(String input) {
  if (input.isEmpty) return;

  List<String> terms = input
      .split(',')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  setState(() {
    for (var term in terms) {
      if (!selectedDisease.contains(term)) {
        selectedDisease.add(term);
      }
    }
  });

  searchController.clear();
}

void _removeDisease(String term) {
  setState(() {
    selectedDisease.remove(term);
  });
}

    void _goToNext() {
    DietInfo.diseases = selectedDisease;

  print('disease 저장됨: ${DietInfo.diseases}');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreSurvey5()),
    );
  }

  void _skip() {
    DietInfo.diseases = [];
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreSurvey5()),
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
            const Color(0xFF3CB196),
            const Color(0xFF8ED1C1),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
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
                        text: '식단 관리',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: 'Pretendard-bold', color: Colors.white),
                        children: [
                          TextSpan(
                            text: '가 필요한 \n질환이 있나요?',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                ),
              ),
      
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: '질환명',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffffffff)),
                    enabledBorder : UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffffffff),
                      )
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff3CB196),
                      ),  
                    ),
                  ), 
                  onSubmitted: _addDisease,
                ),
              ),
              SizedBox(height: 20),
      
              Wrap(
                spacing: 8.0,
                children: selectedDisease.map((term) => ElevatedButton(
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
                        onTap: () => _removeDisease(term),
                        child: Icon(Icons.close, color: Colors.white, size: 16),
                      ),
                    ],
                  ),
                )).toList(),
              ),
      
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
                                ),
                      
                          ),
                          ),
                      ),
                    ),
                  ],
                ),
            ]
            
          )
        )
      ),
    );
  }
}


// Row(
//   children: [
//     // 생략 버튼 (빈 리스트 전송)
//     Expanded(
//       flex: 1,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xffd9d9d9),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 18),
//           elevation: 3,
//         ),
//         onPressed: () async {
//           final success = await ApiService.sendDiseases([]);
//           if (success) {
//             print("성공: 질환 없음");
//             if (!mounted) return;
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => PreSurvey5()),
//             );
//           }
//         },
//         child: Text(
//           '생략할게요',
//           style: Theme.of(context)
//               .textTheme
//               .labelMedium!
//               .copyWith(color: Color(0xff4d4d4d)),
//         ),
//       ),
//     ),
//     const SizedBox(width: 14),
    
//     // 다음 버튼 (selectedDisease 전송)
//     Expanded(
//       flex: 2,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xff3CB196),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 18),
//           elevation: 3,
//         ),
//         onPressed: () async {
//           final success = await ApiService.sendDiseases(selectedDisease);
//           if (success) {
//             print("성공: ${selectedDisease.toString()}");
//             if (!mounted) return;
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => PreSurvey5()),
//             );
//           }
//         },
//         child: Text(
//           '다음',
//           style: Theme.of(context).textTheme.labelMedium,
//         ),
//       ),
//     ),
//   ],
// )

