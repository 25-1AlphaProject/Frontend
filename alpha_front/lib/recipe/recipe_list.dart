// import 'package:alpha_front/recipe/recipe_description.dart';
// import 'package:alpha_front/recipe/recipe_detail.dart';
// import 'package:alpha_front/widgets/base_app_bar.dart';
// import 'package:alpha_front/widgets/bottom_nav_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:string_similarity/string_similarity.dart';

// class RecipeList extends StatefulWidget {
//   const RecipeList({super.key});

//   @override
//   State<RecipeList> createState() => _RecipeListState();
// }

// class _RecipeListState extends State<RecipeList> {
//   List<Map<String, String>> recipes = [
//     {'recipename': '김치볶음밥'},
//     {'recipename': '비빔밥'},
//     {'recipename': '된장찌개'},
//     {'recipename': '카레라이스'},
//   ];

//   String query = '';
//   List<Map<String, String>> filteredRecipes = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredRecipes = recipes;
//   }

//   void searchRecipe(String input) {
//     setState(() {
//       query = input;
//       if (query.isEmpty) {
//         filteredRecipes = recipes;
//       } else {
//         filteredRecipes = recipes.where((recipe) {
//           String name = recipe['recipename']!;
//           return name.contains(query) ||
//               (query.similarityTo(name) > 0.3); // 검색 유사도
//         }).toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           children: [
//             TextField(
//               style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium,
//               onChanged: searchRecipe,
//               decoration: InputDecoration(
//                 icon: const Icon(
//                   Icons.search,
//                   color: Color(0xff3CB196),
//                 ),
//                 hintText: "레시피를 검색하세요",
//                 hintStyle: Theme.of(context)
//                         .textTheme
//                         .bodyMedium!.
//                         copyWith(color: Color(0xff3CB196)),
//                 enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                   color: const Color(0xff3CB196).withAlpha(150),
//                 )),
//                 focusedBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Color(0xff3CB196),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 50),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredRecipes.length,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const RecipeDetail()));
//                     },
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10.0),
//                           child: Container(
//                             alignment: Alignment.centerLeft,
//                             height: 50,
//                             child: Text(
//                               filteredRecipes[index]['recipename']!,
//                               textAlign: TextAlign.start,
//                               style: const TextStyle(
//                                 fontFamily: 'Pretendard-regular',
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15.0),
//                           child: Container(
//                             alignment: Alignment.centerLeft,
//                             height: 50,
//                             child: const Text(
//                               '200 kcal', //// 칼로리 받아오기
//                               style: TextStyle(
//                                 fontFamily: 'Pretendard-regular',
//                                 fontSize: 15,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const Divider(
//                           color: Color(0xff3CB196),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       // bottomNavigationBar: const Basenavigationbar(
//       //   currentIndex: 2,
//       // ),
//     );
//   }
// }
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

    // 유사도 필터링 0.3
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
                )),
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
                      ? const Center(
                          child: Text(
                            "검색어를 입력하세요.",
                            style: TextStyle(
                              fontFamily: 'Pretendard-regular',
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: recipes.length,
                          itemBuilder: (context, index) {
                            final recipe = recipes[index];
                            final name = recipe['name']?.toString() ?? '';
                            final calories = recipe['calories']?.toString() ?? '0';

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const RecipeDetail()));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 50,
                                      child: Text(
                                        name,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontFamily: 'Pretendard-regular',
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 50,
                                      child: Text(
                                        '$calories kcal',
                                        style: const TextStyle(
                                          fontFamily: 'Pretendard-regular',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Color(0xff3CB196),
                                  ),
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
