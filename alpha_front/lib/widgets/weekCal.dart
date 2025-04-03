import 'package:flutter/material.dart';

class Weekcal extends StatefulWidget {
  final VoidCallback? onEdit;

  const Weekcal({super.key, this.onEdit});

  @override
  _WeekcalState createState() => _WeekcalState();
}

class _WeekcalState extends State<Weekcal> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 376,
        height: 66,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(33),
          border: Border.all(
            width: 3,
            color: const Color.fromRGBO(60, 177, 150, 1.0),
          ),
        ),
      ),
    );
  }
}
