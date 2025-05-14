import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:alpha_front/widgets/RecipeStep.dart';
import 'package:alpha_front/recipe/recipe_detail.dart';

class recipeDescriptionScreen extends StatefulWidget {
  const recipeDescriptionScreen({super.key});

  @override
  _recipeDescriptionScreenState createState() =>
      _recipeDescriptionScreenState();
}

class _recipeDescriptionScreenState extends State<recipeDescriptionScreen> {
  List<String> steps = [
    "닭가슴살은 소금을 조금 넣고 익혀주세요.",
    "당근과 피망, 양파 닭가슴살은 적당히 잘게 잘라서 준비하세요.",
    "익은 닭가슴살은 먹기 좋게 잘라둡니다.",
    "팬에 양파를 먼저 볶아줍니다.",
    "당근과 피망을 넣어 볶아주세요.",
    "익힌 닭가슴살도 넣고 볶아줍니다.",
    "밥을 넣고 고슬고슬하게 볶아주면 완성!     간은 소금으로 맞춰주세요."
  ]; // 한 번에 받아와서 리스트에 저장

  String recipeName = '닭가슴살 야채 볶음밥'; //받아오기
  int currentStep = 0; //터치하거나 시간 지날 때마다 카운팅

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ////// 앱바 수정 필요
      // appBar: const BaseAppbar(
      //   title: '김치볶음밥',
      //   titleAlign: TextAlign.left,
      //   titleStyle: TextStyle(
      //     fontFamily: "PretendardVariable",
      //     fontWeight: FontWeight.normal,
      //     color: Color.fromRGBO(123, 123, 123, 1.0),
      //     fontSize: 15,
      //   ),
      // ),
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => const RecipeDetail()),
      //         );
      //       },
      //       icon: const Icon(
      //         Icons.arrow_back_rounded,
      //         color:
      //             Color.from(alpha: 1, red: 0.482, green: 0.482, blue: 0.482),
      //         size: 25,
      //       )),
      //   title: Text(
      //     recipeName,
      //     style: const TextStyle(
      //       fontFamily: "PretenderardVariable",
      //       fontWeight: FontWeight.normal,
      //       color: Color.fromRGBO(123, 123, 123, 1.0),
      //       fontSize: 15,
      //     ),
      //   ),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressBar(
            maxSteps: steps.length,
            progressType: LinearProgressBar.progressTypeLinear,
            currentStep: 2,
            progressColor: const Color.fromRGBO(60, 177, 150, 1.0),
            backgroundColor: const Color.fromRGBO(241, 241, 241, 1.0),
            borderRadius: BorderRadius.circular(0),
          ),
          // Image.asset(name)
          // const SizedBox(height: 28,),
          Column(
            children: [
              RecipeStep(stepCOUNT: 1, text: steps[0]),
              RecipeStep(stepCOUNT: 2, text: steps[1]),
              RecipeStep(stepCOUNT: 3, text: steps[2]),
              RecipeStep(stepCOUNT: 10, text: steps[3]),
            ],
          ),
        ],
      ),
    );
  }
}
