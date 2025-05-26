import 'package:alpha_front/meal/camera.dart';
import 'package:alpha_front/meal/meal_edit.dart';
import 'package:alpha_front/report/report_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:alpha_front/widgets/kcalWidget.dart';
import 'package:alpha_front/widgets/dietManagement.dart';
import 'package:alpha_front/widgets/bottom_nav_bar.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:alpha_front/widgets/weekCal.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';

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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReportMain()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 658,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(60, 177, 150, 0.08),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const SizedBox(height: 20),
                  // const Weekcal(),
                  const SizedBox(height: 78),
                  GradientElevatedButton(
                    onPressed: () {
                      _onKcalWidgetTap();
                    },
                    style: GradientElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(5),
                      fixedSize: const Size(245, 245),
                      elevation: 6,
                      backgroundGradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(60, 177, 150, 0.8),
                          Color.fromRGBO(60, 177, 150, 0.4),
                        ],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                      // backgroundColor: const Color.fromRGBO(60, 177, 150, 0.8),
                      foregroundColor: Colors.white,
                    ),
                    child: const KcalWidget(),
                  ),
                  const SizedBox(height: 38),
                  // 날짜 위젯 들어갈 곳
                  const SizedBox(height: 37),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          spreadRadius: 0,
                          blurRadius: 25,
                          blurStyle: BlurStyle.normal,
                          offset: const Offset(0, -1),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: dietWidgetList.map((widget) {
                            return Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: SizedBox(
                                width: 130,
                                height: 166,
                                child: widget,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
