import 'package:alpha_front/meal/camera.dart';
import 'package:alpha_front/widgets/baseappbar.dart';
import 'package:alpha_front/widgets/basenavigationbar.dart';
import 'package:flutter/material.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({super.key});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(title: '레시피'),
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
      bottomNavigationBar: Basenavigationbar(),

    );
  }
}