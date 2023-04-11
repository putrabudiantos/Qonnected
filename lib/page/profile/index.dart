import 'package:flutter/material.dart';
import 'package:qonnected_app/controller/init_controller.dart';
import 'package:qonnected_app/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/page/widget/bottom_navigation.dart';
import 'package:qonnected_app/page/widget/field_text.dart';

class IndexProfile extends StatelessWidget {
  final profileC = Get.put(ProfileController());
  final InitController initC = Get.put(InitController());

  IndexProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: const Image(
              fit: BoxFit.cover,
              width: 80,
              height: 80,
              image: NetworkImage(
                  'https://marketplace.canva.com/EAEeKH905XY/2/0/1600w/canva-yellow-and-black-gamer-grunge-twitch-profile-picture-Yf5RCMJroQI.jpg'),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          form(context)
        ],
      )),
      floatingActionButton: Obx(() => FloatingActionButton(
            backgroundColor: Color(initC.mainColor.value),
            onPressed: () async {
              //  String? barcode = await scanner.scan();
              //  print(barcode);

              // HelperSharedPreferences.refreshStorage();
              // print(prefs.getBool('checkin'));
            },
            child: const Icon(Icons.qr_code_scanner), //icon inside button
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavWidget(),
    );
  }

  Widget form(BuildContext context) {
    profileC.nameController.value.text =
        profileC.coworkersModel.value!.fullname!;
    profileC.phoneController.value.text = profileC.coworkersModel.value!.phone!;
    profileC.emailController.value.text = profileC.coworkersModel.value!.email!;
    // profileC.identityController.value.text =
    //     profileC.coworkersModel.value!.identity_number!;
    // profileC.identityEmployeeController.value.text =
    //     profileC.coworkersModel.value!.employee_identification!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Obx(() => FieldText(
                customController: profileC.nameController.value,
                customType: false,
                errorMessage: '',
                placeholder: '',
                readonly: true,
                textfield: 'Name',
              )),
          const SizedBox(
            height: 20,
          ),
          Obx(() => FieldText(
                customController: profileC.phoneController.value,
                customType: false,
                errorMessage: '',
                placeholder: '',
                readonly: true,
                textfield: 'Phone',
              )),
          const SizedBox(
            height: 20,
          ),
          Obx(() => FieldText(
                customController: profileC.emailController.value,
                customType: false,
                errorMessage: '',
                placeholder: '',
                readonly: true,
                textfield: 'Email',
              )),
          const SizedBox(
            height: 20,
          ),
          Obx(() => FieldText(
                customController: profileC.identityController.value,
                customType: false,
                errorMessage: '',
                placeholder: '',
                readonly: true,
                textfield: 'No KTP',
              )),
          const SizedBox(
            height: 20,
          ),
          Obx(() => FieldText(
                customController: profileC.identityEmployeeController.value,
                customType: false,
                errorMessage: '',
                placeholder: '',
                readonly: true,
                textfield: 'No Karyawan',
              )),
        ],
      ),
    );
  }
}
