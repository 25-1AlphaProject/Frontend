import 'package:alpha_front/survey/pre_survey_final.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class PreSurvey6 extends StatefulWidget {
  const PreSurvey6({super.key});

  @override
  State<PreSurvey6> createState() => _PreSurvey6State();
}

class _PreSurvey6State extends State<PreSurvey6> {
  int selectedGoal = 0;
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
                      text: '김유진',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: 'Pretendard-bold'),
                      children: [
                        TextSpan(
                          text: '님의\n',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextSpan(
                          text: '건강목표',
                        ),
                       TextSpan(
                          text: '를 알려주세요!',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  )
              ),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedGoal == 1 ? Color(0xff3CB196) : Colors.white,
                      shape : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide(color: Color(0xff3CB196), width: 1),
                      elevation: 3,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedGoal = 1;
                      }); 
                    }, 
                    child: Text(
                      '다이어트',
                      style: TextStyle(
                        fontFamily: 'PretendartVariable',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: selectedGoal == 1 ? Colors.white : Color(0xff3CB196),
              
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedGoal == 2? Color(0xff3CB196) : Colors.white,                    
                      shape : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide(color: Color(0xff3CB196), width: 1),
                      elevation: 3,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedGoal = 2;
                      });
                    }, 
                    child: Text(
                      '질환관리',
                      style: TextStyle(
                        fontFamily: 'PretendartVariable',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: selectedGoal == 2 ? Colors.white : Color(0xff3CB196),
              
                      ),
                    ),
                  ),
                ],
                ),
                SizedBox(height: 16),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  
                    ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedGoal == 3 ? Color(0xff3CB196) : Colors.white,
                            shape : RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            side: BorderSide(color: Color(0xff3CB196), width: 1),
                            elevation: 3,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedGoal = 3;
                            });
                          }, 
                          child: Text(
                            '잘 모르겠음',
                            style: TextStyle(
                              fontFamily: 'PretendartVariable',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: selectedGoal == 3 ? Colors.white : Color(0xff3CB196),
                    
                            ),
                          ),
                        ),
                  
                    ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedGoal == 4 ? Color(0xff3CB196) : Colors.white,
                            shape : RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            side: BorderSide(color: Color(0xff3CB196), width: 1),
                            elevation: 3,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedGoal = 4;
                            });
                          }, 
                          child: Text(
                            '식습관 개선',
                            style: TextStyle(
                              fontFamily: 'PretendartVariable',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: selectedGoal == 4 ? Colors.white : Color(0xff3CB196),
                    
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
                  builder: (context) => PreSurveyFinal())
              );
            }, 
              child: Text(
              '작성 완료',
              style: Theme.of(context).textTheme.labelMedium,

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