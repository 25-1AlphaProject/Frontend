import 'package:alpha_front/meal/camera.dart';
import 'package:alpha_front/meal/meal_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/widgets/baseappbar.dart';
import 'package:alpha_front/widgets/kcalWidget.dart';
import 'package:alpha_front/widgets/dietManagement.dart';
import 'package:alpha_front/widgets/basenavigationbar.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:alpha_front/widgets/weekCal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final List<Widget> dietWidgetList = [
  DietManagementWidget(cardname: "아침"),
  DietManagementWidget(cardname: "점심"),
  DietManagementWidget(cardname: "저녁"),
];

class _HomeScreenState extends State<HomeScreen> {
  void _onEditClicked() {
    print("수정 아이콘 클릭됨");
    //page 이동
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MealEdit()));
  }

  // void _onDragUpdate(Offset position) {
  //   print("드래그 동작함");
  // }

  void _onKcalWidgetTap() {
    print("KcalWidget이 클릭됨");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => const 어디로...전체 리포트 페이지로...()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '척척밥사',
          style: TextStyle(
            fontFamily: 'yg-jalnan',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        backgroundColor: Colors.white.withAlpha(0),
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: const Basenavigationbar(
        currentIndex: 0,
      ),
      // floatingActionButton: GestureDetector(
      //   onTap: () {},
      //   child: Container(
      //     width: 64,
      //     height: 64,
      //     decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       border: Border.all(
      //           color: const Color.fromRGBO(251, 246, 233, 1.0), width: 7),
      //     ),
      //     child: const ClipOval(
      //       child: Material(
      //         color: Colors.white,
      //         elevation: 10,
      //         child: InkWell(
      //           child: SizedBox(
      //             width: 56,
      //             height: 56,
      //             child: Icon(
      //               CupertinoIcons.camera,
      //               color: Colors.black,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Camera()),
            );
          },
          child: const Icon(
            Icons.camera_alt,
            color: Color(0xff118B50),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Weekcal(),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {
                _onKcalWidgetTap();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(5),
                fixedSize: const Size(245, 245),
                elevation: 6,
                // backgroundColor: Colors.black,
                // foregroundColor: Colors.teal,
              ),
              child: const KcalWidget(),
            ),
            const SizedBox(height: 21),
            Swiper(
              layout: SwiperLayout.STACK,
              viewportFraction: 0.8,
              scrollDirection: Axis.vertical,
              itemWidth: 400, // 카드 너비 조정
              itemHeight: 225, // 카드 높이 조정
              loop: true,
              autoplay: false,
              duration: 1200,
              itemCount: dietWidgetList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: dietWidgetList[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
