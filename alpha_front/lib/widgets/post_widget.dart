import 'package:flutter/material.dart';

class PostIngredient extends StatefulWidget {
  final VoidCallback? onEdit;
  final String postTitle;
  final String postDetail;
  final DateTime postDate;
  final int postScrap;
  final int postLike;
  final int postComment;

  const PostIngredient({
    super.key,
    this.onEdit,
    required this.postTitle,
    required this.postScrap,
    required this.postDetail,
  });

  @override
  _PostIngredientState createState() => _PostIngredientState();
}

class _PostIngredientState extends State<PostIngredient> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    widget.postTitle,
                    style: const TextStyle(
                      fontFamily: "PretenderardVariable",
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 0, 1.0),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    widget.postDetail,
                    style: const TextStyle(
                      fontFamily: "PretenderardVariable",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(32, 32, 32, 1.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              const Image(
                image: AssetImage(
                  // image 변경 - url => network
                  '../assets/images/character.png',
                ),
              ),
            ],
          ),
          const Divider(
            height: 110,
            color: Color.fromRGBO(60, 177, 150, 1.0),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
