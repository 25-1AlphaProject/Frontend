import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/services/api_service.dart';
import 'package:alpha_front/community/postDetail.dart';



class MypageMylike extends StatefulWidget {
  const MypageMylike({super.key});

  @override
  State<MypageMylike> createState() => _MypageMylikeState();
}

class _MypageMylikeState extends State<MypageMylike> {
  bool isLoading = true;
  List<dynamic> community = [];

  @override
  void initState() {
    super.initState();
    fetchFavoriteRecipes();
  }

  Future<void> fetchFavoriteRecipes() async {
    final result = await ApiService.getCommunityFavorite();

    print("불러온 게시글 수: ${result.length}");
    for (var post in result) {
      print("제목: ${post['title']}, 좋아요 수: ${post['likeCount']}, 작성일: ${post['createdAt']}");
    }

    setState(() {
      community = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(),
      body: Padding(
        padding: EdgeInsets.all(33.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff3CB196),
                      ),
                    )
                  : community.isEmpty
                      ? const Center(
                          child: Text(
                            "좋아요 표시한 글이 없습니다.",
                            style: TextStyle(
                              fontFamily: 'Pretendard-regular',
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: community.length,
                          itemBuilder: (context, index) {
                            final post = community[index];
                            final title = post["title"]?.toString() ?? '';
                            final detail = post['content']?.toString() ?? '';
                            final scrap = post["scrapCount"] ?? 0;
                            final like = post['likeCount'] ?? 0;
                            final comment = post['commentCount'] ?? 0;
                            final image = post['thumbnailUrl']?.toString() ?? '';
                            final date = post['createdAt']?.toString() ?? '';
                            final dateFormat = date.length >= 10 ? date.substring(0, 10) : '';

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostDetail(postData: post),
                                  ),
                                );
                              },
                              child: Center(
                                child: SizedBox(
                                  width: 347,
                                  height: 122.5,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: image != '' ? 200 : 300,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  title,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontFamily: "PretenderardVariable",
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  detail,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontFamily: "PretenderardVariable",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.bookmark,
                                                      size: 17,
                                                      color: Color.fromRGBO(60, 177, 150, 1.0),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      scrap.toString(),
                                                      style: const TextStyle(
                                                        fontFamily: "PretenderardVariable",
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromRGBO(60, 177, 150, 1.0),
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const Icon(
                                                      Icons.favorite_rounded,
                                                      size: 17,
                                                      color: Color.fromRGBO(255, 0, 4, 1.0),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      like.toString(),
                                                      style: const TextStyle(
                                                        fontFamily: "PretenderardVariable",
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromRGBO(255, 0, 4, 1.0),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const Icon(
                                                      Icons.comment_rounded,
                                                      size: 17,
                                                      color: Color.fromRGBO(0, 153, 255, 1.0),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      comment.toString(),
                                                      style: const TextStyle(
                                                        fontFamily: "PretenderardVariable",
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromRGBO(0, 153, 255, 1.0),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      dateFormat,
                                                      style: const TextStyle(
                                                        fontFamily: "PretenderardVariable",
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromRGBO(32, 32, 32, 1.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 30),
                                          image != ''
                                              ? SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: Image.network(
                                                    image,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return const Icon(Icons.broken_image);
                                                    },
                                                  ),
                                                )
                                              : const SizedBox(width: 1, height: 1),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      const Divider(
                                        height: 1,
                                        color: Color.fromRGBO(60, 177, 150, 1.0),
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                ),
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