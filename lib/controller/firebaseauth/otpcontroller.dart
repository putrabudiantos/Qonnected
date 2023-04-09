import 'package:get/get.dart';
import 'package:qonnected_app/controller/firebaseauth/authrepo/authenticationrepository.dart';
import 'package:qonnected_app/page/initial_page.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const InitialPage()) : Get.back();
  }
}
