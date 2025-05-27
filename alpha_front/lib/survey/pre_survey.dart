// 질문 글씨 굵기 다르게 / 작성된 글씨 색상 조절

import 'package:alpha_front/survey/diet_info.dart';
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
  String selectedGender = "";
  final TextEditingController ageController = TextEditingController();

  void _goToNext() {
    DietInfo.gender = selectedGender;
    DietInfo.age = int.tryParse(ageController.text) ?? 0;

    print('gender 저장됨: ${DietInfo.gender}');
    print('age 저장됨: ${DietInfo.age}');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreSurvey1()),
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
        resizeToAvoidBottomInset: false,
        // appBar: BaseAppbar(),
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
                        text: '회원님',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: 'Pretendard-bold', color: Colors.white),
                        children: [
                          TextSpan(
                            text: '에 대해 \n알려주세요!',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: TextField(
                    controller: ageController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '나이',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
      
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
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
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontFamily: 'Pretendard-bold', color: Colors.white),
      
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                        backgroundColor: selectedGender == "F"
                            ? const Color(0xff3CB196)
                            : Color(0xffECF8F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedGender = "F";
                        });
                      },
                      child: Text(
                        '여자',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: 'Pretendard-bold',
                          color: selectedGender == "F"
                              ? Colors.white
                              : const Color(0xff3CB196),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                        backgroundColor: selectedGender == "M"
                            ? const Color(0xff3CB196)
                            : Color(0xffECF8F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedGender = "M";
                        });
                      },
                      child: Text(
                        '남자',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: 'Pretendard-bold',
                          color: selectedGender == "M"
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
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      minimumSize: const Size(double.infinity, 50),
                      elevation: 3,
                      ),
                      onPressed: _goToNext,
                      // () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const PreSurvey1()));
                      // },
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
          ),
        ),
      ),
    );
  }
}
