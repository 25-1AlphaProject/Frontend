import 'dart:convert';
import 'package:alpha_front/recipe/recipe_detail.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/services/api_service.dart';

class MypageMyrecipe extends StatefulWidget {
  const MypageMyrecipe({super.key});

  @override
  State<MypageMyrecipe> createState() => _MypageMyrecipeState();
}

class _MypageMyrecipeState extends State<MypageMyrecipe> {
  bool isLoading = true;
  List<dynamic> recipes = [];

  @override
  void initState() {
    super.initState();
    fetchFavoriteRecipes();
  }

  Future<void> fetchFavoriteRecipes() async {
    final result = await ApiService.getRecipeFavorite();
    setState(() {
      recipes = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(33.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff3CB196),
                      ),
                    )
                  : recipes.isEmpty
                      ? const Center(child: Text("좋아요한 레시피가 없습니다."))
                      : ListView.builder(
                          itemCount: recipes.length,
                          itemBuilder: (context, index) {
                            final recipe = recipes[index];
                            final name = recipe['name'] ?? '이름 없음';
                            final calories = (recipe['calories'] != null)
                                ? recipe['calories'].toString()
                                : '0';

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecipeDetail(
                                      recipeData: recipe,
                                    ), // 여기가 레시피로 넘어가는 부분
                                  ),
                                );
                                print(recipe);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontFamily: 'Pretendard-regular',
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '$calories kcal',
                                    style: const TextStyle(
                                      fontFamily: 'Pretendard-regular',
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Divider(color: Color(0xff3CB196)),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}