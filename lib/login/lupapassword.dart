import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import './enterotp.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({super.key});

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  final emailC = TextEditingController();

  @override
  void dispose() {
    emailC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              'assets/images/forgotpassword.png',
              scale: 1.5,
            ),
            const Text(
              'Lupa Password?',
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
              'Jangan Khawatir bila ini terjadi, Mohon masukkan akun email anda yang telah di daftarkan sebelumnya.',
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
              controller: emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIconColor: Colors.blue.shade900,
                  hintStyle: const TextStyle(fontFamily: "Inter", fontSize: 16),
                  prefixIcon: const Icon(Icons.alternate_email_outlined),
                  hintText: "Email ID"),
            ),
            const SizedBox(
              height: 35,
            ),
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
              onPressed: () async {
                if (emailC.text.isEmpty) {
                  final snackBar = SnackBar(
                    content: const Text('Email tidak boleh kosong!'),
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
                    desc: 'Sukses mengirim kode OTP ke alamat email anda.',
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
                            builder: (context) => const EnterOTP()));
                  });
                }
              },
              child: const Text(
                "Reset Password",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
