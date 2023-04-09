import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/auth/otpdisplayemail.dart';
import 'package:qonnected_app/controller/firebaseauth/signupcontroller.dart';
import '../page/login.dart';
import 'otpdisplaynomor.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
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
                  "Masukan alamat Email\nuntuk login ke Dashboard",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: controller.emailcontroller,
                  decoration: InputDecoration(
                      hintText: "Email",
                      label: const Text("Email"),
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 30),
                const Text(
                    "Kami akan mengirimkan anda kode OTP ke email yang anda inputkan",
                    textAlign: TextAlign.center),
                const SizedBox(height: 30),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Login dengan nomor HP')),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        SignUpController.instance.registerUserEmail(
                            email: controller.emailcontroller.text.trim());
                      }
                      // if (controller.emailcontroller.text.isNotEmpty) {
                      //   Get.to(
                      //       OTPScreenEmail(emailtujuan: emailcontroller.text));
                      // }
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
