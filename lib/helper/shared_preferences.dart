import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;

class HelperSharedPreferences {
  static StorageProfile() async {
    final prefs = await SharedPreferences.getInstance();
    var id = vars.client.auth.currentUser!.id;
    final response = await vars.client
        .from('profiles')
        .select('*, company_group(*)')
        .eq('id', id)
        .execute();

    await prefs.setInt('idCompany', response.data[0]['company_group_id']);
    await prefs.setString(
        'mainColor', response.data[0]['company_group']['main_color']);
    await prefs.setString(
        'secondaryColor', response.data[0]['company_group']['secondary_color']);
    await prefs.setDouble(
        'longCompany', response.data[0]['company_group']['longitude']);
    await prefs.setDouble(
        'latCompany', response.data[0]['company_group']['latitude']);
    // print(response.data[0]['company_group_id']);
    // print(response.data[0]['company_group']['main_color']);
  }

  static refreshStorage() async {
    final prefs = await SharedPreferences.getInstance();
    var id = vars.client.auth.currentUser!.id;
    var lastDate = new DateTime.now().toLocal();
    var lastDate1 =
        new DateTime(lastDate.year, lastDate.month, lastDate.day - 1);
    var datelast = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(lastDate1.toLocal().toString()));
    var dateNow = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(DateTime.now().toLocal().toString()));
    // print(date);
    final response = await vars.client
        .from('activities')
        .select()
        .eq('profile_id', id)
        .eq('date', datelast)
        .execute();

    final responsedateNow = await vars.client
        .from('activities')
        .select()
        .eq('profile_id', id)
        .eq('date', dateNow)
        .execute();

    if (response.count! > 0) {
      if (responsedateNow.count! == 0) {
        await prefs.setBool('checkin', false);
        await prefs.setBool('checkout', false);
      }
    }
  }
}
