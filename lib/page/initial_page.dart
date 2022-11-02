import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:qonnected_app/controller/init_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:qonnected_app/helper/shared_preferences.dart';
import 'package:qonnected_app/page/activity/index.dart';
import 'package:qonnected_app/page/coworker/index.dart';
import 'package:qonnected_app/page/home/index.dart';
import 'package:qonnected_app/page/profile/index.dart';
import 'package:qonnected_app/page/scanner/index.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:get/get.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:shared_preferences/shared_preferences.dart';

class InitialPage extends StatefulWidget {
  static const routeName = '/initpage';
  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final InitController initC = Get.put(InitController());

  // List<PersistentBottomNavBarItem> _navBarsItems() {

  @override
  void initState() {
    vars.idx = 0;
    super.initState();
  }

  int _selectedIndex = vars.idx == 0 ? vars.idx : 0;

  final pages = [
    IndexHome(),
    IndexCoWorkers(),
    IndexActivity(),
    IndexProfile()
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
        appBar: AppBar(
          // actions: [Icon(Icons.abc_outlined)],
          iconTheme: IconThemeData(color: Color(0xFF2D2F48)),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          elevation: 0,
          // title: Center(
          //   child: Padding(
          //     padding: const EdgeInsets.only(right: 30),
          //     child: Image.asset(
          //       'assets/images/logo.png',
          //       height: 80,
          //     ),
          //   ),
          // ),
        ),
        drawerEnableOpenDragGesture: false,
        // drawer: Drawer(
        //   child: SingleChildScrollView(
        //       child: Column(
        //     children: const [
        //       SizedBox(
        //         height: 20,
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.library_books_outlined),
        //         title: Text('Summary'),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.library_books_outlined),
        //         title: Text('Change Shift'),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.library_books_outlined),
        //         title: Text('Over Time'),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.library_books_outlined),
        //         title: Text('Payslip'),
        //       )
        //     ],
        //   )),
        // ),
        body: pages[vars.idx],
        floatingActionButton: Obx(() => FloatingActionButton(
              backgroundColor: Color(initC.mainColor.value),
              onPressed: () async {
                //  String? barcode = await scanner.scan();
                //  print(barcode);
                final prefs = await SharedPreferences.getInstance();
                // await prefs.setBool('checkin', false);
                // await prefs.setBool('checkout', false);
                // HelperSharedPreferences.refreshStorage();
                // print(prefs.getBool('checkin'));
              },
              child: Icon(Icons.qr_code_scanner), //icon inside button
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          //bottom navigation bar on scaffold
          color: Colors.white,
          shape: CircularNotchedRectangle(), //shape of notch
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
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      _onItemTapped(0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home_outlined,
                            color: vars.idx == 0
                                ? Color(initC.mainColor.value)
                                : Color(0xFF0D1037)),
                        Text(
                          "Home",
                          style: FontMedium(
                              context,
                              12,
                              FontWeight.w500,
                              vars.idx == 0
                                  ? Color(initC.mainColor.value)
                                  : Color(0xFF0D1037)),
                        ),
                        //const Padding(padding: EdgeInsets.all(10))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: InkWell(
                    focusColor: Colors.transparent,
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
                                : Color(0xFF0D1037)),
                        Text(
                          "Co Worker",
                          style: FontMedium(
                              context,
                              12,
                              FontWeight.w500,
                              vars.idx == 1
                                  ? Color(initC.mainColor.value)
                                  : Color(0xFF0D1037)),
                        ),
                        //const Padding(padding: EdgeInsets.all(10))
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    focusColor: Colors.transparent,
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
                                : Color(0xFF0D1037)),
                        Text(
                          "Company",
                          style: FontMedium(
                              context,
                              12,
                              FontWeight.w500,
                              vars.idx == 2
                                  ? Color(initC.mainColor.value)
                                  : Color(0xFF0D1037)),
                        ),
                        //const Padding(padding: EdgeInsets.all(10))
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      _onItemTapped(3);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_outline_rounded,
                            color: vars.idx == 3
                                ? Color(initC.mainColor.value)
                                : Color(0xFF0D1037)),
                        Text(
                          "Profile",
                          style: FontMedium(
                              context,
                              12,
                              FontWeight.w500,
                              vars.idx == 3
                                  ? Color(initC.mainColor.value)
                                  : Color(0xFF0D1037)),
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
}
