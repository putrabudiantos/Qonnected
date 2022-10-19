import 'package:flutter/material.dart';
import 'package:qonnected_app/page/activity/index.dart';
import 'package:qonnected_app/page/home/index.dart';
import 'package:qonnected_app/page/initial_page.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:qonnected_app/page/sign_up.dart';
import 'package:qonnected_app/page/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://dszmwtuipauoafvjqrsn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRzem13dHVpcGF1b2FmdmpxcnNuIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjE1MTUxMzUsImV4cCI6MTk3NzA5MTEzNX0.5Ayrgq3A95vZg5t601WBBfyYxDUI8u5ocKNcjpddnYc', // optional
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<GetPage> getPages = [
    GetPage(name: '/initpage', page: () => InitialPage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/splash', page: () => SplashPage()),
    GetPage(name: '/activity', page: () => IndexActivity())
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndexHome(),
      getPages: getPages,
    );
  }
}
