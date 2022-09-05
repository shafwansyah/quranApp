import 'package:final_project/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController(text: 'test@pengg.com');
  TextEditingController passC = TextEditingController(text: 'admin123');
  RxBool isShowPassword = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  void showPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailC.text,
        password: passC.text,
      );
      Get.offAllNamed(Routes.MAINPAGE);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      print(e.code);
    } catch (e) {
      print(e.toString());
    }
  }

  void logout() async {
    await auth.signOut();
  }
}
