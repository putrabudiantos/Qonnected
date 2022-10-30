import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qonnected_app/helper/alert.dart';
import 'package:qonnected_app/model/activity.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityController extends GetxController {
  var activityModel = <ActivityModel>[].obs;
  var isLoading = false.obs;
  var checkIn = false.obs;
  var distanceInMeter = 0.obs;
  var distanceFar = false.obs;
  var logId;

  @override
  void onInit() {
    fetchActivity();
    calculateDistance();
    super.onInit();
  }

  fetchActivity() async {
    var date = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(DateTime.now().toLocal().toString()));
    final response = await vars.client
        .from('activities')
        // .select()
        .select('*, profiles(fullname, email)')
        .eq('date', date)
        .neq('category', 'wfo')
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

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> GetAddressFromLatLong(Position position) async {
    var Address;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    // print(Address);
    return Address;
  }

  calculateDistance() async {
    final prefs = await SharedPreferences.getInstance();
    var long = prefs.getDouble('longCompany');
    var lat = prefs.getDouble('latCompany');
    Position position = await _getGeoLocationPosition();

    var distance = Geolocator.distanceBetween(
        lat!, long!, position.latitude, position.longitude);
    if (distance > 50) {
      distanceFar.value = true;
    } else {
      distanceFar.value = false;
    }
  }

  submitActivity(BuildContext context, String activity, String desc) async {
    final prefs = await SharedPreferences.getInstance();
    Position position = await _getGeoLocationPosition();
    var locationName = await GetAddressFromLatLong(position);
    var id = vars.client.auth.currentUser!.id;
    var checkin = prefs.getBool('checkin');
    var checkout = prefs.getBool('checkout');
    print(checkin);

    isLoading.value = true;

    var date = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(DateTime.now().toLocal().toString()));

    if (checkin == null || checkin == false) {
      print('create act');
      await prefs.setBool('checkin', true);
      final updates = {
        "worker_status": activity,
      };

      var res = await vars.client
          .from('profiles')
          .update(updates)
          .eq('id', id)
          .execute();

      var response = await _insertCheckinActivity(position.longitude,
          position.latitude, activity, locationName, desc, date);
      if (response == 200 || response == 201) {
        // var dataAct = {
        //   'message':
        //       '_username7 Checked in. #Q_adikarya_username7 #Q_Checkin #Q_102022'
        // };
        // var msg = 'testing  - ${activity} - long:${long} lat:${lat} ';
        // var postAct = await http.post(
        //     Uri.parse(
        //         'https://hook.eu1.make.com/u7dj2vkwusaz1x9cdwv8gzm1d8lmrn19'),
        //     body: dataAct);

        // print(postAct.body);
        // if (postAct.statusCode == 200) {
        //   isLoading.value = false;
        //   Helper.alertDialog(context, '200', 'Berhasil Check In', true);
        // } else {
        //   Helper.alertDialog(
        //       context, '400', 'Terjadi Kesalahan\nSilahkan Coba lagi', true);
        // }
        isLoading.value = false;
        checkIn.value = true;
        Helper.alertDialog(context, '200', 'Berhasil Check In', true);
      } else {
        isLoading.value = false;
        Helper.alertDialog(
            context, '400', 'Terjadi Kesalahan\nSilahkan Coba lagi 1', true);
        print(response.error);
      }
    } else if (checkin == true) {
      print('edit act');
      await prefs.setBool('checkout', false);
      var response = await _insertCheckoutActivity(position.longitude,
          position.latitude, activity, locationName, desc, date);

      print(response);
      if (response == 200 || response == 201) {
        isLoading.value = false;
        checkIn.value = false;
        Helper.alertDialog(context, '200', 'Berhasil Check Out', true);
      } else {
        isLoading.value = false;
        Helper.alertDialog(
            context, '400', 'Terjadi Kesalahan\nSilahkan Coba lagi 1', true);
        print(response.error);
      }
    }
  }

  Future _insertCheckinActivity(double long, double lat, String activity,
      String location, String desc, var date) async {
    final prefs = await SharedPreferences.getInstance();
    var id = vars.client.auth.currentUser!.id;
    final data = {
      "profile_id": id,
      "description": desc,
      "location_checkin": location,
      "longitude_checkin": long,
      "latitude_checkin": lat,
      "category": activity,
      "checkin": true,
      "date": date
    };

    final response =
        await vars.client.from('activities').insert([data]).execute();
    await prefs.setString('idAct', response.data[0]['id'].toString());
    print(response.data);
    return response.status;
  }

  Future _insertCheckoutActivity(double long, double lat, String activity,
      String location, String desc, var date) async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('idAct');
    final data = {
      "checkout": true,
      "location_checkout": location,
      "longitude_checkout": long,
      "latitude_checkout": lat,
      "category": activity,
    };

    final response = await vars.client
        .from('activities')
        .update(data)
        .eq('id', id)
        .execute();
    print(response.data);
    return response.status;
  }
}
