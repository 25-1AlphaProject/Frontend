import 'dart:io';
import 'dart:typed_data';
import 'package:alpha_front/layout.dart';

import 'package:alpha_front/meal/camera.dart';
import 'package:alpha_front/meal/meal_edit.dart';
import 'package:alpha_front/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MealamountEdit extends StatefulWidget {
  final Uint8List imageBytes;
  final String mealName;
  final double foodCalories;
  final double amount;
  final String mealPhotoUrl; 
  final String mealType;

  const MealamountEdit({
    super.key,
    required this.imageBytes,
    required this.mealName,
    required this.foodCalories,
    required this.amount,
    required this.mealPhotoUrl,
    required this.mealType,
  });

  @override
  State<MealamountEdit> createState() => _MealamountEditState();
}

class _MealamountEditState extends State<MealamountEdit> {
  List<Map<String, dynamic>> recommendBreakfastList = [];
  List<Map<String, dynamic>> recommendLunchList = [];
  List<Map<String, dynamic>> recommendDinnerList = [];

  @override
  void initState() {
    super.initState();
    fetchCreatedMeal();
  }

  Future<void> fetchCreatedMeal() async {
    final getDataDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final createdMeal = await ApiService.mealDayData(getDataDate);
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

    setState(() {});
  }

  
  Future<void> _submitMealInfo() async {
    final success = await ApiService.foodinfo(
      widget.mealName,
      widget.foodCalories,
      widget.amount.toString(),
      DateTime.now(),
      widget.mealType,
      widget.mealPhotoUrl,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("식단이 저장되었습니다.")),
      );
      _goToNext();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("식단 저장 실패")),
      );
    }
  }


  void _goToNext() {
    int index = 1;

    if (widget.mealName.toUpperCase() == 'BREAKFAST') {
      index = 1;
    } else if (widget.mealName.toUpperCase() == 'LUNCH') {
      index = 2;
    } else if (widget.mealName.toUpperCase() == 'DINNER') {
      index = 3;
    }

    Navigator.push(
      context,
    MaterialPageRoute(
      builder: (context) => MealEdit(
        initialIndex: index,
        recommendBreakfastList: recommendBreakfastList,
        recommendLunchList: recommendLunchList,
        recommendDinnerList: recommendDinnerList,
        mealDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ),),
      // MealEdit(initialIndex: index)
    );
  }

  void _skip() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Camera()),
    );
  }

  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }

  Widget showImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffd0cece),
      ),
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.width * 0.7,
      child: Center(
        child: Image.memory(widget.imageBytes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff3CB196),
            Color(0xff8ED1C1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 33.0, right: 33.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffA3A2B0).withAlpha(20),
                        spreadRadius: -10,
                        blurRadius: 30,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      showImage(),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.mealName,
                        textAlign: TextAlign.start,
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.black,
                                  fontSize: 28,
                                ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xff3CB196),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${widget.foodCalories.toStringAsFixed(1)} kcal',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Pretendard-bold',
                                  ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            '${widget.amount.toStringAsFixed(1)} 인분',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontFamily: 'Pretendard-bold',
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                          // margin: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffd9d9d9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              minimumSize: const Size(double.infinity, 50),
                              elevation: 3,
                            ),
                            onPressed: _skip,
                            child: Text(
                              '다시 인식',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: const Color(0xff4d4d4d)),
                            ),
                          ),
                        )),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        // margin: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffffffff),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            minimumSize: const Size(double.infinity, 50),
                            elevation: 3,
                          ),
                          onPressed: _submitMealInfo,
                          child: Text('다음',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: const Color(0xff3CB196),
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}