import 'package:flutter/material.dart';

class BaseAppbar extends StatelessWidget implements PreferredSizeWidget {

  const BaseAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor:
        Colors.white.withAlpha(26),
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          '척척밥사',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
