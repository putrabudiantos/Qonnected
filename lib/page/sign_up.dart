import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:qonnected_app/page/widget/btn_rounded.dart';
import 'package:qonnected_app/page/widget/field_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                ),
                FieldText(
                    textfield: '',
                    placeholder: 'Full Name',
                    errorMessage: '',
                    customController: text,
                    customType: true,
                    readonly: false),
                SizedBox(
                  height: 10,
                ),
                FieldText(
                    textfield: '',
                    placeholder: 'Email',
                    errorMessage: '',
                    customController: text,
                    customType: true,
                    readonly: false),
                SizedBox(
                  height: 30,
                ),
                ButtonRoundedWidget(
                  text: 'REGISTER',
                ),
                SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Have account? ',
                    style: GoogleFonts.inter(
                      color: Color(0xFF0D1037),
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Get.to(LoginPage());
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //      SignUpPage()),
                              //     (Route<dynamic> route) => false);
                            },
                          text: 'Login',
                          style: GoogleFonts.inter(
                            color: Color(0xFF0D1037),
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
