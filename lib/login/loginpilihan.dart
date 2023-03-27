import 'package:flutter/material.dart';
import 'package:qonnected_app/page/splash_screen.dart';
import './masuk.dart';

class LoginFirstPage extends StatelessWidget {
  const LoginFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(left: 40, right: 40),
        children: [
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/logo.png',
            scale: 2,
          ),
          Image.asset(
            'assets/images/loginimage.png',
            scale: 1.7,
          ),
          const SizedBox(height: 100),
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
              onPressed: () {},
              child: const Text(
                "Daftar",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 15),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                primary: Colors.white,
                shadowColor: Colors.blue.shade200,
                side: BorderSide(color: Colors.blue.shade900),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minimumSize: const Size(100, 40), //////// HERE
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Masuk()));
              },
              child: Text(
                "Masuk",
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold),
              )),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SplashPage()));
            },
            child: Text(
              "Masuk sebagai pekerja",
              style: TextStyle(
                  color: Colors.blue.shade900,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
