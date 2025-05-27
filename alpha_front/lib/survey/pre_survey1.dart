import 'package:alpha_front/survey/diet_info.dart';
import 'package:alpha_front/survey/pre_survey2.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class PreSurvey1 extends StatefulWidget {
  const PreSurvey1({super.key});

  @override
  State<PreSurvey1> createState() => _PreSurvey1State();
}

class _PreSurvey1State extends State<PreSurvey1> {
  List<String> meal_count = [];
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  final Map<String, String> mealNameMap = {
    '아침': 'BREAKFAST',
    '점심': 'LUNCH',
    '저녁': 'DINNER',
  };

  void _goToNext() {
    double height = double.tryParse(heightController.text.trim()) ?? 0.0;
    double weight = double.tryParse(weightController.text.trim()) ?? 0.0;

    DietInfo.height = height;
    DietInfo.weight = weight;
    DietInfo.mealCount = meal_count;

    print('Height 저장됨: ${DietInfo.height}');
    print('Weight 저장됨: ${DietInfo.weight}');
    print('MealCount 저장됨: ${DietInfo.mealCount}');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PreSurvey2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

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
          padding: const EdgeInsets.fromLTRB(33, 78, 33, 31),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.2,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text.rich(
                    TextSpan(
                      text: '회원님',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontFamily: 'Pretendard-bold', color: Colors.white),
                      children: [
                        TextSpan(
                          text: '에 대해 \n알려주세요!',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildInputField(weightController, '체중'),
              _buildInputField(heightController, '키'),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  '하루 섭취 끼니 수',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontFamily: 'Pretendard-bold', color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMealButton('아침'),
                  _buildMealButton('점심'),
                  _buildMealButton('저녁'),
                ],
              ),
              const SizedBox(height: 50),
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
                    onPressed: _goToNext,
                    child: Text(
                      '다음',
                      style: Theme.of(context).textTheme.labelMedium!
                      .copyWith(color: Color(0xff3CB196))                      ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hintText) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: TextField(
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffffffff)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffffffff)),
          ),
        ),
      ),
    );
  }

  Widget _buildMealButton(String mealNameKor) {
    final String mealKey = mealNameMap[mealNameKor]!;
    final bool isSelected = meal_count.contains(mealKey);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        backgroundColor:
            isSelected ? const Color(0xff3CB196) : const Color(0xffECF8F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
      ),
      onPressed: () {
        setState(() {
          if (isSelected) {
            meal_count.remove(mealKey);
          } else {
            meal_count.add(mealKey);
          }
        });
      },
      child: Text(
        mealNameKor,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontFamily: 'Pretendard-bold',
              color: isSelected ? Colors.white : const Color(0xff3CB196),
            ),
      ),
    );
  }
}
