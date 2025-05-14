import 'package:alpha_front/survey/pre_survey4.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
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
                      text: '선호 ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: 'Pretendard-bold'),
                      children: [
                        TextSpan(
                          text: '혹은 ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextSpan(
                          text: '기피 식품'
                        ),
                        TextSpan(
                          text: '이 \n있으신가요?',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                  )
              ),
            ),

           TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "선호 식품 검색",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),
                border: UnderlineInputBorder(
                ),
              ),
              onSubmitted: _addLikeFood,
            ),
            SizedBox(height: 20),

            Wrap(
              spacing: 8.0,
              children: selectedLikeFood.map((term) => ElevatedButton(
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
          //                 backgroundColor: selectedLikeFood.contains(k) ? Color(0xff3CB196) : Colors.white,
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PreSurvey4())
                          );
                        }, 
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
                              builder: (context) => PreSurvey4())
                          );
                        }, 
                          child: Text(
                          '다음',
                              style: Theme.of(context).textTheme.labelMedium,
                    
                        ),
                        ),
                    ),
                  ),
                ],
              ),
          ]
          
        )
      )
    );
  }
}