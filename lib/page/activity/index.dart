// ignore_for_file: use_build_context_synchronously

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
import 'package:get/get.dart';

class IndexActivity extends StatefulWidget {
  @override
  State<IndexActivity> createState() => _IndexActivityState();
}

class _IndexActivityState extends State<IndexActivity> {
  final ActivityController activityC = Get.put(ActivityController());
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

  Future<String> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    // print(Address);
    return Address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        style: FontMedium(context, 20, FontWeight.w500,
                            const Color(0xFF0D1037)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DigitalClock(
                        areaDecoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        showSecondsDigit: false,
                        hourMinuteDigitTextStyle: const TextStyle(
                            color: const Color(0xFF0D1037),
                            fontSize: 50,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(15)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFF0D1037)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: const BorderSide(
                                          color: Color(0xFF0D1037))))),
                          onPressed: () async {
                            Position position = await _getGeoLocationPosition();
                            location =
                                'Lat: ${position.latitude} , Long: ${position.longitude}';
                            var locationName =
                                await GetAddressFromLatLong(position);
                            activityC.submitActivity(
                                context,
                                double.parse(position.longitude.toString()),
                                double.parse(position.latitude.toString()),
                                'wfo',
                                locationName,
                                '');
                            // print(location);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: Obx(() => Text(activityC.isLoading == true
                                ? 'PROCESSING'
                                : 'CHECK IN')),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
