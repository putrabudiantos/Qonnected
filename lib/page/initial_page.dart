import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qonnected_app/controller/init_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:qonnected_app/page/activity/index.dart';
import 'package:qonnected_app/page/coworker/index.dart';
import 'package:qonnected_app/page/home/index.dart';
import 'package:qonnected_app/page/scanner/index.dart';
import 'package:qonnected_app/page/settings/profile.dart';
import 'package:qonnected_app/page/settings/settings.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:qonnected_app/page/tentang_perusahaan/tentangperusahaan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/profile/profile.dart';

class InitialPage extends StatefulWidget {
  static const routeName = '/initpage';

  const InitialPage({Key? key}) : super(key: key);
  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  String _scanBarcode = 'Unknown';
  final InitController initC = Get.put(InitController());

  @override
  void initState() {
    // vars.idx = 0;
    super.initState();
  }

  final int selectedIndex = vars.idx == 0 ? vars.idx : 0;

  // disini fungsi class dari tab home, coworkers, scanner, companies dan profile
  final pages = [
    // Fungsi class Home
    const IndexHome(),

    //Fungsi kelas Co Workers
    const IndexCoWorkers(urlimagecompany: "", namaperusahaan: "MyDevTeam"),

    //Fungsi kelas Companies
    const TentangPerusahaan(),

    //Fungsi kelas profil
    ProfilesDetails()
    // ProfilesDetails(
    //   nama: "Novita",
    //   namaperusahaan: "MyDevTeam",
    //   jabatan: "Developer IT",
    //   warnaperusahaan: 0xFF0D1037,
    //   gender: "laki-laki",
    //   jumlahcuti: "6",
    //   jumlahizin: "8",
    //   hour: DateTime.now().toString(),
    //   urlimage:
    //       "https://akcdn.detik.net.id/community/media/visual/2022/09/22/ilustrasi-legalitas-perusahaan_169.jpeg?w=700&q=90",
    // )

    // const IndexActivity(),
    // IndexSettings()
  ];

  void _onItemTapped(int index) {
    setState(() {
      vars.idx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawerEnableOpenDragGesture: true,
        body: pages[vars.idx],
        floatingActionButton: Obx(() => FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              backgroundColor: Color(initC.mainColor.value),

              onPressed: () async {
                //  String? barcode = await scanner.scan();
                //  print(barcode);
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('checkin', false);
                await prefs.setBool('checkout', false);

                Get.to(LiveAttendence(
                    formattimemasuk: "AM",
                    formattimekeluar: "PM",
                    jumlahlokasi: "3",
                    logtime: "08:10",
                    setjammasuk: "07.00",
                    lengthdatalog: 4,
                    statusmasukkerjalog: "Clock In",
                    setjamkeluar: "03.00"));
              },
              child: const Icon(Icons.quora, size: 30), //icon inside button
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          //bottom navigation bar on scaffold
          color: Colors.white,
          shape: const CircularNotchedRectangle(), //shape of notch
          notchMargin:
              5, //notche margin between floating button and bottom appbar
          child: SizedBox(
            height: 60,
            child: Row(
              //children inside bottom appbar
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Center(
                  child: InkWell(
                    focusColor: Colors.black,
                    hoverColor: Colors.grey.shade300,
                    highlightColor: Colors.black,
                    onTap: () {
                      _onItemTapped(0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home_outlined,
                            color: vars.idx == 0
                                ? Color(initC.mainColor.value)
                                : Colors.grey.shade500),
                        Text(
                          "Home",
                          style: FontMedium(
                              context,
                              12,
                              FontWeight.w500,
                              vars.idx == 0
                                  ? Color(initC.mainColor.value)
                                  : Colors.grey.shade500),
                        ),
                        //const Padding(padding: EdgeInsets.all(10))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    focusColor: Colors.black,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      _onItemTapped(1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline,
                            color: vars.idx == 1
                                ? Color(initC.mainColor.value)
                                : Colors.grey.shade500),
                        Text(
                          "Co Workers",
                          style: FontMedium(
                              context,
                              12,
                              FontWeight.w500,
                              vars.idx == 1
                                  ? Color(initC.mainColor.value)
                                  : Colors.grey.shade500),
                        ),
                        //const Padding(padding: EdgeInsets.all(10))
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    focusColor: Colors.black,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      _onItemTapped(2);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.domain_outlined,
                            color: vars.idx == 2
                                ? Color(initC.mainColor.value)
                                : Colors.grey.shade500),
                        Text(
                          "Companies",
                          style: FontMedium(
                              context,
                              12,
                              FontWeight.w500,
                              vars.idx == 2
                                  ? Color(initC.mainColor.value)
                                  : Colors.grey.shade500),
                        ),
                        //const Padding(padding: EdgeInsets.all(10))
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    focusColor: Colors.black,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      _onItemTapped(3);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_outline_outlined,
                            color: vars.idx == 3
                                ? Color(initC.mainColor.value)
                                : Colors.grey.shade500),
                        Text(
                          "Profile",
                          style: FontMedium(
                              context,
                              12,
                              FontWeight.w500,
                              vars.idx == 3
                                  ? Color(initC.mainColor.value)
                                  : Colors.grey.shade500),
                        ),
                        //const Padding(padding: EdgeInsets.all(10))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )

        // BottomNavigationBar(

        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: Colors.white,
        //   items: <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home_outlined),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       label: 'Co Workers',
        //       icon: Icon(Icons.people_outline),
        //     ),
        //     BottomNavigationBarItem(
        //       label: '',
        //       icon: Transform(
        //         alignment: Alignment.topRight,
        //         transform: Matrix4.translationValues(0, 0, 0.0),
        //         child: Container(
        //             decoration: BoxDecoration(
        //                 color: Colors.red,
        //                 borderRadius: BorderRadius.all(Radius.circular(50))),
        //             child: Padding(
        //               padding: const EdgeInsets.all(15),
        //               child: Icon(
        //                 Icons.qr_code_scanner,
        //                 color: Colors.white,
        //               ),
        //             )),
        //       ),
        //     ),
        //     BottomNavigationBarItem(
        //       label: 'Company',
        //       icon: Icon(Icons.domain_outlined),
        //     ),
        //     BottomNavigationBarItem(
        //       label: 'Profile',
        //       icon: Icon(Icons.person_outline_rounded),
        //     )
        //   ],
        //   currentIndex: vars.idx,
        //   selectedItemColor: Colors.red,
        //   unselectedItemColor: Color(0xFF0D1037),
        //   unselectedFontSize: 12,
        //   selectedFontSize: 12,
        //   onTap: _onItemTapped,
        // ),
        );
  }

  //fungsi untuk scan code
  Future<void> scanQR({String? url}) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    if (barcodeScanRes == url) {
      Get.to(const IndexActivity());
    } else {
      barcodeScanRes == "Gagal";
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: "Gagal",
        desc: 'Url link tidak sama dengan link absensi perusahaan.',
        autoHide: const Duration(seconds: 3),
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    }

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
  }
}
