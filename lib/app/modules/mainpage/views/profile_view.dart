import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/modules/login/controllers/login_controller.dart';
import 'package:final_project/app/modules/mainpage/controllers/mainpage_controller.dart';
import 'package:final_project/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProfileView extends GetView<MainpageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 257,
              padding: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/frame_surah_detail.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/icon_basmalah.png",
                    width: 214,
                  ),
                  SizedBox(height: 30),
                  Divider(
                    height: 1,
                    thickness: 10,
                    color: whiteColor,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child:
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                              stream: controller.fetchUser(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox();
                                }
                                return Text(
                                  "\n${snapshot.data?.data()!["fullname"] ?? "Let's get more pahala"}",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor,
                                  ),
                                );
                              }),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.folder_outlined,
                  size: 28,
                  color: purpleColor,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Last Read",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: purpleColor),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Al-Fatihah : 6",
                    style: TextStyle(
                      fontSize: 18,
                      color: purpleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chevron_right_outlined,
                        size: 24,
                        color: purpleColor,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
