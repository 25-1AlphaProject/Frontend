import 'package:alpha_front/survey/diet_info.dart';
import 'package:alpha_front/survey/pre_survey_loading.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class PreSurvey6 extends StatefulWidget {
  const PreSurvey6({super.key});

  @override
  State<PreSurvey6> createState() => _PreSurvey6State();
}

class _PreSurvey6State extends State<PreSurvey6> {
  String selectedGoalKor = '';

  final Map<String, String> goalMap = {
    '다이어트': 'DIET',
    '질환관리': 'DISEASE_MANAGEMENT',
    '식습관 개선': 'HABIT_IMPROVEMENT',
    '잘 모르겠음': 'NOT_SURE',
  };

  void _submitSurvey() async {
    if (goalMap.containsKey(selectedGoalKor)) {
      DietInfo.healthGoal = goalMap[selectedGoalKor]!;
    }

    print('healthgoal 저장됨: ${DietInfo.healthGoal}');

    bool result = await DietInfo.submitToBackend();
    if (result) {
      print("POST 성공: 설문 정보가 서버에 저장되었습니다.");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PreSurveyFinal()),
      );
    } else {
      print("POST 실패: 서버 통신에 실패했습니다.");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('서버에 데이터를 저장하지 못했습니다. '),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildGoalButton(String goalKor) {
    final bool isSelected = selectedGoalKor == goalKor;

    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xff3CB196) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side: const BorderSide(color: Color(0xff3CB196), width: 1),
          elevation: 3,
        ),
        onPressed: () {
          setState(() {
            selectedGoalKor = goalKor;
          });
        },
        child: Text(
          goalKor,
          style: const TextStyle(
            fontFamily: 'Pretendard-bold',
            fontSize: 15,
          ).copyWith(
            color: isSelected ? Colors.white : const Color(0xff3CB196),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3CB196),
            const Color(0xFF8ED1C1),
          ]
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        // appBar: const BaseAppbar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(33, 78, 33, 31),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text.rich(
                    TextSpan(
                      text: '건강목표',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontFamily: 'Pretendard-bold', color: Colors.white),
                      children: [
                        TextSpan(
                          text: '를\n알려주세요!',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildGoalButton('다이어트'),
                  _buildGoalButton('질환관리'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildGoalButton('잘 모르겠음'),
                  _buildGoalButton('식습관 개선'),
                ],
              ),
              const SizedBox(height: 150),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      minimumSize: const Size(double.infinity, 50),
                      elevation: 3,
                    ),
                    onPressed: _submitSurvey,
                    child: Text(
                      '작성 완료',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: const Color(0xff3CB196),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
