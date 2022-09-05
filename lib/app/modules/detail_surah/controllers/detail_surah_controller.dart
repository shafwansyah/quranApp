import 'dart:convert';

import 'package:final_project/app/models/ayat_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:just_audio/just_audio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();

  var nomor = Get.parameters['nomor_surah'];
  RxBool isLoading = false.obs;
  RxBool isPlaying = false.obs;

  Rx<ListAyat> listAyat = ListAyat().obs;

  @override
  void onInit() {
    super.onInit();
    getListAyat();
  }

  dio_package.Dio get dio => _dio();

  dio_package.Dio _dio() {
    var dio = dio_package.Dio(dio_package.BaseOptions(
      baseUrl: "https://equran.id/api/",
      contentType: "application/json;charset=utf-8",
    ));

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      compact: true,
    ));

    return dio;
  }

  Future<ListAyat> fetchAyat(String? nomor) async {
    dio_package.Response response = await dio.get("surat/$nomor");
    return ListAyat.fromJson(response.data);
  }

  getListAyat() async {
    isLoading.value = true;
    try {
      listAyat.value = await fetchAyat(nomor);
    } catch (e) {
      print('getListAyat: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void playAudio(String url) async {
    Get.snackbar("Success", "Audio being played");
    await player.setUrl(url);
    player.play();
    isPlaying.value = true;
  }

  void stopAudio() {
    Get.snackbar("Success", "Audio being paused");
    player.pause();
    isPlaying.value = false;
  }

  void lastRead(String nama, String nomor_ayat) async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.encode({
      "nama_surah": nama,
      'nomor_ayat': nomor_ayat,
    });
    prefs.setString('last_read', data);
    Get.snackbar("Success", "Last read saved succesfully");
  }
}
