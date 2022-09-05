import 'package:final_project/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isShowPassword = false.obs;
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  void showPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void login() async {
    isLoading.value = true;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailC.text,
        password: passC.text,
      );
      Get.snackbar('Success', 'Login Succesfully');
      Get.offAllNamed(Routes.MAINPAGE);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar('Failed', 'User not found');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.snackbar('Failed', 'Wrong Password');
      }
      print(e.code);
    } catch (e) {
      print(e.toString());
      Get.snackbar('Failed', 'Login Failed');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    await auth.signOut();
    Get.snackbar('Succes', 'Logout Succesfully');
  }
}
