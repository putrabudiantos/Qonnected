import 'package:flutter/material.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:qonnected_app/global_variabel.dart';
import 'package:get/get.dart';

import 'package:qonnected_app/page/initial_page.dart';

class BottomNavWidget extends StatefulWidget {
  const BottomNavWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      Get.offAllNamed(InitialPage.routeName);
      selectedIndex = index;
      vars.idx = index;
      print(vars.idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //bottom navigation bar on scaffold
      color: Colors.white,
      shape: const CircularNotchedRectangle(), //shape of notch
      notchMargin: 5, //notche margin between floating button and bottom appbar
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
                    Icon(
                      Icons.home_outlined,
                      color:
                          vars.idx == 0 ? Colors.red : const Color(0xFF0D1037),
                    ),
                    Text(
                      "Home",
                      style: FontMedium(context, 12, FontWeight.w500,
                          vars.idx == 0 ? Colors.red : const Color(0xFF0D1037)),
                    ),
                    //const Padding(padding: EdgeInsets.all(10))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
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
                            ? Colors.red
                            : const Color(0xFF0D1037)),
                    Text(
                      "Co Worker",
                      style: FontMedium(context, 12, FontWeight.w500,
                          vars.idx == 1 ? Colors.red : const Color(0xFF0D1037)),
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
                            ? Colors.red
                            : const Color(0xFF0D1037)),
                    Text(
                      "Company",
                      style: FontMedium(context, 12, FontWeight.w500,
                          vars.idx == 2 ? Colors.red : const Color(0xFF0D1037)),
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
                    Icon(
                      Icons.person_outline_rounded,
                      color:
                          vars.idx == 3 ? Colors.red : const Color(0xFF0D1037),
                    ),
                    Text(
                      "Profile",
                      style: FontMedium(context, 12, FontWeight.w500,
                          vars.idx == 3 ? Colors.red : const Color(0xFF0D1037)),
                    ),
                    //const Padding(padding: EdgeInsets.all(10))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
