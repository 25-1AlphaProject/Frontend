// 질문 글씨 굵기 다르게 / 작성된 글씨 색상 조절

import 'package:alpha_front/survey/pre_survey1.dart';
import 'package:alpha_front/survey/pre_survey2.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class Survey extends StatefulWidget {
  const Survey({super.key});

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  int selectedGender = 0;
  List<int> selectedDish = [];
  String name = '김유진';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseAppbar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(33, 78, 33, 31),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          // decoration: const BoxDecoration(color: Colors.white),
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
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '나이',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),

                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff000000),
                    )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff3CB196),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Text(
                  '성별',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontFamily: 'Pretendard-bold'),

                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedGender == 1
                          ? const Color(0xff3CB196)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: const BorderSide(color: Color(0xff3CB196), width: 1),
                      elevation: 3,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedGender = 1;
                      });
                    },
                    child: Text(
                      '여자',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Pretendard-bold',
                        color: selectedGender == 1
                            ? Colors.white
                            : const Color(0xff3CB196),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedGender == 2
                          ? const Color(0xff3CB196)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: const BorderSide(color: Color(0xff3CB196), width: 1),
                      elevation: 3,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedGender = 2;
                      });
                    },
                    child: Text(
                      '남자',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Pretendard-bold',
                        color: selectedGender == 1
                            ? Colors.white
                            : const Color(0xff3CB196),
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
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    minimumSize: const Size(double.infinity, 50),
                    elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PreSurvey1()));
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
        ),
      ),
    );
  }
}
