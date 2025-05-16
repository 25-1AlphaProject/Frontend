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

  void _goToNext() {
    double height = double.tryParse(heightController.text.trim()) ?? 0.0;
    double weight = double.tryParse(weightController.text.trim()) ?? 0.0;

    DietInfo.height = height;
    DietInfo.weight = weight;
    DietInfo.mealCount = meal_count;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PreSurvey2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

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
                height: screenHeight * 0.2,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text.rich(
                    TextSpan(
                      text: '회원님',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontFamily: 'Pretendard-bold'),
                      children: [
                        TextSpan(
                          text: '에 대해 \n알려주세요!',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: TextField(
                  controller: weightController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '체중',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: const Color(0xffb6b6b6)),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff000000)),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff3CB196)),
                    ),
                  ),
                  onChanged: (value) {
                    final weight = double.tryParse(value);
                    DietInfo.weight = weight ?? 0.0;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: TextField(
                  controller: heightController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '키',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: const Color(0xffb6b6b6)),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff000000)),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff3CB196)),
                    ),
                  ),
                  onChanged: (value) {
                    final height = double.tryParse(value);
                    DietInfo.height = height ?? 0.0;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  '하루 섭취 끼니 수',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontFamily: 'Pretendard-bold'),
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
                      backgroundColor: const Color(0xff3CB196),
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
      ),
    );
  }

  Widget _buildMealButton(String mealName) {
    final bool isSelected = meal_count.contains(mealName);
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
            meal_count.remove(mealName);
          } else {
            meal_count.add(mealName);
          }
        });
      },
      child: Text(
        mealName,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontFamily: 'Pretendard-bold',
              color: isSelected ? Colors.white : const Color(0xff3CB196),
            ),
      ),
    );
  }
}
