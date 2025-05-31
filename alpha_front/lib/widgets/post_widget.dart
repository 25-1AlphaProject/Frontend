import 'package:flutter/material.dart';
import 'package:alpha_front/services/api_service.dart';

class PostIngredient extends StatefulWidget {
  final VoidCallback? onEdit;
  final String postTitle;
  final String postDetail;
  final int postScrap;
  final int postLike;
  final int postComment;
  final String postDate;
  final String postURLs;

  const PostIngredient({
    super.key,
    this.onEdit,
    required this.postTitle,
    required this.postDetail,
    required this.postScrap,
    required this.postLike,
    required this.postComment,
    required this.postDate,
    required this.postURLs,
  });

  @override
  _PostIngredientState createState() => _PostIngredientState();
}

class _PostIngredientState extends State<PostIngredient> {
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    loadImage(widget.postURLs);
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 347,
        height: 122.5,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.postTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "PretenderardVariable",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.postDetail,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "PretenderardVariable",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 1,
                          ),
                          const Icon(
                            Icons.bookmark,
                            size: 17,
                            color: Color.fromRGBO(60, 177, 150, 1.0),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.postScrap.toString(),
                            style: const TextStyle(
                              fontFamily: "PretenderardVariable",
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(60, 177, 150, 1.0),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.favorite_rounded,
                            size: 17,
                            color: Color.fromRGBO(255, 0, 4, 1.0),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.postLike.toString(),
                            style: const TextStyle(
                              fontFamily: "PretenderardVariable",
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 0, 4, 1.0),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.comment_rounded,
                            size: 17,
                            color: Color.fromRGBO(0, 153, 255, 1.0),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.postComment.toString(),
                            style: const TextStyle(
                              fontFamily: "PretenderardVariable",
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 153, 255, 1.0),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.postDate,
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
                const SizedBox(
                  width: 30,
                ),
                widget.postURLs != null
                    ? SizedBox(child: Image.asset(widget.postURLs))
                    : const SizedBox.shrink(),
              ],
            ),
            const Divider(
              height: 10,
              color: Color.fromRGBO(60, 177, 150, 1.0),
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
