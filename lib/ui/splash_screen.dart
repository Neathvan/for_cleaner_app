import 'package:flutter/material.dart';
import 'package:clean_app/extention/style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColor.mainColor,
      body: Center(
        child: Text("ClEAN SAPP", style: TextStyle(fontSize: 50),),
      )
    );
  }
}
