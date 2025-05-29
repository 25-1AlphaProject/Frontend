import 'package:alpha_front/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:alpha_front/widgets/post_widget.dart';
import 'package:alpha_front/community/write.dart';

class SearchPost extends StatefulWidget {
  const SearchPost({super.key});

  @override
  State<SearchPost> createState() => _SearchPostState();
}

class _SearchPostState extends State<SearchPost> {
  List<Map<String, dynamic>> posts = [];
  bool isLoading = false;
  String searchText = '';

  void searchPost(String keyword) async {
    if (keyword.trim().isEmpty) return;

    setState(() {
      isLoading = true;
      posts = [];
    });

    final result = await ApiService.getPostList(keyword);

    final filtered = (result ?? []).where((post) {
      final title = post['title']?.toString() ?? '';
      final similarity = title.similarityTo(keyword);
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
              onSubmitted: searchPost,
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
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PostCreatePage()),
                  );
                },
                icon: const Icon(Icons.wifi_password_outlined)),
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
                            "검색결과가 없습니다.",
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
                            final post = posts[index];
                            final title = post["title"]?.toString() ?? '';
                            final detail = post['content']?.toString() ?? '';
                            final scrap = post["scrapCount"] ?? 0;
                            final like = post['likeCount'] ?? 0;
                            final comment = post['commentCount'] ?? 0;
                            final image =
                                post['thumbnailUrl']?.toString() ?? '';
                            final date = post['createdAt']?.toString() ?? '';
                            final dateFormat =
                                date.length >= 10 ? date.substring(0, 10) : '';

                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const 작성된 게시글()));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PostIngredient(
                                    postTitle: title,
                                    postDetail: detail,
                                    postScrap: scrap,
                                    postLike: like,
                                    postComment: comment,
                                    postDate: dateFormat,
                                    postURLs: image,
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
