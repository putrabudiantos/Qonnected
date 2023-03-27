import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:qonnected_app/login/resetpassword.dart';

class EnterOTP extends StatefulWidget {
  const EnterOTP({super.key});

  @override
  State<EnterOTP> createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  final otpC = TextEditingController();
  String code = '1234';

  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 5);
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // do something
    //   startTimer();
    // });
  }

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(days: 5));
  }

  // Step 6
  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void dispose() {
    otpC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(myDuration.inSeconds.remainder(10));
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.blue.shade900),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              Image.asset(
                'assets/images/otp.png',
                scale: 1.5,
              ),
              const Text(
                'Enter OTP',
                maxLines: 1,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Masukkan kode OTP yang telah dikirim ke email anda.',
                style: TextStyle(
                  fontFamily: "Inter",
                  color: Colors.black45,
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              TextField(
                controller: otpC,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIconColor: Colors.blue.shade900,
                    hintStyle:
                        const TextStyle(fontFamily: "Inter", fontSize: 16),
                    prefixIcon: const Icon(Icons.key),
                    hintText: "Masukkan kode OTP"),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(seconds),
                ],
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  primary: Colors.blue.shade900,
                  onPrimary: Colors.white,
                  shadowColor: Colors.blue.shade200,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  minimumSize: const Size(100, 40), //////// HERE
                ),
                onPressed: () {
                  if (otpC.text.isEmpty) {
                    final snackBar = SnackBar(
                      content: const Text('Kode OTP tidak boleh kosong!'),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  if (otpC.text != code) {
                    final snackBar = SnackBar(
                      content: const Text('Kode OTP tidak sama!'),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.scale,
                      headerAnimationLoop: false,
                      autoDismiss: true,
                      dialogType: DialogType.success,
                      showCloseIcon: true,
                      title: 'Sukses',
                      desc:
                          'Sukses, anda akan diarahkan untuk merubah password anda',
                      btnOkOnPress: () {
                        debugPrint('OnClcik');
                      },
                      btnOkIcon: Icons.check_circle,
                      onDismissCallback: (type) {
                        debugPrint('Dialog Dissmiss from callback $type');
                      },
                    ).show();
                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPassword()));
                    });
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}
