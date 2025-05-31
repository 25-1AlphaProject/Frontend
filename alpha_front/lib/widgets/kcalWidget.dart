// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
import 'package:flutter/material.dart';
// import 'package:alpha_front/services/api_service.dart';

class KcalWidget extends StatefulWidget {
  // final VoidCallback? onTap;
  final int realCalories;
  final double goalCalories;

  const KcalWidget({
    super.key,
    required this.realCalories,
    required this.goalCalories,
  });

  @override
  _KcalWidgetState createState() => _KcalWidgetState();
}

class _KcalWidgetState extends State<KcalWidget> {
  late int intakeCalories;
  late double goalCalories;

  @override
  void initState() {
    super.initState();
    intakeCalories = widget.realCalories; // 이제 접근 가능
    goalCalories = widget.goalCalories;
  }

  @override
  Widget build(BuildContext context) {
    double progress = intakeCalories / goalCalories;

    return Center(
      child: SizedBox(
        width: 500,
        height: 500,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // 캐릭터 몸통 이미지 (손 밑으로 위치)
            Positioned(
              top: -70,
              child: Image.asset(
                '../assets/images/character_body.png',
                width: 93.38,
              ),
            ),
            CustomPaint(
              size: const Size(245, 245),
              painter: KcalPainter(progress),
              child: Center(
                child: Text(
                  "${intakeCalories.toInt()} kcal",
                  style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PretenderardVariable",
                      color: Colors.white),
                ),
              ),
            ),

            // 캐릭터 손 이미지 (progress 시작점 위에 위치)
            Positioned(
              top: -30,
              child: Image.asset(
                '../assets/images/character_hand.png',
                width: 93.38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KcalPainter extends CustomPainter {
  final double progress;

  KcalPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24;

    Paint progressPaint = Paint()
      ..color = const Color.fromRGBO(60, 177, 150, 1.0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = 245 / 2;

    canvas.drawCircle(center, radius, backgroundPaint);
    double sweepAngle = progress * 2 * 3.141592;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -3.141592 / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
