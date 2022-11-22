import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qonnected_app/helper/alert.dart';
import 'package:qonnected_app/model/profile.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var coworkersModel = <ProfileModel>[].obs;
  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var identityController = TextEditingController().obs;
  var identityEmployeeController = TextEditingController().obs;

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
    nameController.value = TextEditingController();
    emailController.value = TextEditingController();
    phoneController.value = TextEditingController();
    identityController.value = TextEditingController();
    identityEmployeeController.value = TextEditingController();
  }

  @override
  void onClose() {
    nameController.value.dispose();
    emailController.value.dispose();
    phoneController.value.dispose();
    identityController.value.dispose();
    identityEmployeeController.value.dispose();
    super.onClose();
  }

  fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    var id = vars.client.auth.currentUser!.id;
    final response =
        await vars.client.from('profiles').select().eq('id', id).execute();
    print(response.data);
    if (response.status == 200) {
      List jsonResponse = response.data;

      coworkersModel.value =
          jsonResponse.map((e) => ProfileModel.fromJson(e)).toList();
    } else {
      Get.snackbar('Error Loading data!',
          'Sever responded: ${response.status}:${response.error}');
    }
  }

  SignOut(BuildContext context) async {
    final response = await vars.client.auth.signOut();
    final error = response.error;
    print('Logout');
    if (error != null) {
    } else {
      Get.offAll(LoginPage());
    }
  }
}
