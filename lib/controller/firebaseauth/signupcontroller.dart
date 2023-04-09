import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/controller/firebaseauth/authrepo/authenticationrepository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final phonecontroller = TextEditingController();
  final emailcontroller = TextEditingController();

  void registerUserEmail({String? email}) {
    String? error = AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email: email, password: "") as String;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }

  void phoneAuthentication(String phone) {
    AuthenticationRepository.instance.phoneAuthentication(phone);
  }
}
