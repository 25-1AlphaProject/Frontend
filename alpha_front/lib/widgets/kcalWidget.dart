import 'package:flutter/material.dart';

class KcalWidget extends StatefulWidget {
  // final VoidCallback? onTap;

  const KcalWidget({super.key});

  @override
  _KcalWidgetState createState() => _KcalWidgetState();
}

class _KcalWidgetState extends State<KcalWidget> {
  double intakeCalories = 1207; // 서버에서 받아올 값
  double goalCalories = 2000; // 목표 칼로리

  @override
  Widget build(BuildContext context) {
    double progress = intakeCalories / goalCalories;

    return Center(
      child: CustomPaint(
        size: const Size(245, 245),
        painter: KcalPainter(progress),
        child: Center(
          child: Text(
            "${intakeCalories.toInt()} kcal",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: "PretenderardVariable",
            ),
          ),
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
      ..color = const Color.fromRGBO(170, 229, 216, 1.0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13;

    Paint progressPaint = Paint()
      ..color = const Color.fromRGBO(60, 177, 150, 1.0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = 245 / 2;

    canvas.drawCircle(center, radius, backgroundPaint);
    double sweepAngle = progress * 2 * 3.141592;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 5),
        -3.141592 / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
