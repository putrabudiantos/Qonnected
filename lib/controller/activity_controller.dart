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

  @override
  void onInit() {
    super.onInit();
  }

  submitActivity(BuildContext context) async {
    var id = vars.client.auth.currentUser!.id;
    final data = {
      "profile_id": id,
      "description": '',
      "type": "check-in",
      "location": 'today',
      "longitude": 1.2,
      "latitude": 1.2,
      "category": 'WFO',
      "date": '2022-11-10'
    };

    final response =
        await vars.client.from('activities').insert([data]).execute();
    if (response.status == 200) {
      Helper.alertDialog(context, '200', 'Berhasil Check In', true);
    } else {
      Helper.alertDialog(
          context, '400', 'Terjadi Kesalahan\nSilahkan Coba lagi', true);
    }
  }
}
