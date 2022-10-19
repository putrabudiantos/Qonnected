import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:qonnected_app/page/activity/index.dart';
import 'package:qonnected_app/page/home/index.dart';
import 'package:qonnected_app/page/scanner/index.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:get/get.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;

class InitialPage extends StatefulWidget {
  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  // List<PersistentBottomNavBarItem> _navBarsItems() {
  int _selectedIndex = vars.idx == 0 ? vars.idx : 0;

  final pages = [
    IndexHome(),
    IndexActivity(),
    IndexScanner(),
    IndexHome(),
    IndexHome()
  ];

  void _onItemTapped(int index) {
    setState(() {
      vars.idx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF2D2F48)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 80,
            ),
          ),
        ),
        drawerEnableOpenDragGesture: false,
        body: pages[vars.idx],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {},
          child: Icon(Icons.qr_code_scanner), //icon inside button
        ),
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
                      Get.to(IndexHome());
                      setState(() {
                        vars.idx = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home),
                        Text(
                          "Home",
                          style: FontMedium(
                              context, 12, FontWeight.w500, Color(0xFF0D1037)),
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
                      Get.to(IndexActivity());
                      setState(() {
                        vars.idx = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline),
                        Text(
                          "Co Worker",
                          style: FontMedium(
                              context, 12, FontWeight.w500, Color(0xFF0D1037)),
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
                      setState(() {
                        vars.idx = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.domain_outlined),
                        Text(
                          "Company",
                          style: FontMedium(
                              context, 12, FontWeight.w500, Color(0xFF0D1037)),
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
                      setState(() {
                        vars.idx = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_outline_rounded),
                        Text(
                          "Profile",
                          style: FontMedium(
                              context, 12, FontWeight.w500, Color(0xFF0D1037)),
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
