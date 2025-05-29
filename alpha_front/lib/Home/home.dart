import 'dart:math';

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
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:alpha_front/services/api_service.dart';
import 'package:alpha_front/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Map<String, dynamic> createdMeal = {}; // 한 번에 받아와서 리스트에 저장(아침,점심,저녁 당일 생성된 식단)
List<Map<String, dynamic>> recommendBreakfastList = [];
List<Map<String, dynamic>> recommendLunchList = [];
List<Map<String, dynamic>> recommendDinnerList = [];

Map<String, dynamic> dateKcal = {}; // 한 번에 받아와서 리스트에 저장(아침,점심,저녁 당일 실제 먹은 식단)
List<Map<String, dynamic>> realBreakfastList = [];
List<Map<String, dynamic>> realLunchList = [];
List<Map<String, dynamic>> realDinnerList = [];

List<Widget> dietWidgetList = [
  const DietManagementWidget(
    cardname: "아침",
    kcal: 380,
  ),
  const DietManagementWidget(
    cardname: "점심",
    kcal: 380,
  ),
  const DietManagementWidget(
    cardname: "저녁",
    kcal: 380,
  ),
];

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  List<String> response = [];
  late DateTime pageDate;
  late String nowDate;
  late String getDataDate;
  late Map<String, dynamic> createMeal;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void categorizeMeals(Map<String, dynamic> createdMeal) {
    recommendBreakfastList.clear();
    recommendLunchList.clear();
    recommendDinnerList.clear();

    List<dynamic> meals = createdMeal['message'];

    for (var meal in meals) {
      switch (meal['mealType']) {
        case 'BREAKFAST':
          recommendBreakfastList.add(meal);
          break;
        case 'LUNCH':
          recommendLunchList.add(meal);
          break;
        case 'DINNER':
          recommendDinnerList.add(meal);
          break;
      }
    }
  }

  Future<void> initializeData() async {
    pageDate = DateTime.now();
    nowDate = DateFormat('M.d(EEE)', 'ko').format(pageDate);
    getDataDate = DateFormat('yyyy-MM-dd').format(pageDate);

    createdMeal = await ApiService.mealDayData(getDataDate); //추천 식단
    dateKcal = await ApiService.fetchkcalData(getDataDate); //실제 식단

    if (createdMeal['message'] is List && createdMeal['message'].isEmpty) {
      print("식단이 생성됨");
      createMeal = await ApiService.createMealData();
      await ApiService.mealDayData(getDataDate).then((result) {
        createdMeal = result;
        categorizeMeals(createdMeal);
      });
    } else {
      categorizeMeals(createdMeal); // 생성된 식단 아침,점심, 저녁 별 구분 저장
    }

    setState(() {}); // UI 갱신
  }

  Future<void> updateData(DateTime pageDate) async {
    nowDate = DateFormat('M.d(EEE)', 'ko').format(pageDate);
    getDataDate = DateFormat('yyyy-MM-dd').format(pageDate);

    createdMeal = await ApiService.mealDayData(getDataDate); //추천 식단
    dateKcal = await ApiService.fetchkcalData(getDataDate); //실제 식단

    if (createdMeal['message'] is List && createdMeal['message'].isEmpty) {
      // print("식단이 생성됨");
      // createMeal = await ApiService.createMealData();
      print("n일 뒤 다시 생성해주세요");
      initializeData();
    } else {
      categorizeMeals(createdMeal); // 생성된 식단 아침,점심, 저녁 별 구분 저장
    }

    setState(() {}); // UI 갱신
  }

  // void onEditClicked() {
  //   print("수정 아이콘 클릭됨");
  //   //page 이동
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => const MealEdit()));
  // }

  // void _onDragUpdate(Offset position) {
  //   print("드래그 동작함");
  // }

  void _onKcalWidgetTap() {
    print("KcalWidget이 클릭됨");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReportMain()),
    ).then((_) {
      pageDate = DateTime.now();
      updateData(pageDate); // 돌아오면 새로고침
    });
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          //  현재 페이지 정보 전날 날짜 정보 get 해오고 home.dart 정보 reload
                          setState(() {
                            pageDate =
                                pageDate.subtract(const Duration(days: 1));
                            // nowDate =
                            //     DateFormat('M.d(EEE)', 'ko').format(pageDate);
                            // getDataDate =
                            //     DateFormat('yyyy-MM-dd').format(pageDate);
                            updateData(pageDate);
                          });
                          // dateKcal =
                          //     await ApiService.fetchkcalData(getDataDate);
                        },
                        icon: const Icon(Icons.arrow_left),
                        iconSize: 60,
                      ),
                      const SizedBox(width: 30),
                      Text(
                        nowDate,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(48, 48, 48, 0.8),
                          fontWeight: FontWeight.bold,
                          fontFamily: "PretenderardVariable",
                        ),
                      ),
                      const SizedBox(width: 30),
                      IconButton(
                        onPressed: () async {
                          // 현재 페이지 정보 다음 날 날짜 정보 get 해오고 home.dart 정보 reload
                          setState(() {
                            pageDate = pageDate.add(const Duration(days: 1));
                            updateData(pageDate);
                          });
                        },
                        icon: const Icon(Icons.arrow_right),
                        iconSize: 60,
                      ),
                    ],
                  ),
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
                      height: 275,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              List.generate(dietWidgetList.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MealEdit(
                                      initialIndex: index + 1,
                                      recommendBreakfastList:
                                          recommendBreakfastList,
                                      recommendLunchList: recommendLunchList,
                                      recommendDinnerList: recommendDinnerList,
                                      routeNum: 0,
                                    ),
                                  ),
                                ).then((_) {
                                  initializeData(); // 돌아오면 새로고침
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: SizedBox(
                                  width: 140,
                                  height: 180,
                                  child: dietWidgetList[index],
                                ),
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
