import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;

class AuthController extends GetxController {
  var isLoading = false.obs;
  var logId;

  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var usernameController = TextEditingController().obs;
  var walletController = TextEditingController().obs;
  var banknameController = TextEditingController().obs;
  var banktypeController = TextEditingController().obs;
  var norekeningController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var refferalController = TextEditingController().obs;
  var name1Controller = TextEditingController().obs;
  var username1Controller = TextEditingController().obs;
  var email1Controller = TextEditingController().obs;
  var phone1Controller = TextEditingController().obs;
  // late TextEditingController nameController ;
  // late TextEditingController emailController;
  // late TextEditingController phoneController;
  // late TextEditingController usernameController;
  // late TextEditingController walletController;
  // late TextEditingController banknameController;
  // late TextEditingController banktypeController;
  // late TextEditingController norekeningController;
  // late TextEditingController passwordController;
  // late TextEditingController emailController1;

  void check() {
    final user = vars.client.auth;

    if (user == null) {
      logId = null;
    } else {
      logId = user.currentUser?.id;
    }
  }

  @override
  void onInit() {
    check();
    super.onInit();

    nameController.value = TextEditingController();
    emailController.value = TextEditingController();

    phoneController.value = TextEditingController();
    usernameController.value = TextEditingController();
    walletController.value = TextEditingController();
    banknameController.value = TextEditingController();
    banktypeController.value = TextEditingController();
    norekeningController.value = TextEditingController();
    passwordController.value = TextEditingController();
    refferalController.value = TextEditingController();
    name1Controller.value = TextEditingController();
    username1Controller.value = TextEditingController();
    email1Controller.value = TextEditingController();
    phone1Controller.value = TextEditingController();
  }

  @override
  void onClose() {
    nameController.value.dispose();
    emailController.value.dispose();
    phoneController.value.dispose();
    usernameController.value.dispose();
    walletController.value.dispose();
    banknameController.value.dispose();
    banktypeController.value.dispose();
    norekeningController.value.dispose();
    passwordController.value.dispose();
    refferalController.value.dispose();
    name1Controller.value.clear();
    username1Controller.value.clear();
    email1Controller.value.clear();
    phoneController.value.clear();
    super.onClose();
  }

  _Login(BuildContext context, TextEditingController email) async {
    final response = await vars.client.auth.signIn(
        email: email.text,
        options: AuthOptions(
            redirectTo: kIsWeb
                ? null
                : 'io.supabase.flutterquickstart://login-callback/'));
    final error = response.error;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check your email for login link!')),
      );

      email.clear();
    }
    print(email.text);
    print(response.data);
    // return Navigator.pushAndRemoveUntil(
    //     context,
    //     PageTransition(type: PageTransitionType.fade, child: SignUpPage()),
    //     (Route<dynamic> route) => false);
  }

  void SignUp(BuildContext context) async {
    var pwd =
        "${nameController.value.text}@${DateTime.now().millisecondsSinceEpoch}";
    isLoading.value = true;
    final reslt = await vars.client.auth
        .signUp(email1Controller.value.text, pwd, userMetadata: {
      "fullname": name1Controller.value.text,
      "username": username1Controller.value.text,
      "mobile_number": phone1Controller.value.text,
      "refferal_code": refferalController.value.text
    });

    if (reslt.statusCode == 200) {
      isLoading.value = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: const Text('Register Success')));

      // Navigator.pushNamedAndRemoveUntil(
      //     context, LoginPage.routeName, ModalRoute.withName('/'));
    } else {
      isLoading.value = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Register Failed')),
      );
    }
    print(reslt.statusCode);
  }

  SignOut(BuildContext context) async {
    final response = await vars.client.auth.signOut();
    final error = response.error;
    print('Logout');
    if (error != null) {
    } else {
      // Navigator.pushNamedAndRemoveUntil(
      //     context, LoginPage.routeName, ModalRoute.withName('/'));
    }
  }
}
