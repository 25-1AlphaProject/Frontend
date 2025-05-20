import 'package:alpha_front/survey/diet_info.dart';
import 'package:alpha_front/survey/pre_survey6.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class PreSurvey5 extends StatefulWidget {
  const PreSurvey5({super.key});

  @override
  State<PreSurvey5> createState() => _PreSurvey5State();
}

class _PreSurvey5State extends State<PreSurvey5> {

  final TextEditingController targetCaloriesController = TextEditingController();

  void _goToNext() {
    int target_calories = int.tryParse(targetCaloriesController.text.trim()) ?? 0;
      
    DietInfo.targetCalories = target_calories;

    print('targetCalories 저장됨: ${DietInfo.targetCalories}');


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreSurvey6()),
    );
  }

  void _skip() {
    DietInfo.targetCalories = 0;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreSurvey6()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: BaseAppbar(),
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
                      text: '한 끼 희망 칼로리',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: 'Pretendard-bold'),
                      children: [
                        TextSpan(
                          text: '를\n알려주세요!',
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
                controller: targetCaloriesController,
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType : TextInputType.number,
                decoration: InputDecoration(
                  hintText: '칼로리',
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

            Center(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green[50],

                ),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(
                        '../assets/images/character.png'
                        )
                      ),
                    Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '계산식\n',
                                style: TextStyle(fontFamily: 'PretendardVariable', fontSize: 11,fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '체중(kg)x24x활동계수=하루 섭취량\n남자\n66.47+(13.75x체중)+(5x키)-(6.76x나이)\n여자\n655.1+(9.56x체중)+(1.85x키)-(4.68x나이)\n',
                                style: TextStyle(fontFamily: 'PretendardVariable', fontSize: 11,fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: '활동계수\n',
                                style: TextStyle(fontFamily: 'PretendardVariable', fontSize: 11,fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '좌식 생활자 : 1.2\n회사원 : 1.5\n노동 강도 높은 사람 : 1.7\n을 활동계수에 넣습니다.',
                                style: TextStyle(fontFamily: 'PretendardVariable', fontSize: 11,fontWeight: FontWeight.w500),
                              )
                            ]
                            )
                        )
                      ],
                    ),
                  ],
                )
              ),
            ),

              SizedBox(height: 100,),
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
                              builder: (context) => PreSurvey6())
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
                        onPressed: _goToNext,
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