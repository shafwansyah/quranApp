import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController(text: 'test@pengg.com');
  TextEditingController passC = TextEditingController(text: 'admin123');

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxBool isShowPassword = false.obs;

  void showPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void signUp() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailC.text,
        password: passC.text,
      );

      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'fullname': nameC.text,
        'email': emailC.text,
        'uid': userCredential.user!.uid,
        'created_at': DateTime.now().toIso8601String(),
      });

      Get.offAllNamed(Routes.MAINPAGE);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
