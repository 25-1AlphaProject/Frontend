import 'package:alpha_front/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  final VoidCallback? onEdit;
  final String content;
  final String createdAt;
  final List<String> authorData;
  late String nickname;
  late String profileImageUrl;

  CommentWidget({
    super.key,
    this.onEdit,
    required this.authorData,
    required this.createdAt,
    required this.content,
  });

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  nickname = widget.authorData['userId'];
  profileImageUrl = widget.authorData['profileImageUrl'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        authorProfileImageUrl == null
            ? const Icon(
                Icons.person,
                size: 22,
                color: Colors.black,
              )
            : Image.asset(authorProfileImageUrl),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.nickname,
                  style: const TextStyle(
                    fontFamily: "PretenderardVariable",
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1.0),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.content,
                  style: const TextStyle(
                    fontFamily: "Pretenderard-bold",
                    fontSize: 16,
                    color: Color.fromRGBO(32, 32, 32, 1.0),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Row(
                  children: [
                    Text(
                      widget.content,
                      style: const TextStyle(
                        fontFamily: "Pretenderard-bold",
                        fontSize: 16,
                        color: Color.fromRGBO(32, 32, 32, 1.0),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // 답글 타이핑 바텀창 올라오기
                      },
                      style: TextButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF1ABC9C)),
                        foregroundColor: const Color(0xFF1ABC9C),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        minimumSize: const Size(0, 30),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      child: const Text("답글 달기"),
                    ),
                  ],
                ),
                
              ],
            ),
          ],
        ),
      ],
    );
  }
}
