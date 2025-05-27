import 'package:flutter/material.dart';

class DietManagementWidget extends StatefulWidget {
  final VoidCallback? onEdit;
  // final Function(Offset)? onDragUpdate;
  final String cardname;
  final int kcal;

  const DietManagementWidget({
    super.key,
    this.onEdit,
    required this.cardname,
    required this.kcal,
  });
  // this.onDragUpdate,

  @override
  _DietManagementWidgetState createState() => _DietManagementWidgetState();
}

class _DietManagementWidgetState extends State<DietManagementWidget> {
  @override
  Widget build(BuildContext context) {
    Color getCardColor(String name) {
      if (name == "아침") {
        return const Color.fromRGBO(252, 210, 151, 1.0);
      } else if (name == "점심") {
        return const Color.fromRGBO(255, 205, 204, 1.0);
      } else if (name == "저녁") {
        return const Color.fromRGBO(177, 224, 248, 1.0);
      } else {
        return Colors.grey;
      }
    }

    IconData getIcon(String name) {
      if (name == "아침") {
        return Icons.wb_sunny_rounded;
      } else if (name == "점심") {
        return Icons.lunch_dining;
      } else if (name == "저녁") {
        return Icons.nightlight_round;
      } else {
        return Icons.fastfood;
      }
    }

    return GestureDetector(
      child: Container(
        width: 326,
        height: 300,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: getCardColor(widget.cardname),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: 8)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.cardname,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "PretenderardVariable",
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.kcal} kcal',
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "PretenderardVariable",
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 40),
                Icon(
                  getIcon(widget.cardname),
                  size: 60,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
