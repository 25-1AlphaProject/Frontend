import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:alpha_front/widgets/bottom_nav_bar.dart';
import 'package:alpha_front/widgets/foodIngredient.dart';
import 'package:alpha_front/widgets/RecipeStep.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/services/api_service.dart';

class RecipeDetail extends StatefulWidget {
  late Map<String, dynamic> recipeData;
  RecipeDetail({
    super.key,
    required this.recipeData,
  });

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  late int id;
  late String name;
  late List<String> recipeList;
  late String calories;
  late String foodImage;
  late List<String> ingredient;
  late List<Map<String, String>> parsedIngredients;
  late List<String> ingredientName;
  late List<String> ingredientAmount;

  String? imageUrl;
  late List<Map<String, String>> linkedIngredients;

  @override
  void initState() {
    super.initState();
    id = widget.recipeData["id"];
    name = widget.recipeData["name"];
    recipeList = List<String>.from(widget.recipeData["recipeTexts"]);
    calories = widget.recipeData["calories"].toString();
    foodImage = widget.recipeData["foodImage"];
    linkedIngredients = [];

    String rawIngredient = widget.recipeData["ingredient"];
    rawIngredient = rawIngredient.replaceFirst('재료 ', '');

    List<String> tokens = rawIngredient
        .replaceAll('\n', ',')
        // .replaceAll(',', ',')
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    ingredientName = [];
    ingredientAmount = [];

    for (var token in tokens) {
      if (RegExp(r'^\d+g$').hasMatch(token)) {
        ingredientAmount.add(token);
      } else {
        ingredientName.add(token);
      }
    }

    loadImage(foodImage);
    loadIngredient(id);
  }

  Future<void> loadImage(String imagePath) async {
    try {
      final result = await ApiService.getImage(imagePath);
      setState(() {
        imageUrl = result;
      });
    } catch (e) {
      debugPrint('이미지 불러오기 실패: $e');
    }
  }

  Future<void> loadIngredient(int recipeId) async {
    try {
      final result = await ApiService.linksIngredient(recipeId);
      final List<Map<String, String>> parsed = [];

      if (result != null && result['message'] != null) {
        for (var item in result['message']) {
          parsed.add({
            'ingredient': item['ingredient'],
            'link': item['link'],
          });
        }
      }

      setState(() {
        linkedIngredients = parsed;
      });
    } catch (e) {
      debugPrint('재료 링크 불러오기 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppbar(),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: imageUrl == null
                ? Image.asset('../assets/images/character.png',
                    width: 50, height: 50, fit: BoxFit.cover)
                : Image.network(imageUrl!,
                    width: 50, height: 50, fit: BoxFit.cover),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.55,
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
                      Center(
                        child: Text(
                          name,
                          style: const TextStyle(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '재료',
                            style: TextStyle(
                              fontFamily: "PretendardVariable",
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '1인 기준',
                            style: TextStyle(
                              fontFamily: "PretendardVariable",
                              color: Color.fromRGBO(60, 177, 150, 1.0),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$calories kcal', //값 받아오기
                            style: const TextStyle(
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
                      Column(
                        children: List.generate(ingredientName.length, (index) {
                          final name = ingredientName[index];
                          final amount = index < ingredientAmount.length
                              ? ingredientAmount[index]
                              : '';
                          final link = linkedIngredients.firstWhere(
                            (item) {
                              final linkedName = item['ingredient'] ?? '';
                              return linkedName.contains(name) ||
                                  name.contains(linkedName);
                            },
                            orElse: () => {'link': ''},
                          )['link'];

                          return FoodIngredient(
                            foodName: name,
                            foodUnit: amount,
                            url: link ?? '',
                          );
                        }),
                      ),
                      Column(
                        children: recipeList.map((recipe) {
                          // 정규식으로 숫자 추출
                          final match =
                              RegExp(r'^(\d+)\.\s*(.*)').firstMatch(recipe);
                          final stepCount =
                              match != null ? int.parse(match.group(1)!) : 0;
                          final text = match != null ? match.group(2)! : recipe;

                          return Column(
                            children: [
                              RecipeStep(
                                stepCOUNT: stepCount,
                                text: text,
                              ),
                              const SizedBox(height: 60),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
