import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:qonnected_app/helper/alert.dart';
import 'package:qonnected_app/model/profile/profile.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var coworkersModel = Rxn<ProfileModel>();
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
    var headers = {
      'Authorization': 'Token adCrbmpXTUpcMokI7OkivNC71QgsV067',
      'Cookie':
          'route=1681096813.535.308.981237|1f6839247221289d5dff78ead76ea2bb'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.baserow.io/api/database/rows/table/154795/1/?user_field_names=true'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((value) {
        var jsonResponse = json.decode(value);

        print("data 1 : ${jsonResponse['worker_status']['id']}");

        coworkersModel.value =
            jsonResponse.map((e) => ProfileModel.fromJson(e));

        print(coworkersModel.value);
      });
    } else {
      print("B");
      print(response.reasonPhrase);
    }
  }

  signOut(BuildContext context) async {
    final response = await vars.client.auth.signOut();
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    final error = response.error;
    print('Logout');
    if (error != null) {
    } else {
      Get.offAll(const LoginPage());
    }
  }
}
