import 'package:get/get.dart';
import 'package:qonnected_app/model/profile.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoWorkersController extends GetxController {
  var isLoading = false.obs;
  var coworkersModel = <ProfileModel>[].obs;
  var statusCoWorker = '';
  var companyName = ''.obs;

  @override
  void onInit() {
    fetchCoworkers();
    getCompany();
    super.onInit();
  }

  fetchCoworkers() async {
    final prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getInt('idCompany');
    final response = await vars.client
        .from('profiles')
        .select()
        .eq('company_group_id', companyId)
        .execute();
    if (response.status == 200) {
      List jsonResponse = response.data;

      coworkersModel.value =
          jsonResponse.map((e) => ProfileModel.fromJson(e)).toList();
    } else {
      Get.snackbar('Error Loading data!',
          'Sever responded: ${response.status}:${response.error}');
    }
  }

  getCompany() async {
    final prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getInt('idCompany');
    final response = await vars.client
        .from('company_group')
        .select()
        .eq('id', companyId)
        .execute();
    if (response.status == 200) {
      companyName.value = response.data[0]['name'];
    } else {
      companyName.value = '-';
    }
  }

  getActivity(var id) async {
    var date = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(DateTime.now().toLocal().toString()));
    final response = await vars.client
        .from('activities')
        .select()
        .eq('profile_id', id)
        .eq('date', date)
        .execute();
    print('aaa');
    if (response.status == 200) {
      print(response.data[0]['category']);
      statusCoWorker = response.data[0]['category'];
    } else {
      statusCoWorker = '';
    }
    print(statusCoWorker);
    // return response.data['category'];
  }
}
