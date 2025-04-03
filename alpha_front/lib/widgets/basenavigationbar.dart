import 'package:alpha_front/Home/home.dart';
import 'package:alpha_front/community/community_list.dart';
import 'package:alpha_front/mypage/mypage_main.dart';
import 'package:alpha_front/recipe/recipe_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(), // 기본 화면 설정
  ));
}

class Basenavigationbar extends StatefulWidget {
  final int currentIndex; // 현재 선택된 탭

  const Basenavigationbar({super.key, required this.currentIndex});

  @override
  _BasenavigationbarState createState() => _BasenavigationbarState();
}

class _BasenavigationbarState extends State<Basenavigationbar> {
  late int screenIndex; // 현재 화면 인덱스

  @override
  void initState() {
    super.initState();
    screenIndex = widget.currentIndex; // 초기 값 설정
  }

  void _onItemTapped(int index) {
    if (index == screenIndex) return; // 동일한 페이지로 이동 방지

    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = HomeScreen();
        break;
      case 1:
        nextScreen = CommunityList();
        break;
      case 2:
        nextScreen = RecipeList();
        break;
      case 3:
        nextScreen = MypageMain();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: screenIndex,
      selectedItemColor: const Color(0xff118B50),
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.forum_rounded), label: '커뮤니티'),
        BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: '검색'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: '마이페이지'),
      ],
      onTap: _onItemTapped,
    );
  }
}
