import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:qonnected_app/page/home/index.dart';
import 'package:qonnected_app/page/scanner/index.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  List<Widget> _buildScreens() {
    return [
      IndexHome(),
      IndexScanner(),
      IndexScanner(),
      IndexHome(),
      IndexHome()
    ];
  }

  getScanner() {
    return GestureDetector(
      onTap: () async {},
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          textStyle: TextStyle(fontSize: 10)),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.people_outline),
          title: ("Co Workers"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          textStyle: TextStyle(fontSize: 10)),
      PersistentBottomNavBarItem(
          icon: GestureDetector(
            onTap: () async {
              String? barcode = await scanner.scan();
            },
            child: Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
            ),
          ),
          title: ("Scan"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          textStyle: TextStyle(fontSize: 10)),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.domain_outlined),
          title: ("Company"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          textStyle: TextStyle(fontSize: 10)),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person_outline_rounded),
          title: ("Profile"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          textStyle: TextStyle(fontSize: 10)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.easeInCirc,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}
