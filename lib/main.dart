import 'package:flutter/material.dart';
import 'package:qonnected_app/binding/home_binding.dart';
import 'package:qonnected_app/page/activity/index.dart';
import 'package:qonnected_app/page/coworker/index.dart';
import 'package:qonnected_app/page/home/index.dart';
import 'package:qonnected_app/page/initial_page.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/page/introduction/index.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:qonnected_app/page/profile/ajukanperubahansaya.dart';
import 'package:qonnected_app/page/profile/index.dart';
import 'package:qonnected_app/page/settings/index.dart';
import 'package:qonnected_app/page/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //supabase
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
    GetPage(
        name: '/initpage', page: () => InitialPage(), binding: HomeBinding()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(
        name: '/splash',
        page: () => const SplashPage(),
        binding: HomeBinding()),
    GetPage(name: '/activity', page: () => IndexActivity()),
    GetPage(
        name: '/coworkers',
        page: () => const IndexCoWorkers(),
        binding: HomeBinding()),
    GetPage(
        name: '/home', page: () => const IndexHome(), binding: HomeBinding()),
    GetPage(name: '/profile', page: () => IndexProfile()),
    GetPage(name: '/settings', page: () => IndexSettings()),
    GetPage(
        name: '/profile/personal/ajukanperubahan',
        page: () => const AjukanPerubahanSaya())
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          textTheme: const TextTheme(
              button: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          fontFamily: "Inter"),
      debugShowCheckedModeBanner: false,
      // home: const IntroductionScreens(),
      home: const SplashPage(),
      getPages: getPages,
    );
  }
}
