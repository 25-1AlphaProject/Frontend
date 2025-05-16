
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:alpha_front/widgets/bottom_nav_bar.dart';
import 'package:alpha_front/widgets/foodIngredient.dart';
import 'package:alpha_front/widgets/RecipeStep.dart';
import 'package:flutter/material.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({super.key});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
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
//       appBar: const BaseAppbar(title: '레시피'),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: const Image(
              image: AssetImage(
                // image 변경 - url => network
                'alpha_front/assets/images/example_recipe.png',
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.5,
            maxChildSize: 1.0,
            builder: (context, ScrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  controller: ScrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          '닭가슴살 야채 볶음밥',
                          style: TextStyle(
                            fontFamily: "PretendardVariable",
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 0, 1.0),
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '15분 이내', // 값 받아오기
                            style: TextStyle(
                              fontFamily: "PretendardVariable",
                              fontWeight: FontWeight.normal,
                              color: Color.fromRGBO(154, 154, 154, 1.0),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 27),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '재료',
                            style: TextStyle(
                              fontFamily: "PretendardVariable",
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '1인 기준',
                            style: TextStyle(
                              fontFamily: "PretendardVariable",
                              color: Color.fromRGBO(60, 177, 150, 1.0),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '318 kcal', //값 받아오기
                            style: TextStyle(
                              fontFamily: "PretendardVariable",
                              color: Color.fromRGBO(60, 177, 150, 1.0),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(
                        height: 110,
                        color: Color.fromRGBO(174, 174, 174, 1.0),
                        thickness: 2,
                      ),
                      const Column(
                        children: [
                          FoodIngredient(
                            foodName: '밥',
                            foodUnit: '1인분',
                          ),
                          FoodIngredient(
                            foodName: '닭가슴살',
                            foodUnit: '150g',
                          ),
                          FoodIngredient(
                            foodName: '당근',
                            foodUnit: '1/4개',
                          )
                        ],
                      ),
                      RecipeStep(stepCOUNT: 1, text: steps[0]),
                      const SizedBox(height: 60),
                      RecipeStep(stepCOUNT: 2, text: steps[1]),
                      const SizedBox(height: 60),
                      RecipeStep(stepCOUNT: 3, text: steps[2]),
                      const SizedBox(height: 60),
                      RecipeStep(stepCOUNT: 10, text: steps[3]),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
//       body: Container(
//         width: double.infinity,
//         height: MediaQuery.of(context).size.height * 0.35,
//         child: Stack(
//           children: [
//             Image(
//               image : AssetImage( // image 변경 - url => network
//                 'alpha_front/assets/images/example_recipe.png',
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               height: 200, // 임의 설정
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15),
//                   topRight: Radius.circular(15)
//                 )
//               ),
//             )
//           ],
//         )
//       ),
    );
  }
}
