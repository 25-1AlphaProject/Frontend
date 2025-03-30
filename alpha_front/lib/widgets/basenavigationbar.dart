import 'package:flutter/material.dart';

class Basenavigationbar extends StatefulWidget {
  const Basenavigationbar({super.key});

  @override
  _BasenavigationbarState createState() => _BasenavigationbarState();
}

class _BasenavigationbarState extends State<Basenavigationbar> {
  int screenIndex = 0;

  final List<Widget> screenList = [
    Text('홈', style: TextStyle(fontSize: 24)),
    Text('식단', style: TextStyle(fontSize: 24)),
    Text('커뮤니티', style: TextStyle(fontSize: 24)),
    Text('마이페이지', style: TextStyle(fontSize: 24)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100),
          topRight: Radius.circular(100),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black, 
            blurRadius: 5, 
            spreadRadius: 2, 
            offset: const Offset(0, 5), // 그림자의 위치
          ),
        ],
      ),
    
      child: BottomNavigationBar(
          currentIndex: screenIndex,
          selectedItemColor: Color(0xff118B50),
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.food_bank_rounded), label: '식단'),
            BottomNavigationBarItem(icon: Icon(Icons.forum_rounded), label: '커뮤니티'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: '마이페이지'),
          ],
          onTap: (value) {
            setState(() {
              screenIndex = value;
            });
          },
        ),
    );
  }
}
