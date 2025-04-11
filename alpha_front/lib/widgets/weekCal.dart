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
    return Container(
      width: 400,
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        border: Border.all(
          width: 3,
          color: const Color.fromRGBO(60, 177, 150, 1.0),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          dateCircleButton(
            text: "일",
            onTap: () {
              print("일요일 선택됨");
            },
            isSuccess: false,
          ),
          const SizedBox(width: 10),
          dateCircleButton(
            text: "월",
            onTap: () {
              print("월요일 선택됨");
            },
            isSuccess: true,
          ),
          const SizedBox(width: 10),
          dateCircleButton(
            text: "화",
            onTap: () {
              print("화요일 선택됨");
            },
            isSuccess: false,
          ),
          const SizedBox(width: 10),
          dateCircleButton(
            text: "수",
            onTap: () {
              print("수요일 선택됨");
            },
            isSuccess: false,
          ),
          const SizedBox(width: 10),
          dateCircleButton(
            text: "목",
            onTap: () {
              print("목요일 선택됨");
            },
            isSuccess: false,
          ),
          const SizedBox(width: 10),
          dateCircleButton(
            text: "금",
            onTap: () {
              print("금요일 선택됨");
            },
            isSuccess: false,
          ),
          const SizedBox(width: 10),
          dateCircleButton(
            text: "토",
            onTap: () {
              print("토요일 선택됨");
            },
            isSuccess: false,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

Widget dateCircleButton({
  required String text,
  required VoidCallback onTap,
  required bool isSuccess,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isSuccess ? const Color.fromRGBO(60, 177, 150, 1.0) : Colors.white,
        border: Border.all(
          color: const Color.fromRGBO(60, 177, 150, 1.0),
          width: 3,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: "PretenderardVariable",
            color: isSuccess ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}
