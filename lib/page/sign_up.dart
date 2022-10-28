import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qonnected_app/controller/auth_controller.dart';
import 'package:qonnected_app/helper/alert.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:qonnected_app/page/widget/btn_rounded.dart';
import 'package:qonnected_app/page/widget/field_email.dart';
import 'package:qonnected_app/page/widget/field_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AuthController authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
                      errorMessage: 'Nama harus diisi',
                      customController: authC.nameController.value,
                      customType: false,
                      readonly: false),
                  SizedBox(
                    height: 10,
                  ),
                  FieldText(
                      textfield: '',
                      placeholder: 'Username',
                      errorMessage: 'username harus diisi',
                      customController: authC.usernameController.value,
                      customType: false,
                      readonly: false),
                  SizedBox(
                    height: 10,
                  ),
                  FieldEmail(
                      textfield: '',
                      placeholder: 'Email',
                      errorMessage: 'Email harus diisi',
                      customController: authC.emailController.value,
                      readonly: false),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        authC.SignUp(context);
                      }
                    },
                    child: Obx(() => ButtonRoundedWidget(
                          text: authC.isLoading == true
                              ? 'PROCESSING'
                              : 'REGISTER',
                        )),
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
                                Get.to(LoginPage());
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
      ),
    );
  }
}
