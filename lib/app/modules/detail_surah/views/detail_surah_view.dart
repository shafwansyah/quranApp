import 'package:final_project/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              if (controller.isPlaying.value) {
                controller.stopAudio();
              }

              Get.back();
            },
            icon: Icon(
              Icons.chevron_left_outlined,
              color: greyColor,
              size: 28,
            )),
        title: Text(
          'Quran App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: purpleColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Container(
                height: 257,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage("assets/frame_surah_detail.png"),
                        fit: BoxFit.cover)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: controller.listAyat.value.namaLatin,
                          children: [
                            TextSpan(
                                text: '\n${controller.listAyat.value.arti}',
                                style: TextStyle(fontSize: 16)),
                          ],
                          style: TextStyle(fontSize: 26, color: whiteColor),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: 200,
                        child: Divider(
                          color: whiteColor,
                          height: 1,
                          thickness: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.listAyat.value.tempatTurun
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                            ),
                          ),
                          SizedBox(width: 5),
                          Image.asset("assets/icon_circle.png", width: 4),
                          SizedBox(width: 5),
                          Text(
                            '${controller.listAyat.value.jumlahAyat} Verses'
                                .toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: whiteColor),
                          ),
                          SizedBox(width: 20),
                          IconButton(
                              onPressed: () {
                                controller.isPlaying.value
                                    ? controller.stopAudio()
                                    : controller.playAudio(controller
                                        .listAyat.value.audio
                                        .toString());
                              },
                              icon: Icon(
                                controller.isPlaying.value
                                    ? Icons.stop_circle_outlined
                                    : Icons.play_circle_outline_rounded,
                                size: 24,
                                color: whiteColor,
                              ))
                        ],
                      ),
                      SizedBox(height: 24),
                      Image.asset(
                        "assets/icon_basmalah.png",
                        width: 214,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: controller.listAyat.value.jumlahAyat,
                        itemBuilder: (context, index) {
                          return ListAyatItem(
                            context: context,
                            namaLatin: controller.listAyat.value.namaLatin,
                            nomorSurah:
                                controller.listAyat.value.nomor.toString(),
                            ar: controller.listAyat.value.ayat![index].ar,
                            nomor: controller.listAyat.value.ayat![index].nomor
                                .toString(),
                            idn: controller.listAyat.value.ayat![index].idn,
                          );
                        },
                      ),
              ),
              SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }

  Widget ListAyatItem({
    String? nomor,
    String? ar,
    String? idn,
    String? con,
    String? namaLatin,
    String? nomorSurah,
    required BuildContext context,
  }) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: Container(
                      color: purpleColor,
                      width: 27,
                      height: 27,
                      child: Center(
                        child: Text(
                          nomor!,
                          style: TextStyle(color: whiteColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.lastRead(
                                  namaLatin!, nomor, nomorSurah);
                            },
                            icon: Icon(
                              Icons.bookmark_outline,
                              size: 24,
                              color: purpleColor,
                            ))
                      ],
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  ar!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Mequran'),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  idn!,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[200],
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
