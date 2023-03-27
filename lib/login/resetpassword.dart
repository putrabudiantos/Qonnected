import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:qonnected_app/login/loginpilihan.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final passw1 = TextEditingController();
  final passw2 = TextEditingController();
  bool passwordVisible1 = false;
  bool passwordVisible2 = false;

  @override
  void dispose() {
    passw1.dispose();
    passw2.dispose();
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
              'assets/images/resetpassword2.png',
              scale: 1.5,
            ),
            const Text(
              'Reset Password',
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
              'Masukkan mpassword baru, jangan menggunakan tanggal lahir atau password yang mudah ditebak.',
              style: TextStyle(
                fontFamily: "Inter",
                color: Colors.black45,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: passw1,
              obscureText: !passwordVisible1,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                  prefixIconColor: Colors.blue.shade900,
                  suffixIconColor: Colors.blue.shade900,
                  hintStyle: const TextStyle(fontFamily: "Inter", fontSize: 16),
                  prefixIcon: const Icon(
                    Icons.lock,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordVisible1 = !passwordVisible1;
                      });
                    },
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible1
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  hintText: "Password Baru"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passw2,
              obscureText: !passwordVisible2,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                  prefixIconColor: Colors.blue.shade900,
                  suffixIconColor: Colors.blue.shade900,
                  hintStyle: const TextStyle(fontFamily: "Inter", fontSize: 16),
                  prefixIcon: const Icon(
                    Icons.lock,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordVisible2 = !passwordVisible2;
                      });
                    },
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible2
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  hintText: "Re-type Password"),
            ),
            const SizedBox(height: 25),
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
                if (passw1.text.isEmpty || passw2.text.isEmpty) {
                  final snackBar = SnackBar(
                    content: const Text('Password tidak boleh kosong!'),
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (passw2.text != passw1.text) {
                  final snackBar = SnackBar(
                    content: const Text('Password harus sama!'),
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (passw1.text == passw2.text) {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    headerAnimationLoop: false,
                    autoDismiss: true,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: 'Sukses',
                    desc:
                        'Sukses, aberhasil merubah password anda. Anda akan diarahkan ke halaman login.',
                    btnOkOnPress: () {
                      debugPrint('OnClcik');
                    },
                    btnOkIcon: Icons.check_circle,
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginFirstPage()),
                        (route) => false);
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
      ),
    );
  }
}
