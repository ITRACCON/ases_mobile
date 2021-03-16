import 'dart:core';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  // Формирование виджета
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/bg.png"), fit: BoxFit.cover),
      ),
    ));
  }
}
