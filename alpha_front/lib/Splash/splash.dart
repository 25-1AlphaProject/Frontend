import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '척척밥사',
          style: TextStyle(
            fontFamily: 'yg-jalnan',
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(17, 139, 80, 1.0),
          ),
        ),
      ),
    );
  }
}
