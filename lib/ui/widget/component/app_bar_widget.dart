import 'package:flutter/material.dart';
import 'package:clean_app/extention/style.dart';
class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final String? title2;
  final Color? colors;
  const AppBarWidget({Key? key,required this.title, this.colors, this.title2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("$title ${ title2 ?? ''}"),
      backgroundColor: this.colors == null ? defaultColor.appColor : colors,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
