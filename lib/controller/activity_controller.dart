import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qonnected_app/helper/alert.dart';
import 'package:qonnected_app/model/activity.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:intl/intl.dart';

class ActivityController extends GetxController {
  var activityModel = <ActivityModel>[].obs;
  var isLoading = false.obs;
  var logId;

  @override
  void onInit() {
    fetchActivity();
    super.onInit();
  }

  fetchActivity() async {
    var date = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(DateTime.now().toLocal().toString()));
    final response = await vars.client
        .from('activities')
        .select()
        // .select('*, profiles(fullname, email)')
        .eq('date', date)
        .execute();
    print(response.data);
    if (response.status == 200) {
      List jsonResponse = response.data;

      activityModel.value =
          jsonResponse.map((e) => ActivityModel.fromJson(e)).toList();
    } else {
      Get.snackbar('Error Loading data!',
          'Sever responded: ${response.status}:${response.error}');
    }
  }

  submitActivity(BuildContext context, double long, double lat, String activity,
      String location, String desc) async {
    isLoading.value = true;
    var id = vars.client.auth.currentUser!.id;
    var date = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(DateTime.now().toLocal().toString()));

    final updates = {
      "worker_status": activity,
    };
    isLoading.value = true;
    var res = await vars.client
        .from('profiles')
        .update(updates)
        .eq('id', id)
        .execute();

    final data = {
      "profile_id": id,
      "description": desc,
      "type": "checkin",
      "location": location,
      "longitude": long,
      "latitude": lat,
      "category": activity,
      "date": date
    };

    print('apaa' + date);
    final response =
        await vars.client.from('activities').insert([data]).execute();
    print(response.status);
    if (response.status == 200 || response.status == 201) {
      var dataAct = {
        'message':
            '_username7 Checked in. #Q_adikarya_username7 #Q_Checkin #Q_102022'
      };
      var msg = 'testing  - ${activity} - long:${long} lat:${lat} ';
      var postAct = await http.post(
          Uri.parse(
              'https://hook.eu1.make.com/u7dj2vkwusaz1x9cdwv8gzm1d8lmrn19'),
          body: dataAct);

      print(postAct.body);
      if (postAct.statusCode == 200) {
        isLoading.value = false;
        Helper.alertDialog(context, '200', 'Berhasil Check In', true);
      } else {
        Helper.alertDialog(
            context, '400', 'Terjadi Kesalahan\nSilahkan Coba lagi', true);
      }
    } else {
      isLoading.value = false;
      Helper.alertDialog(
          context, '400', 'Terjadi Kesalahan\nSilahkan Coba lagi 1', true);
      print(response.error);
    }
  }
}
