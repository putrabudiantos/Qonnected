import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:qonnected_app/login/loginpilihan.dart';
import 'package:qonnected_app/page/login.dart';
// import 'package:android_intent/android_intent.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qonnected_app/page/splash_screen.dart';

enum PermissionStatus {
  granted,
  denied,
  restricted,
  permanentlyDenied,
}
// to avoid confusion with google_maps_flutter package

class IntroductionScreens extends StatelessWidget {
  const IntroductionScreens({Key? key}) : super(key: key);

  //fungsi untuk teks judul
  Text bodywiget() {
    return Text(
      "Qonnected",
      style: TextStyle(
        color: Colors.blue.shade900,
        fontFamily: "Inter",
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
          pages: [
            PageViewModel(
              titleWidget: const Text(
                "Cari Kerja, Absensi Karyawan jadi lebih mudah",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "Inter",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              bodyWidget: bodywiget(),
              image: buildImage("assets/images/firstpage.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              titleWidget: const Text(
                "Clock In/Out dengan hanya satu klik",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "Inter",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              bodyWidget: bodywiget(),
              image: buildImage("assets/images/secondpage.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
                titleWidget: const Text(
                  "Beri akses layanan lokasi untuk Clock In/Out",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Inter",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                bodyWidget: bodywiget(),
                image: buildImage("assets/images/thirdpage.png"),
                //getPageDecoration, a method to customise the page style
                decoration: getPageDecoration(),
                footer: TextButton(
                    onPressed: () {
                      showMyDialogLocation(context);
                    },
                    child: Text("Beri Akses",
                        style: TextStyle(
                            color: Colors.blue.shade900, fontSize: 16)))),
            PageViewModel(
                titleWidget: const Text(
                  "Beri akses layanan kamera untuk Clock In/Out",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Inter",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                bodyWidget: bodywiget(),
                image: buildImage("assets/images/fourthpage.png"),
                //getPageDecoration, a method to customise the page style
                decoration: getPageDecoration(),
                footer: TextButton(
                    onPressed: () async {
                      showMyDialogCamera(context);
                    },
                    child: Text(
                      "Beri Akses",
                      style:
                          TextStyle(color: Colors.blue.shade900, fontSize: 16),
                    ))),
          ],
          onDone: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginFirstPage()));
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => const SplashPage()));
          },
          //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
          scrollPhysics: const ClampingScrollPhysics(),
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
          isBottomSafeArea: true,
          skip: Text("Skip",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade900,
                  fontFamily: "Inter")),
          next: Text('Next',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade900,
                  fontFamily: "Inter")),
          done: Text("Selesai",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade900,
                  fontFamily: "Inter")),
          dotsDecorator: getDotsDecorator()),
    );
  }

  //widget to add the image on screen
  Widget buildImage(String imagePath) {
    return Center(
        child: Image.asset(
      imagePath,
      width: 450,
      height: 200,
    ));
  }

  //method to customise the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imagePadding: EdgeInsets.only(top: 120),
      pageColor: Colors.white,
      bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
      titlePadding: EdgeInsets.only(top: 50),
      bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
    );
  }

  //method to customize the dots style
  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 5),
      activeColor: Colors.indigo,
      color: Colors.grey,
      activeSize: Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }

  //fungsi untuk akses izin lokasi
  Future<void> showMyDialogLocation(BuildContext? context) async {
    return showDialog<void>(
      context: context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              const Text('Beri Hak Akses Lokasi', textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Aplikasi ini ingin mengakses lokasi anda untuk dapat menggunakannya'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tolak'),
              onPressed: () {
                Permission.location.isDenied;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () async {
                if (await Permission.location.request().isGranted) {
                  print("Izin lokasi diizinkan");
                  Navigator.pop(context);
                } else if (await Permission.location.isDenied) {
                  Navigator.pop(context);
                }
                if (await Permission.location.isPermanentlyDenied) {
                  openAppSettings();
                  print("Izin lokasi tidak diizinkan");
                }
              },
              child: const Text('Izinkan'),
            ),
          ],
        );
      },
    );
  }

  //fungsi untuk akses izin kamera
  Future<void> showMyDialogCamera(BuildContext? context) async {
    return showDialog<void>(
      context: context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              const Text('Beri Hak Akses Kamera', textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Aplikasi ini ingin mengakses kamera anda untuk dapat menggunakannya'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tolak'),
              onPressed: () {
                Permission.camera.isDenied;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () async {
                if (await Permission.camera.request().isGranted) {
                  print("Kamera akses diizinkan");
                  Navigator.pop(context);
                } else if (await Permission.camera.isDenied) {
                  Navigator.pop(context);
                }
                if (await Permission.camera.isPermanentlyDenied) {
                  openAppSettings();
                  print("Akses kamera ditolak");
                }
              },
              child: const Text('Izinkan'),
            ),
          ],
        );
      },
    );
  }
}
