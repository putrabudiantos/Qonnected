import 'package:flutter/material.dart';
import 'package:qonnected_app/page/initial_page.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:qonnected_app/page/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitialPage(),
    );
  }
}
