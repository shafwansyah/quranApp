import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxBool isShowPassword = false.obs;
  RxBool isLoading = false.obs;

  void showPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void signUp() async {
    isLoading.value = true;
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
      Get.snackbar("Success", "Register Succesfully");
      Get.offAllNamed(Routes.MAINPAGE);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Get.snackbar("Failed",
            "The password provided is too weak, at least 6 characters");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Failed", "he account already exists for that email.");
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      Get.snackbar("Failed", "Register Failed");
    } finally {
      isLoading.value = false;
    }
  }
}
