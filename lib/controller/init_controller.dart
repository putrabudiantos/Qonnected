import 'package:get/get.dart';
import 'package:qonnected_app/helper/alert.dart';
import 'package:qonnected_app/model/profile.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:shared_preferences/shared_preferences.dart';

class InitController extends GetxController {
  var isLoading = false.obs;
  var mainColor = 0xFF0D1037.obs;

  @override
  void onInit() {
    fetchInit();
    super.onInit();
  }

  fetchInit() async {
    final prefs = await SharedPreferences.getInstance();
    mainColor.value = int.parse(prefs.getString('mainColor')!);
  }
}
