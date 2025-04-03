import 'package:alpha_front/meal/camera.dart';
import 'package:alpha_front/meal/meal_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/widgets/baseappbar.dart';
import 'package:alpha_front/widgets/kcalWidget.dart';
import 'package:alpha_front/widgets/dietManagement.dart';
import 'package:alpha_front/widgets/basenavigationbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onEditClicked() {
    print("수정 아이콘 클릭됨");
    //page 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealEdit())
    );
  }

  void _onDragUpdate(Offset position) {
    print("드래그 동작함");
  }

  void _onKcalWidgetTap() {
    print("KcalWidget이 클릭됨");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => const 어디로...()),
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
        backgroundColor: const Color.fromRGBO(251, 246, 233, 1.0),
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: const Basenavigationbar(currentIndex: 0,),
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
        child: Icon(Icons.camera_alt,
        color: Color(0xff118B50),),
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Camera()),
          );
        }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 28),
            // Week(),
            const SizedBox(height: 28),
            KcalWidget(
              onTap: _onKcalWidgetTap,
            ),
            const SizedBox(height: 200),
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  DietManagementWidget(
                    onEdit: _onEditClicked,
                    onDragUpdate: _onDragUpdate,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
