import 'package:flutter/material.dart';

class BaseAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? actionButton;

  const BaseAppbar({
    super.key,
    this.title = '척척밥사',
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white.withAlpha(26),
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          '척척밥사',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      actions: [
        if (actionButton != null) actionButton!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
