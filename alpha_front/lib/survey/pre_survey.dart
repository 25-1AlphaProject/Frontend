import 'package:alpha_front/survey/pre_survey1.dart';
import 'package:alpha_front/survey/pre_survey2.dart';
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
      body: Container(
        padding: const EdgeInsets.fromLTRB(31, 78, 31, 31),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '김유진님에 대해 \n알려주세요!',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'yg-jalnan',
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '나이를 입력해주세요.',
                  hintStyle: TextStyle(
                    fontFamily: 'PretendartVariable',
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xff000000),
                  )),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff118B50),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: const Text(
                '성별',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'PretendartVariable',
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedGender == 1
                        ? const Color(0xff118B50)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: const BorderSide(color: Color(0xff118B50), width: 1),
                    elevation: 3,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedGender = 1;
                    });
                  },
                  child: Text(
                    '여자',
                    style: TextStyle(
                      fontFamily: 'PretendartVariable',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: selectedGender == 1
                          ? Colors.white
                          : const Color(0xff118B50),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedGender == 2
                        ? const Color(0xff118B50)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: const BorderSide(color: Color(0xff118B50), width: 1),
                    elevation: 3,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedGender = 2;
                    });
                  },
                  child: Text(
                    '남자',
                    style: TextStyle(
                      fontFamily: 'PretendartVariable',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: selectedGender == 2
                          ? Colors.white
                          : const Color(0xff118B50),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: const BorderSide(color: Color(0xff118B50), width: 1),
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PreSurvey1()));
                  },
                  child: const Text(
                    '다음',
                    style: TextStyle(
                      fontFamily: 'PretendartVariable',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff118B50),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
