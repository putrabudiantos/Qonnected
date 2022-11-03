import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qonnected_app/helper/alert.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;

class AuthController extends GetxController {
  var isLoading = false.obs;
  var logId;

  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var usernameController = TextEditingController().obs;
  var banknameController = TextEditingController().obs;
  var banktypeController = TextEditingController().obs;
  var norekeningController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
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

    banknameController.value = TextEditingController();
    banktypeController.value = TextEditingController();
    norekeningController.value = TextEditingController();
    passwordController.value = TextEditingController();
  }

  @override
  void onClose() {
    nameController.value.dispose();
    emailController.value.dispose();
    phoneController.value.dispose();
    usernameController.value.dispose();

    banknameController.value.dispose();
    banktypeController.value.dispose();
    norekeningController.value.dispose();
    passwordController.value.dispose();

    phoneController.value.clear();
    emailController.value.clear();
    super.onClose();
  }

  login(BuildContext context, TextEditingController email) async {
    isLoading.value = true;
    final response = await vars.client.auth.signIn(
        email: email.text,
        options: AuthOptions(
            redirectTo: kIsWeb
                ? null
                : 'io.supabase.flutterquickstart://login-callback/'));
    final error = response.error;
    if (error != null) {
      isLoading.value = false;
      Helper.alertDialog(context, '400', error.message, true,'/login');
    } else {
      isLoading.value = false;
      Helper.alertDialog(
          context, '200', 'Check your email for login link!', true, '/login');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Check your email for login link!')),
      // );

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
    isLoading.value = true;
    var pwd =
        "${nameController.value.text}@${DateTime.now().millisecondsSinceEpoch}";

    final reslt = await vars.client.auth.signUp(emailController.value.text, pwd,
        userMetadata: {
          "fullname": nameController.value.text,
          "username": usernameController.value.text
        });

    if (reslt.statusCode == 200) {
      isLoading.value = false;
      Helper.alertDialog(context, '200', 'Register Berhasil', false,'/login');
    
    } else {
      isLoading.value = false;
      Helper.alertDialog(context, '400', 'Register Failed', true, '/login');
    }
    print(reslt.error);
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
