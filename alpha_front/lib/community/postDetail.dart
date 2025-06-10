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
  late List<Map<String, String>> commentList;
  late String likeCount;
  late String scrapCount;
  late String commentCount;
  late DateTime createdAt;
  late String createdAtString;
  late Map<String, String> author;
  late String? authorNickName;
  late String? authorProfileImageUrl;

  bool isLike = false;
  bool isScrap = false;

  @override
  void initState() {
    super.initState();
    id = widget.postData["postId"];
    title = widget.postData["title"];
    content = widget.postData["content"];
    imageUrls = widget.postData["imageUrls"];
    commentList = widget.postData["comments"];
    likeCount = widget.postData["likeCounts"].toString();
    scrapCount = widget.postData["scrapCount"].toString();
    commentCount = widget.postData["commentCount"].toString();
    createdAt = widget.postData['createdAt'];
    createdAtString = DateFormat('yyyy-MM-dd').format(createdAt);
    author = widget.postData['author'];

    authorNickName = author['nickname'];
    authorProfileImageUrl = author['profileImageUrl'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(
        title: '커뮤니티',
        actionButton: IconButton(
          onPressed: () {
            // 버튼에 딸린 팝업창 열리기
          },
          icon: const Icon(Icons.menu_rounded),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 42),
            Text(
              title,
              style: const TextStyle(
                fontFamily: "PretendardVariable",
                fontWeight: FontWeight.bold,
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
                        radius: 11,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.person,
                          size: 22,
                          color: Colors.white,
                        ),
                      )
                    : CircleAvatar(
                        radius: 11,
                        backgroundImage: NetworkImage(authorProfileImageUrl),
                      ),
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
                        fontFamily: "PretendardVariable",
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
                fontFamily: "PretendardVariable",
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
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
                          isScrap = !isScrap;
                        });
                        bool success;
                        if (isScrap) {
                          success = await ApiService.postCommunityFavorite(id);
                          print(success);
                        }
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
                      icon: !isScrap
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
                        fontFamily: "PretendardVariable",
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
                          isLike = !isLike;
                        });
                        bool success;
                        if (isLike) {
                          success = await ApiService.postCommunityFavorite(id);
                          print(success);
                        } else {
                          // success = await ApiService.); 커뮤니티 좋아요 해제
                        }

                        // if (!success) {
                        //   // 실패 시 롤백 처리
                        //   setState(() {
                        //     isScrap = !isScrap;
                        //   });
                        // }
                      },
                      icon: !isLike
                          ? const Icon(
                              Icons.favorite_border_rounded,
                              size: 22,
                              color: Color.fromRGBO(60, 177, 150, 1.0),
                            )
                          : const Icon(
                              Icons.favorite_rounded,
                              size: 22,
                              color: Color.fromRGBO(60, 177, 150, 1.0),
                            ),
                    ),
                    Text(
                      likeCount,
                      style: const TextStyle(
                        fontFamily: "PretendardVariable",
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
                        // 타자 칠 수 있는 bottom팝업 올라오기
                      },
                      icon: const Icon(
                        Icons.comment_rounded,
                        size: 22,
                        color: Color.fromRGBO(60, 177, 150, 1.0),
                      ),
                    ),
                    Text(
                      commentCount,
                      style: const TextStyle(
                        fontFamily: "PretendardVariable",
                        color: Color.fromRGBO(60, 177, 150, 1.0),
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
              children: commentList.map((recipe) {
                return Column(
                  children: [
                    CommentWidget(
                      authorData: authorData,
                      createdAt: createdAt,
                      content: content,
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
  }
}
