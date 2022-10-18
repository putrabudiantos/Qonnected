import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qonnected_app/controller/location_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class IndexActivity extends StatelessWidget {
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF0D1037)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(
                                          color: Color(0xFF0D1037))))),
                          onPressed: () async {
                            final LocationSettings locationSettings =
                                LocationSettings(
                              accuracy: LocationAccuracy.high,
                              distanceFilter: 100,
                            );
                            var positionStream = Geolocator.getPositionStream(
                                    locationSettings: locationSettings)
                                .listen((Position? position) {
                              print(position == null
                                  ? 'Unknown'
                                  : '${position.latitude.toString()}, ${position.longitude.toString()}');
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
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
    );
  }
}
