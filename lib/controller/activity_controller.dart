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
  var checkOut = false.obs;
  var distanceInMeter = 0.obs;
  var distanceFar = false.obs;
  var timeCompany = ''.obs;
  var timeOffset = 0.obs;
  var address = ''.obs;
  var logId;

  @override
  void onInit() {
    fetchActivity();
    calculateDistance();
    getTimeCompany();
    super.onInit();
  }

  fetchActivity() async {
    final prefs = await SharedPreferences.getInstance();
    var date = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(DateTime.now().toLocal().toString()));
    var date1 = DateFormat('HH:mm')
        .format(DateTime.parse(DateTime.now().toLocal().toString()));
    checkOut.value = prefs.getBool('checkout')!;
    final response = await vars.client
        .from('activities')
        // .select()
        .select('*, profiles(fullname, email)')
        .eq('date', date)
        // .neq('category', 'wfo')
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

    // var distance = Geolocator.distanceBetween(
    //     lat!, long!, position.latitude, position.longitude);
    var distance = Geolocator.distanceBetween(
        lat!, long!, position.latitude, position.longitude);
    address.value = await GetAddressFromLatLong(position);

    print(position.latitude);
    print(position.longitude);
    print(distance);
    print(long);
    print(lat);
    var checkout = prefs.getBool('checkin');
    print(checkout);
    if (distance > 50) {
      distanceFar.value = true;
    } else {
      distanceFar.value = false;
    }
  }

  submitActivity(BuildContext context, String activity, String desc) async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    Position position = await _getGeoLocationPosition();
    var locationName = await GetAddressFromLatLong(position);
    var id = vars.client.auth.currentUser!.id;
    var checkin = prefs.getBool('checkin');
    var checkout = prefs.getBool('checkout');
    print(checkin);

    var time = DateFormat('HH:mm')
        .format(DateTime.parse(DateTime.now().toLocal().toString()));
    var date = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(DateTime.now().toLocal().toString()));

    if (checkin == null || checkin == false) {
      print('create act');

      final updates = {
        "worker_status": activity,
      };

      var res = await vars.client
          .from('profiles')
          .update(updates)
          .eq('id', id)
          .execute();

      print(res.data);
      if (res.status == 200 || res.status == 201) {
        var response = await _insertCheckinActivity(position.longitude,
            position.latitude, activity, locationName, desc, date, time);
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
          isLoading.value = false;
          checkIn.value = true;
          await prefs.setBool('checkin', true);
          Helper.alertDialog(
              context, '200', 'Berhasil Check In', true, '/initpage');
          vars.idx = 1;
          // } else {
          //   Helper.alertDialog(
          //       context, '400', 'Terjadi Kesalahan\nSilahkan Coba lagi', true);
          // }

        } else {
          isLoading.value = false;
          Helper.alertDialog(context, '400',
              'Terjadi Kesalahan\nSilahkan Coba lagi ', true, '/activity');
          print(response.error);
        }
      } else {
        Helper.alertDialog(context, '400',
            'Terjadi Kesalahan\nSilahkan Coba lagi ', true, '/activity');
        print(res.error);
      }
    } else if (checkin == true) {
      print('edit act');
      await prefs.setBool('checkout', true);
      var response = await _insertCheckoutActivity(position.longitude,
          position.latitude, activity, locationName, desc, date, time);

      print(response);
      if (response == 200 || response == 201) {
        isLoading.value = false;
        checkOut.value = true;
        vars.idx = 1;
        Helper.alertDialog(
            context, '200', 'Berhasil Check Out', true, '/initpage');
      } else {
        isLoading.value = false;
        Helper.alertDialog(context, '400',
            'Terjadi Kesalahan\nSilahkan Coba lagi 1', true, '/activity');
        print(response.error);
      }
    }
  }

  Future _insertCheckinActivity(double long, double lat, String activity,
      String location, String desc, var date, var time) async {
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
      "checkin_time": time,
      "date": date
    };

    final response =
        await vars.client.from('activities').insert([data]).execute();
    await prefs.setString('idAct', response.data[0]['id'].toString());
    print(response.data);
    return response.status;
  }

  Future _insertCheckoutActivity(double long, double lat, String activity,
      String location, String desc, var date, var time) async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('idAct');

    final data = {
      "checkout": true,
      "location_checkout": location,
      "longitude_checkout": long,
      "latitude_checkout": lat,
      "checkout_time": time,
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

  getTimeCompany() async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('idCompany');
    var res = await vars.client
        .from('company_group')
        .select('*,work_type_id(*)')
        .eq('id', id)
        .execute();

    if (res.status == 200) {
      timeCompany.value = res.data[0]['work_type_id']['time_in'];
      timeOffset.value = res.data[0]['work_type_id']['time_in_offset'];
    }
  }
}
