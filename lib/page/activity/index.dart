import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qonnected_app/controller/activity_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:qonnected_app/helper/alert.dart';
import 'package:qonnected_app/page/widget/bottom_navigation.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class IndexActivity extends StatefulWidget {
  @override
  State<IndexActivity> createState() => _IndexActivityState();
}

class _IndexActivityState extends State<IndexActivity> {
  String location = 'Null, Press Button';
  String Address = 'search';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    print(Address);
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
              // String? barcode = await scanner.scan();

              // print(barcode);
              // Get.toNamed(barcode!);
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
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              Align(
                alignment: Alignment.center,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'CHECK IN',
                          style: FontMedium(
                              context, 20, FontWeight.w500, Color(0xFF0D1037)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DigitalClock(
                          areaDecoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          showSecondsDigit: false,
                          hourMinuteDigitTextStyle: TextStyle(
                              color: Color(0xFF0D1037),
                              fontSize: 50,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(15)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF0D1037)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: BorderSide(
                                            color: Color(0xFF0D1037))))),
                            onPressed: () async {
                              Position position =
                                  await _getGeoLocationPosition();
                              location =
                                  'Lat: ${position.latitude} , Long: ${position.longitude}';
                              GetAddressFromLatLong(position);
                              print(location);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Text('CHECK IN'),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {},
          child: Icon(Icons.qr_code_scanner), //icon inside button
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavWidget());
  }
}
