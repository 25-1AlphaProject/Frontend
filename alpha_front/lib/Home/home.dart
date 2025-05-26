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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(height: 20),
              // const Weekcal(),
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
                  width: 367,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
