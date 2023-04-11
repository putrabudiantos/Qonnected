import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/controller/firebaseauth/authrepo/authenticationrepository.dart';
import '../controller/firebaseauth/signupcontroller.dart';
import '../page/login.dart';
import 'emaillogin.dart';
import 'otpdisplaynomor.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final _formKey = GlobalKey<FormState>();
  final phonecontroller = TextEditingController();

  @override
  void dispose() {
    phonecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    String finalnumber = "";
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 200,
                  width: 250,
                ),
                const Text(
                  "Masukan nomor HP\nuntuk login ke Dashboard",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 25),
                IntlPhoneField(
                  controller: controller.phonecontroller,
                  initialCountryCode: "ID",
                  decoration: InputDecoration(
                      hintText: "Nomor",
                      label: const Text("Nomor"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onChanged: (phone) {
                    finalnumber = phone.completeNumber;
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ' + country.name);
                  },
                ),
                const SizedBox(height: 30),
                const Text(
                    "Kami akan mengirimkan anda kode OTP ke nomor yang anda inputkan",
                    textAlign: TextAlign.center),
                const SizedBox(height: 30),
                // TextButton(
                //     onPressed: () {
                //       Get.to(const EmailLogin());
                //     },
                //     child: const Text('Login dengan email?')),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.validate();
                      if (finalnumber.length > 11) {
                        SignUpController.instance
                            .phoneAuthentication(finalnumber);
                        Get.to(() => const OTPScreenNomor());
                        // AuthenticationRepository.instance
                        //     .phoneAuthentication(phonecontroller.text.trim());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(50, 50),
                        padding: const EdgeInsets.only(top: 17, bottom: 17),
                        primary: const Color(0xFF0D1037)),
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
