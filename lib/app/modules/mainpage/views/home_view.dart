import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/modules/mainpage/controllers/mainpage_controller.dart';
import 'package:final_project/app/routes/app_pages.dart';
import 'package:final_project/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeView extends GetView<MainpageController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: whiteColor),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
                text: "Assalamualaikum\n",
                children: [
                  TextSpan(
                      text: "Let's get more pahala".capitalize,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: purpleDarkColor,
                      ))
                ],
                style: TextStyle(
                  fontSize: 18,
                  color: greyColor,
                )),
          ),
          const SizedBox(height: 24),
          Container(
            height: 131,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage("assets/frame_surah.png"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.menu_book_rounded,
                      size: 20,
                      color: whiteColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Last Read",
                      style: TextStyle(color: whiteColor),
                    ),
                  ],
                ),
                Obx(
                  () => Text.rich(TextSpan(
                    text: controller.lastReadSurah.value,
                    children: [
                      TextSpan(
                        text: "\nAyat No: ${controller.lastReadAyat.value}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: whiteColor,
                    ),
                  )),
                )
              ],
            ),
          ),
          SizedBox(height: 24),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Surah',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: purpleColor,
              ),
            ),
          ),
          SizedBox(height: 10),
          Divider(
            height: 1,
            thickness: 2,
            color: purpleColor,
          ),
          Expanded(child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: controller.list.length,
              itemBuilder: (context, index) {
                return ListSurahItem(
                  nama: controller.list.value[index].nama,
                  namaLatin: controller.list.value[index].namaLatin,
                  jumlah_ayat:
                      controller.list.value[index].jumlahAyat.toString(),
                  nomor: controller.list.value[index].nomor.toString(),
                  turun: controller.list.value[index].tempatTurun,
                );
              },
            );
          }))
        ],
      ),
    );
  }

  Widget ListSurahItem({
    String? nama,
    String? namaLatin,
    String? nomor,
    String? jumlah_ayat,
    String? turun,
  }) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.DETAIL_SURAH, parameters: {
          'nomor_surah': nomor!,
        })!
            .then((_) => controller.getLastRead());
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Column(children: [
              Row(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset("assets/icon_ayat.png", width: 36),
                      Text(nomor!, style: TextStyle(color: purpleDarkColor)),
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(namaLatin!,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: purpleDarkColor)),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            turun!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: greyColor,
                            ),
                          ),
                          SizedBox(width: 5),
                          Image.asset("assets/icon_circle.png", width: 4),
                          SizedBox(width: 5),
                          Text(
                            '$jumlah_ayat Verses'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: greyColor),
                          ),
                        ],
                      )
                    ],
                  )),
                  Text(
                    nama!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: purpleColor,
                    ),
                  )
                ],
              )
            ]),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: greyColor,
          ),
        ],
      ),
    );
  }
}
