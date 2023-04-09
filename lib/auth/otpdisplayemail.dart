import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPScreenEmail extends StatefulWidget {
  final String? emailtujuan;
  const OTPScreenEmail({Key? key, this.emailtujuan}) : super(key: key);

  @override
  State<OTPScreenEmail> createState() => _OTPScreenEmailState();
}

class _OTPScreenEmailState extends State<OTPScreenEmail> {
  String finalotp = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          children: [
            const Text("Verification Code",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const Text("Kami telah mengirimkan kode OTP ke email tujuan"),
            Row(
              children: [
                if (widget.emailtujuan != null)
                  Text("${widget.emailtujuan}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ganti email?"))
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
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    });
              }, // end onSubmit
            ),
          ],
        ),
      ),
    );
  }
}
