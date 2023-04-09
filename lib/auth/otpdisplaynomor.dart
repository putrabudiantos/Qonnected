import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:qonnected_app/controller/firebaseauth/otpcontroller.dart';

import '../controller/firebaseauth/signupcontroller.dart';

class OTPScreenNomor extends StatefulWidget {
  final String? nomortujuan;

  const OTPScreenNomor({Key? key, this.nomortujuan}) : super(key: key);

  @override
  State<OTPScreenNomor> createState() => _OTPScreenNomorState();
}

class _OTPScreenNomorState extends State<OTPScreenNomor> {
  @override
  Widget build(BuildContext context) {
    var otpController = Get.put(OTPController());
    final controller = Get.put(SignUpController());
    var otp;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          children: [
            const Text("Verification Code",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const Text("Kami telah mengirimkan kode OTP ke nomor tujuan"),
            Row(
              children: [
                Text(controller.phonecontroller.text,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ganti nomor?")),
              ],
            ),
            OtpTextField(
              margin: const EdgeInsets.only(right: 10),
              numberOfFields: 6,
              borderColor: const Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                otp = verificationCode;
                OTPController.instance.verifyOTP(otp);
                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return AlertDialog(
                //         title: const Text("Verification Code"),
                //         content: Text('Code entered is $verificationCode'),
                //       );
                //     });
              }, // end onSubmit
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  OTPController.instance.verifyOTP(otp);
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(50, 50),
                    padding: const EdgeInsets.only(top: 17, bottom: 17),
                    primary: const Color(0xFF0D1037)),
                child:
                    const Text("Submit", style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
