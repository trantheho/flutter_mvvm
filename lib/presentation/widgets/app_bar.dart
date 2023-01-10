import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSize{
  final Color? backgroundColor;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;
  final bool? centerTitle;
  final TextStyle?  titleTextStyle;


  const MyAppBar({
    Key? key,
    this.backgroundColor,
    this.leading,
    this.actions,
    this.title,
    this.centerTitle,
    this.titleTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: backgroundColor,
      leading: leading,
      actions: actions,
      title: title,
      centerTitle: centerTitle,
      titleTextStyle: titleTextStyle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
