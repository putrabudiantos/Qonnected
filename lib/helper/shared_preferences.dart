import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;

class StorageSharedPreferences {


  static StorageProfile() async {
    final prefs = await SharedPreferences.getInstance();
    var id = vars.client.auth.currentUser!.id;
    final response = await vars.client
        .from('profiles')
        .select('*, company_group(*)')
        .eq('id', id)
        .execute();

    await prefs.setInt('idCompany', response.data[0]['company_group_id']);
    await prefs.setString('mainColor', response.data[0]['company_group']['main_color']);
    await prefs.setString('secondaryColor', response.data[0]['company_group']['secondary_color']);
    await prefs.setDouble('longCompany', response.data[0]['company_group']['longitude']);
    await prefs.setDouble('latCompany', response.data[0]['company_group']['latitude']);
    // print(response.data[0]['company_group_id']);
    // print(response.data[0]['company_group']['main_color']);
  }
}