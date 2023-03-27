import 'package:flutter/material.dart';
import './lupapassword.dart';
import 'package:qonnected_app/jobseeker/mainpage.dart';

class Masuk extends StatefulWidget {
  const Masuk({Key? key}) : super(key: key);

  @override
  State<Masuk> createState() => _MasukState();
}

class _MasukState extends State<Masuk> {
  final emailC = TextEditingController();
  final passwC = TextEditingController();
  bool passwordVisible = false;

  @override
  void initState() {
    passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    emailC.dispose();
    passwC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              Image.asset(
                'assets/images/masuk.png',
                scale: 1.5,
              ),
              const Text(
                'Login',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailC,
                decoration: InputDecoration(
                    prefixIconColor: Colors.blue.shade900,
                    hintStyle:
                        const TextStyle(fontFamily: "Inter", fontSize: 16),
                    prefixIcon: const Icon(Icons.alternate_email_outlined),
                    hintText: "Email ID"),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: passwC,
                obscureText: !passwordVisible,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                    prefixIconColor: Colors.blue.shade900,
                    suffixIconColor: Colors.blue.shade900,
                    hintStyle:
                        const TextStyle(fontFamily: "Inter", fontSize: 16),
                    prefixIcon: const Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    hintText: "Email ID"),
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LupaPassword()));
                    },
                    child: Text(
                      'Lupa Password?',
                      style: TextStyle(color: Colors.blue.shade900),
                    ))
              ]),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPageJobSeeker()));
                  },
                  child: const Text(
                    "Masuk",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 15),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali ke halaman sebelumnya'))
            ],
          ),
        ),
      ),
    );
  }
}
