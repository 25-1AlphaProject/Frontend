import 'package:flutter/material.dart';

class BaseAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextAlign titleAlign;
  final TextStyle? titleStyle;

  const BaseAppbar({
    required this.title,
    this.titleAlign = TextAlign.center,
    this.titleStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white.withAlpha(0),
      title: Align(
        alignment: titleAlign == TextAlign.left
            ? Alignment.centerLeft
            : titleAlign == TextAlign.center
                ? Alignment.center
                : Alignment.centerRight,
        child: Text(
          title,
          style: titleStyle ??
              const TextStyle(
                fontFamily: 'yg-jalnan',
                color: Color(0xff118B50),
                fontSize: 20,
              ),
        ),
      ),
    );
  }
  //

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
