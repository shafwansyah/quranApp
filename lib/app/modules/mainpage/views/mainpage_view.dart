import 'package:final_project/app/modules/login/controllers/login_controller.dart';
import 'package:final_project/app/modules/mainpage/views/home_view.dart';
import 'package:final_project/app/modules/mainpage/views/profile_view.dart';
import 'package:final_project/app/modules/mainpage/views/splash_view.dart';
import 'package:final_project/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mainpage_controller.dart';

class MainpageView extends GetView<MainpageController> {
  final authC = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    'Quran App',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: purpleColor,
                    ),
                  ),
                  actions: [
                    StreamBuilder<User?>(
                        stream: controller.streamUser,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.data != null) {
                              return IconButton(
                                  onPressed: () {
                                    authC.logout();
                                  },
                                  icon: Icon(
                                    Icons.logout_outlined,
                                    color: purpleColor,
                                  ));
                            }
                          }

                          return SizedBox();
                        }),
                  ],
                  centerTitle: true,
                ),
                bottomNavigationBar: Obx(
                  () => BottomNavigationBar(
                      onTap: (value) => controller.navbarItemTap(value),
                      backgroundColor: whiteColor,
                      selectedItemColor: purpleColor,
                      unselectedItemColor: greyColor,
                      elevation: 0,
                      currentIndex: controller.selectedItem.value,
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.menu_book_rounded,
                            ),
                            label: "Home".toUpperCase()),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.person_outline_rounded,
                            ),
                            label: "Profile".toUpperCase()),
                      ]),
                ),
                body: Obx(
                  () => IndexedStack(
                    index: controller.selectedItem.value,
                    children: [
                      HomeView(),
                      ProfileView(),
                    ],
                  ),
                ));
          }
          return SplashView();
        });
  }
}
