import 'package:alpha_front/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:alpha_front/widgets/post_widget.dart';

class SearchPost extends StatefulWidget {
  const SearchPost({super.key});

  @override
  State<SearchPost> createState() => _SearchPostState();
}

class _SearchPostState extends State<SearchPost> {
  List<Map<String, dynamic>> posts = [];
  bool isLoading = false;
  String searchText = '';

  void searchRecipe(String keyword) async {
    if (keyword.trim().isEmpty) return;

    setState(() {
      isLoading = true;
      posts = [];
    });

    final result = await ApiService.getRecipeList(keyword);

    // 유사도 필터링 0.3
    final filtered = (result ?? []).where((recipe) {
      final name = recipe['name']?.toString() ?? '';
      final similarity = name.similarityTo(keyword);
      return similarity > 0.3;
    }).toList();

    setState(() {
      posts = filtered;
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
                hintText: "검색",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: const Color(0xff3CB196)),
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
            const PostIngredient(
              postTitle: "오늘의 도시락",
              postDetail: "레시피 추천받은 주먹밥과...",
              postScrap: 13,
              postLike: 5,
              postComment: 3,
              postDate: "2025/05/27", // api body 가공해서 위젯 불러올 것
              postURLs: "../assets/images/character.png",
            ),
            const SizedBox(height: 50),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff3CB196),
                      ),
                    )
                  : posts.isEmpty
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
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final recipe = posts[index];
                            final name = recipe['name']?.toString() ?? '';
                            final calories =
                                recipe['calories']?.toString() ?? '0';

                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const 작성된 게시글()));
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
