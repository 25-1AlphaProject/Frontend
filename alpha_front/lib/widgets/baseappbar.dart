import 'package:flutter/material.dart';

class BaseAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  BaseAppbar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white.withAlpha(0),
      title: Text(
        '$title',
        style: TextStyle(
          fontFamily: 'yg-jalnan',
          color:Color(0xff118B50),
          fontSize: 20,
        ),
      ),
    );
  }
  //

  @override
  Size get preferredSize => Size.fromHeight(50);
}