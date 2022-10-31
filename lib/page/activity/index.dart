// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qonnected_app/controller/activity_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:qonnected_app/helper/alert.dart';
import 'package:qonnected_app/helper/shared_preferences.dart';
import 'package:qonnected_app/page/widget/bottom_navigation.dart';
import 'package:qonnected_app/page/widget/field_text_area.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SingingCharacter { wfo, wfh, izin, cuti }

class IndexActivity extends StatefulWidget {
  @override
  State<IndexActivity> createState() => _IndexActivityState();
}

class _IndexActivityState extends State<IndexActivity> {
  final ActivityController activityC = Get.put(ActivityController());
  SingingCharacter? _character = SingingCharacter.wfo;
  TextEditingController text = TextEditingController();
  var activity;
  String location = 'Null, Press Button';
  String Address = 'search';
  bool isCheckin = false;

  @override
  void initState() {
    checkIsCheckIn();
    super.initState();
  }

  checkIsCheckIn() async {
    final prefs = await SharedPreferences.getInstance();
    activityC.checkIn.value = prefs.getBool('checkin')!;

    print(isCheckin);
  }

  // Future<Position> _getGeoLocationPosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     await Geolocator.openLocationSettings();
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Align(
              alignment: Alignment.center,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Obx(() => Text(
                            'CHECK ${activityC.checkIn.value == false || activityC.checkIn.value == null ? 'IN' : 'OUT'}',
                            style: FontMedium(context, 20, FontWeight.w500,
                                const Color(0xFF0D1037)),
                          )),
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
                      Obx(() => activityC.distanceFar.value == true
                          ? DescriptionBox()
                          : Container()),
                      Obx(() => ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(15)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(activityC.checkOut.value == false
                                      ? 0xFF0D1037
                                      : 0xFF4F4F56)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(
                                          color:
                                              Color(activityC.checkOut.value == false ? 0xFF0D1037 : 0xFF4F4F56))))),
                          onPressed: () async {
                            // Position position = await _getGeoLocationPosition();
                            // in meter

                            // var ab = Geolocator.distanceBetween(-7.270599,
                            //     112.7989678, -7.2699392, 112.8029696);
                            // print(ab > 50 ? 'jauh' : 'dekat');

                            // print(_character == SingingCharacter.wfo
                            //     ? 'wfo'
                            //     : activity);
                            // print(activityC.distanceFar.value);
                            // StorageSharedPreferences.StorageProfile();
                            // location =
                            //     'Lat: ${position.latitude} , Long: ${position.longitude}';
                            if (activityC.checkOut.value == false) {
                              activityC.submitActivity(
                                  context,
                                  _character == SingingCharacter.wfo
                                      ? 'wfo'
                                      : activity,
                                  text.text);
                            }

                            // print(location);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: Obx(() => Text(activityC.isLoading == true
                                ? 'PROCESSING'
                                : 'CHECK ${activityC.checkIn.value == false || activityC.checkIn.value == null ? 'IN' : 'OUT'}')),
                          )))
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

  Widget DescriptionBox() {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: const Text('WFH'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.wfh,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                      activity = 'wfh';
                    });
                  },
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: const Text('IZIN'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.izin,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                      activity = 'izin';
                    });
                  },
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: const Text('CUTI'),
                leading: Radio<SingingCharacter>(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: SingingCharacter.cuti,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                      activity = 'cuti';
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        FieldTextArea(
          textfield: '',
          readonly: false,
          customController: text,
          customType: false,
          errorMessage: '',
          placeholder: '',
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
