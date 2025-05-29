import 'package:alpha_front/services/api_service.dart';
import 'package:alpha_front/recipe/recipe_detail.dart';
import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  List<Map<String, dynamic>> recipes = [];
  bool isLoading = false;
  String searchText = '';

  void searchRecipe(String keyword) async {
    if (keyword.trim().isEmpty) return;

    setState(() {
      isLoading = true;
      recipes = [];
    });

    final result = await ApiService.getRecipeList(keyword);

    // 유사도 필터링
    final filtered = (result ?? []).where((recipe) {
      final name = recipe['name']?.toString() ?? '';
      final similarity = name.similarityTo(keyword);
      return similarity > 0.3;
    }).toList();

    setState(() {
      recipes = filtered;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              onSubmitted: searchRecipe,
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.search,
                  color: Color(0xff3CB196),
                ),
                hintText: "레시피를 검색하세요",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Color(0xff3CB196)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xff3CB196).withAlpha(150),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff3CB196),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff3CB196),
                      ),
                    )
                  : recipes.isEmpty
                      ? const Center(child: Text("검색 결과가 없습니다."))
                      : ListView.builder(
                          itemCount: recipes.length,
                          itemBuilder: (context, index) {
                            final recipe = recipes[index];
                            final name = recipe['name'] ?? '이름 없음';
                            final calories = recipe['calories']?.toStringAsFixed(1) ?? '0';

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RecipeDetail(), // 여기가 레시피로 넘어가는 부분
                                  ),
                                );
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
