import 'package:final_project/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quran App',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: purpleColor),
              ),
              SizedBox(height: 16),
              Text(
                "Learn Quran and \nRecite once everyday",
                style: TextStyle(fontSize: 18, color: greyColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 49),
              Container(
                height: 450,
                width: 314,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image_splash.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
