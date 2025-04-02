import 'package:alpha_front/recipe/recipe_detail.dart';
import 'package:alpha_front/widgets/baseappbar.dart';
import 'package:alpha_front/widgets/basenavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';


class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {

  List<Map<String, String>> recipes = [
    {'recipename': '김치볶음밥'},
    {'recipename': '비빔밥'},
    {'recipename': '된장찌개'},
    {'recipename': '카레라이스'},
  ];

  String query = '';
  List<Map<String, String>> filteredRecipes = [];
  

  @override
  void initState() {
    super.initState();
    filteredRecipes = recipes;
  }

  void searchRecipe(String input) {
    setState(() {
      query = input;
      if (query.isEmpty) {
        filteredRecipes = recipes;
      } else {
        filteredRecipes = recipes.where((recipe) {
          String name = recipe['recipename']!;
          return name.contains(query) ||
              (query.similarityTo(name) > 0.3); // 검색 유사도
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(title: '레시피'),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(
                fontFamily: 'PretendardVariable',
                letterSpacing: 0.25,
              ),
              onChanged: searchRecipe,
              decoration: InputDecoration(
                icon: Icon(Icons.search,
                color: Color(0xff118B50),
                ),
                hintText: "레시피를 검색하세요",
                hintStyle: TextStyle(
                  fontFamily: 'PretendartVariable',
                  letterSpacing: 0.25,
                  fontSize: 15,
                ),
                enabledBorder : UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff118B50).withAlpha(150),
                  )
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff118B50),
                  ),
              ),

              ),
            ),
            SizedBox(height: 50),

            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  return InkWell(

              onTap: () {                     
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetail())
                );
              },
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: Text(
                          filteredRecipes[index]['recipename']!, 
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'PretendardBariable',
                            fontSize: 20,
                          ),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child : Text(
                          '200 kcal', //// 칼로리 받아오기
                          style: TextStyle(
                            fontFamily: 'PretendardBariable',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xff118B50),
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
      bottomNavigationBar: Basenavigationbar(),
    );
  }
}
