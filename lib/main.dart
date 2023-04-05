import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qonnected_app/binding/home_binding.dart';
import 'package:qonnected_app/page/activity/index.dart';
import 'package:qonnected_app/page/coworker/index.dart';
import 'package:qonnected_app/page/home/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qonnected_app/page/initial_page.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/page/introduction/index.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:qonnected_app/page/profile/ajukanperubahansaya.dart';
import 'package:qonnected_app/page/profile/index.dart';
import 'package:qonnected_app/page/settings/profile.dart';
import 'package:qonnected_app/page/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

int? initScreen;
const int defaultcolors = 0xFF0D1037;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final pref = await SharedPreferences.getInstance();
  initScreen = pref.getInt('initScreen');
  await pref.setInt('initScreen', 1);

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
        name: '/initpage',
        page: () => const InitialPage(),
        binding: HomeBinding()),
    GetPage(name: '/login', page: () => const LoginPage()),
    GetPage(
        name: '/splash',
        page: () => const SplashPage(),
        binding: HomeBinding()),
    GetPage(name: '/activity', page: () => const IndexActivity()),
    GetPage(
        name: '/coworkers',
        page: () => const IndexCoWorkers(),
        binding: HomeBinding()),
    GetPage(
        name: '/home', page: () => const IndexHome(), binding: HomeBinding()),
    GetPage(name: '/profile', page: () => IndexProfile()),
    GetPage(name: '/settings', page: () => ProfilesDetails()),
    GetPage(
        name: '/profile/personal/ajukanperubahan',
        page: () => const AjukanPerubahanSaya())
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.white,
          useMaterial3: true,
          primaryColor: const Color(0xFF0D1037),
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          textTheme: const TextTheme(
              button: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          fontFamily: "Inter"),
      debugShowCheckedModeBanner: false,
      initialRoute:
          initScreen == 0 || initScreen == null ? 'splashscreen' : 'splashpage',
      routes: {
        'splashscreen': (context) => const IntroductionScreens(),
        'splashpage': (context) => const SplashPage()
      },
      home: const IntroductionScreens(),
      // home: const SplashPage(),
      getPages: getPages,
    );
  }
}
