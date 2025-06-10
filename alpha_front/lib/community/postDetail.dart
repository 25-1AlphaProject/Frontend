import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:alpha_front/widgets/bottom_nav_bar.dart';
import 'package:alpha_front/widgets/comment_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/services/api_service.dart';
import 'package:intl/intl.dart';

class PostDetail extends StatefulWidget {
  late Map<String, dynamic> postData;
  PostDetail({
    super.key,
    required this.postData,
  });

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  late int id;
  late String title;
  late String content;
  late List<String> imageUrls;
  late List<Map<String, dynamic>> commentList;
  late String likeCount;
  late String scrapCount;
  late String commentCount;
  late DateTime createdAt;
  late String createdAtString;
  late Map<String, dynamic> author;
  late String authorNickName;
  late String? authorProfileImageUrl;

  int isLike = 0;
  int isScrap = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    id = widget.postData["postId"];
    getPostData(id);
  }

  Future<void> getPostData(int postId) async {
    final Map<String, dynamic> data = await ApiService.getPostDetail(id);

    print(data);
    title = data["title"];

    content = data["content"];

    imageUrls = List<String>.from(data["imageUrls"] ?? []);
    commentList = List<Map<String, dynamic>>.from(data["comments"] ?? []);
    likeCount = data["likeCount"].toString();
    scrapCount = data["scrapCount"].toString();
    commentCount = data["commentCount"].toString();

    createdAt = DateTime.parse(data["createdAt"]);
    createdAtString = DateFormat('yyyy-MM-dd').format(createdAt);

    final author = Map<String, dynamic>.from(data["author"]);
    authorNickName = author['nickname']!;
    authorProfileImageUrl = author['profileImageUrl'];

    setState(() {
      isLoading = false;
    });
  }

  // 댓글 분류 함수
  List<Map<String, dynamic>> getReplies(int parentId) {
    return commentList
        .where((comment) => comment['parentCommentId'] == parentId)
        .toList();
  }

  List<Map<String, dynamic>> getRootComments() {
    return commentList
        .where((comment) =>
            comment['parentCommentId'] == null ||
            comment['parentCommentId'] == comment['commentId'])
        .toList();
  }

  // 댓글, 대댓글 빌드 위젯
  Widget buildCommentWithReplies(Map<String, dynamic> comment) {
    final replies = getReplies(comment['commentId']);
    final author = comment['author'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentWidget(
          authorData: author,
          createdAt: DateTime.parse(comment['createdAt']),
          content: comment['content'],
        ),
        const SizedBox(height: 8),
        ...replies.map((reply) {
          return Padding(
            padding: const EdgeInsets.only(left: 24.0), // 들여쓰기
            child: CommentWidget(
              authorData: reply['author'],
              createdAt: DateTime.parse(reply['createdAt']),
              content: reply['content'],
            ),
          );
        }),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: CircularProgressIndicator(
          color: Color(0xff3CB196),
        )),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppbar(
        title: '커뮤니티',
        actionButton: IconButton(
          onPressed: () {
            // 버튼에 딸린 팝업창 열리기
          },
          icon: const Icon(
            Icons.menu_rounded,
            color: Color.fromRGBO(60, 177, 150, 1.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 42),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: "Pretendard-bold",
                  color: Color.fromRGBO(0, 0, 0, 1.0),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  authorProfileImageUrl == null
                      ? const CircleAvatar(
                          radius: 14,
                          backgroundColor: Color.fromRGBO(60, 177, 150, 1.0),
                          child: Icon(
                            Icons.person,
                            size: 28,
                            color: Colors.white,
                          ),
                        )
                      : CircleAvatar(
                          radius: 11,
                          backgroundImage: NetworkImage(authorProfileImageUrl!),
                        ),
                  const SizedBox(width: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authorNickName,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        createdAtString,
                        style: const TextStyle(
                          fontFamily: "Pretendard-bold",
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(154, 154, 154, 1.0),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 30,
                color: Color.fromRGBO(174, 174, 174, 1.0),
                thickness: 2,
              ),
              Text(
                content,
                style: const TextStyle(
                  fontFamily: "Pretendard-bold",
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: imageUrls.isNotEmpty ? 150 : 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network(imageUrls[index]),
                    );
                  },
                ),
              ),
              const Divider(
                height: 30,
                color: Color.fromRGBO(174, 174, 174, 1.0),
                thickness: 2,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            isScrap = isScrap == 0 ? 1 : 0;
                          });
                          final Map<String, dynamic> scrapCountData =
                              await ApiService.postCommunityScrap(id);
                          setState(() {
                            scrapCount =
                                scrapCountData['scrapCount'].toString();
                          });
                          // else {
                          //   success = await ApiService.); 커뮤니티 좋아요 해제
                          // }

                          // if (!success) {
                          //   // 실패 시 롤백 처리
                          //   setState(() {
                          //     isScrap = !isScrap;
                          //   });
                          // }
                        },
                        icon: isScrap == 1
                            ? const Icon(
                                Icons.bookmark,
                                size: 22,
                                color: Color.fromRGBO(60, 177, 150, 1.0),
                              )
                            : const Icon(
                                Icons.bookmark_border,
                                size: 22,
                                color: Color.fromRGBO(60, 177, 150, 1.0),
                              ),
                      ),
                      Text(
                        scrapCount,
                        style: const TextStyle(
                          fontFamily: "Pretendard-regular",
                          color: Color.fromRGBO(60, 177, 150, 1.0),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            isLike == 0 ? isLike = 1 : isLike = 0;
                          });

                          final Map<String, dynamic> likeCountData =
                              await ApiService.postCommunityFavorite(id);
                          setState(() {
                            likeCount = likeCountData['likeCount'].toString();
                          });

                          // if (!success) {
                          //   // 실패 시 롤백 처리
                          //   setState(() {
                          //     isScrap = !isScrap;
                          //   });
                          // }
                        },
                        icon: isLike == 0
                            ? const Icon(
                                Icons.favorite_border_rounded,
                                size: 22,
                                color: Color.fromRGBO(255, 0, 4, 1.0),
                              )
                            : const Icon(
                                Icons.favorite_rounded,
                                size: 22,
                                color: Color.fromRGBO(255, 0, 4, 1.0),
                              ),
                      ),
                      Text(
                        likeCount,
                        style: const TextStyle(
                          fontFamily: "Pretendard-regular",
                          color: Color.fromRGBO(255, 0, 4, 1.0),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          // 타자 칠 수 있는 bottom팝업 올라오기
                        },
                        icon: const Icon(
                          Icons.comment_rounded,
                          size: 22,
                          color: Color.fromRGBO(0, 153, 255, 1.0),
                        ),
                      ),
                      Text(
                        commentCount,
                        style: const TextStyle(
                          fontFamily: "Pretendard-regular",
                          color: Color.fromRGBO(0, 153, 255, 1.0),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: getRootComments().map((comment) {
                  return buildCommentWithReplies(comment);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
