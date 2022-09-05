import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:final_project/app/models/ayat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:final_project/app/modules/mainpage/list_surah_model.dart';
import '../../../models/surah_model.dart';
import 'package:final_project/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MainpageController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var list = [].obs;

  String? uid;
  RxInt selectedItem = 0.obs;
  RxBool isLoading = false.obs;
  RxString lastReadSurahId = "".obs;
  RxString lastReadSurah = "No data".obs;
  RxString lastReadAyat = "No data".obs;

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

  Stream<User?> get streamUser => auth.authStateChanges();
  dio_package.Dio get dio => _dio();

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchUser() async* {
    if (uid != null) {
      yield* firestore.collection('users').doc(uid).snapshots();
    }
  }

  Future<List<ListSurah>> fetchSurah() async {
    dio_package.Response response = await dio.get("surat/");
    return listSurahFromJson(json.encode(response.data));
  }

  Future<void> getLastRead() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('last_read')) {
      print("prefs ADA");
      final data = json.decode(prefs.getString('last_read')!);
      lastReadSurahId.value = data['nomor_surah'];
      lastReadSurah.value = data['nama_surah'];
      lastReadAyat.value = data['nomor_ayat'];
    }
  }

  void getListSurah() async {
    isLoading.value = true;
    try {
      list.value = await fetchSurah();
    } catch (e) {
      print('getListSurah() : ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  FutureOr checkUserLogin() async {
    try {
      streamUser.listen((User? _user) {
        if (_user != null) {
          uid = _user.uid;
        } else {
          Get.offAllNamed(Routes.LOGIN);
        }
      });
    } catch (e) {
      print('error profile-page: ${e.toString()}');
    }
  }

  void navbarItemTap(int value) async {
    if (value == 1) {
      await checkUserLogin();
    }
    selectedItem.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    getListSurah();
    getLastRead();
  }
}
