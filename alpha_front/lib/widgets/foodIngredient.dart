import 'package:alpha_front/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class FoodIngredient extends StatefulWidget {
  final VoidCallback? onEdit;
  final String foodUnit;
  final String foodName;
  final String url;

  const FoodIngredient({
    super.key,
    this.onEdit,
    required this.foodName,
    required this.foodUnit,
    required this.url,
  });

  @override
  _FoodIngredientState createState() => _FoodIngredientState();
}

class _FoodIngredientState extends State<FoodIngredient> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.foodName,
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
                widget.foodUnit,
                style: const TextStyle(
                  fontFamily: "PretenderardVariable",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 32, 32, 1.0),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              TextButton(
                onPressed: () {
                  print(widget.url);
                  launchUrl(Uri.parse(widget.url));
                },
                style: TextButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF1ABC9C)),
                  foregroundColor: const Color(0xFF1ABC9C),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: const Size(0, 30),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                child: const Text("사러가기"),
              ),
            ],
          ),
          const Divider(
            height: 110,
            color: Color.fromRGBO(213, 213, 213, 1.0),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
