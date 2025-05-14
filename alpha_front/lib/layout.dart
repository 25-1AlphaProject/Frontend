import 'package:alpha_front/Home/home.dart';
import 'package:alpha_front/community/community_list.dart';
import 'package:alpha_front/meal/camera.dart';
import 'package:alpha_front/mypage/mypage_main.dart';
import 'package:alpha_front/recipe/recipe_list.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:alpha_front/widgets/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentIndex = 0;

  // 각 탭에 해당하는 페이지들 리스트를 구성합니다.
  final List<Widget> _pages = [
    const HomeScreen(),
    const CommunityList(),
    const RecipeList(),
    const MypageMain(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 상단 네비게이션 바는 영속적으로 유지됩니다.
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BaseAppbar(),
      ),  
      body: IndexedStack(
        index: _currentIndex,
        children: _pages.map((page) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33), // 좌우 padding을 33으로 설정
            child: page,
          );
        }).toList(),
      ),
      // 하단 네비게이션 바도 영속적으로 유지되며, onTap 이벤트를 통해 페이지 전환을 처리합니다.
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped, // 이 콜백을 통해 선택된 인덱스 업데이트
      ),    
    );
  }
}