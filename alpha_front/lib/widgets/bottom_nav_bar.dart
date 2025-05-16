import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int index) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: BottomNavigationBar(
        showSelectedLabels: true, // 선택된 라벨 보이기/숨기기
        showUnselectedLabels: false, // 선택되지 않은 라벨 보이기/숨기기
        backgroundColor: Colors.white,
        currentIndex: widget.currentIndex,
        selectedItemColor: const Color(0xff3CB196),
        unselectedItemColor: const Color(0xff3CB196).withAlpha(150),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              size: 40,),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.forum_rounded,
              size: 40,),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_rounded,
              size: 40,),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_rounded,
              size: 40,),
            label: '마이',
          ),
        ],
        onTap: widget.onTap,
      ),
    );
  }
}
