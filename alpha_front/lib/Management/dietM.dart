import 'package:flutter/material.dart';

class dietMpage extends StatefulWidget {
  const dietMpage({super.key});

  @override
  _dietMpageState createState() => _dietMpageState();
}

class _dietMpageState extends State<dietMpage> {
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
