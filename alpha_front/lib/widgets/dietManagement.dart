import 'package:flutter/material.dart';

class DietManagementWidget extends StatefulWidget {
  final VoidCallback? onEdit;
  // final Function(Offset)? onDragUpdate;
  String cardname;

  DietManagementWidget({super.key, this.onEdit, required this.cardname});
  // this.onDragUpdate,

  @override
  _DietManagementWidgetState createState() => _DietManagementWidgetState();
}

class _DietManagementWidgetState extends State<DietManagementWidget> {
  List<String> foodImages = [
    // "assets/food_0.png",
    // "assets/food_1.png",
    // "assets/food_2.png",
    // "assets/food_3.png",
    // "assets/food_4.png",
    // "assets/food_5.png",
  ]; // 서버에서 받아올 데이터

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onPanUpdate: (details) {
      //   if (widget.onDragUpdate != null) {
      //     widget.onDragUpdate!(details.delta); // 외부에서 위치를 조정하도록 변경
      //   }
      // },
      child: Container(
        width: 326,
        height: 196,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: 8)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(widget.cardname,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PretenderardVariable",
                    )),
                const SizedBox(width: 4),
                const Text(
                  "평소에 비해 탄수화물이 부족합니다!",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(178, 178, 178, 1.0),
                    fontFamily: "PretenderardVariable",
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: foodImages.map((image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(image, width: 50, height: 50),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
