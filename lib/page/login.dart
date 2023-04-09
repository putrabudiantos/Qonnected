import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qonnected_app/controller/auth_controller.dart';
import 'package:qonnected_app/page/sign_up.dart';
import 'package:qonnected_app/page/widget/btn_rounded.dart';
import 'package:qonnected_app/page/widget/field_email.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final AuthController authC = Get.put(AuthController());

  // TextEditingController email = TextEditingController();

  // @override
  // void dispose() {
  //   email.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width * .8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                  ),
                  FieldEmail(
                      textfield: '',
                      placeholder: 'Email',
                      errorMessage: 'Email harus diisi',
                      customController: authC.emailController.value,
                      readonly: false),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        authC.login(context, authC.emailController.value);
                      }
                    },
                    child: Obx(() => ButtonRoundedWidget(
                          text: authC.isLoading == true
                              ? 'PROCESSING'
                              : 'CHECK EMAIL',
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Create an account? ',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF0D1037),
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(SignupPage());
                                // Navigator.pushAndRemoveUntil(
                                //     context,
                                //      SignUpPage()),
                                //     (Route<dynamic> route) => false);
                              },
                            text: 'Sign up',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF0D1037),
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
