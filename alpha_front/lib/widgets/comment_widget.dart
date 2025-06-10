import 'package:alpha_front/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  final VoidCallback? onEdit;
  final String content;
  final DateTime createdAt;
  final Map<String, dynamic> authorData;

  const CommentWidget({
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
  @override
  Widget build(BuildContext context) {
    final String nickname = widget.authorData['userId'];
    final String? profileImageUrl = widget.authorData['profileImageUrl'];

    return Row(
      children: [
        profileImageUrl == null || profileImageUrl.isEmpty
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
                backgroundImage: NetworkImage(profileImageUrl),
              ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nickname,
                style: const TextStyle(
                  fontFamily: "PretenderardVariable",
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1.0),
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 3,
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
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    '${widget.createdAt.year}-${widget.createdAt.month.toString().padLeft(2, '0')}-${widget.createdAt.day.toString().padLeft(2, '0')}',
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      minimumSize: const Size(0, 30),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    child: const Text("답글달기"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
