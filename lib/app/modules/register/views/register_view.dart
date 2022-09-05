import 'package:final_project/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: purpleColor,
          leading: IconButton(
              onPressed: () => Get.back(), icon: Icon(Icons.chevron_left)),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg_login.png"), fit: BoxFit.cover)),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Quran App',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: whiteColor),
                ),
                SizedBox(height: 16),
                Text(
                  "Learn Quran and \nRecite once everyday",
                  style: TextStyle(fontSize: 18, color: whiteColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 35),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: orangeColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: TextField(
                      controller: controller.nameC,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Full Name",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          )),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: orangeColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: TextField(
                      controller: controller.emailC,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Username",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          )),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                      color: orangeColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Obx(
                      () => TextField(
                        obscureText: !controller.isShowPassword.value,
                        controller: controller.passC,
                        style: TextStyle(
                          fontSize: 18,
                          color: whiteColor,
                        ),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.showPassword();
                              },
                              icon: Icon(
                                controller.isShowPassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: whiteColor,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 200),
                ElevatedButton(
                    onPressed: () {
                      controller.signUp();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: orangeColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 17),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: whiteColor),
                    )),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
