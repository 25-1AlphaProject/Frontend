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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: BaseAppbar(),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff3CB196),
        elevation: 6,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Camera()),
          );
        },
        child: const Icon(
          Icons.camera,
          color: Colors.white,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
