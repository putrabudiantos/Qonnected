import 'dart:io';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:get/get.dart';
import '../activity/index.dart';
import '../profile/myhistory.dart';
import 'googlemaps.dart';
import 'kondisiwfhwfo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveAttendence extends StatefulWidget {
  int? colorperusahaan;
  String? statusjamkerja;
  String? setjammasuk;
  String? setjamkeluar;
  String? formattimemasuk;
  String? formattimekeluar;
  String? jumlahlokasi;
  String? logtime;
  String? statusmasukkerjalog;
  String? timelog;
  int lengthdatalog;
  LiveAttendence(
      {Key? key,
      this.colorperusahaan,
      this.statusjamkerja,
      this.setjammasuk,
      this.setjamkeluar,
      this.jumlahlokasi,
      this.lengthdatalog = 0,
      this.logtime,
      this.statusmasukkerjalog,
      this.timelog,
      this.formattimemasuk,
      this.formattimekeluar})
      : super(key: key);

  @override
  State<LiveAttendence> createState() => _LiveAttendenceState();
}

class _LiveAttendenceState extends State<LiveAttendence> {
  //-7.434928693418607, 112.72895139072396
  // String? _currentAddress;
  // Position? _currentPosition;
  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handleLocationPermission();
  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     setState(() => _currentPosition = position);
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  // @override
  // void initState() {
  //   _getCurrentPosition();
  //   super.initState();
  // }

  double latkantor = -7.26964, longkantor = 112.80511;
  double lokasiku = 0;
  late double lat;
  late double long;
  final Set<Marker> _marker = {};
  Position? _position;
  String? _address;
  String jarak = "", catatan = "", waktu = "";

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    String address = await _getAddressFormLatLongOnline(position);
    setState(() {
      _position = position;
      lat = position.latitude;
      long = position.longitude;
      _address = address;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> _getAddressFormLatLongOnline(Position param) async {
    try {
      List<Placemark> placemarkList = await placemarkFromCoordinates(
        param.latitude,
        param.longitude,
        localeIdentifier: "id",
      );
      Placemark place = placemarkList[0];
      return _address =
          "${place.country} ${place.postalCode} ${place.administrativeArea} ${place.subAdministrativeArea} ${place.locality} ${place.subLocality} ${place.thoroughfare} ${place.subThoroughfare} ${place.name}";
    } catch (e) {
      return "Log error$e";
    }
  }

  void marker() async {
    Position pos = await Geolocator.getCurrentPosition();
    setState(() {
      _marker.add(Marker(
          markerId: const MarkerId("Lokasi kantor"),
          position: LatLng(latkantor, longkantor),
          infoWindow: InfoWindow(title: "Posisi kantor", snippet: _address)));
      _marker.add(
        Marker(
          markerId: const MarkerId("Lokasi saat ini"),
          position: LatLng(pos.latitude, pos.longitude),
          infoWindow: InfoWindow(
            title: "Posisi Anda Sekarang",
            snippet: _address,
          ),
        ),
      );
    });
    setState(() {
      jarak = Geolocator.distanceBetween(
              latkantor, longkantor, pos.latitude, pos.longitude)
          .floor()
          .toString();
      lokasiku = double.parse(jarak);
      print("$latkantor, $longkantor posisi kantor");
      print("");
    });
  }

  void cekJarak() {
    int.parse(jarak) < 99
        ? AlertDialog(
            title: const Text('Clock In gagal'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Jarak anda dengan titik kordinat adalah $jarak meter'),
                  const Text('Anda berada diluar radius yang telah ditetapkan'),
                  const Text('Harap menuju ke lokasi yang telah ditetapkan!'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Oke'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        : null;
  }

  @override
  void initState() {
    _getCurrentLocation();
    marker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int? warna = widget.colorperusahaan;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: widget.colorperusahaan != null
            ? Color(widget.colorperusahaan!)
            : const Color(0xFF0D1037),
        title: const Text("Live Attendance",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        leading: const BackButton(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DigitalClock(
            amPmDigitTextStyle: const TextStyle(color: Colors.black),
            is24HourTimeFormat: false,
            hourMinuteDigitTextStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
            secondDigitTextStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 20),
            colon: const Text(
              ":",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            ),
          ),
          Text(DateFormat.yMMMEd().format(DateTime.now()),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 17)),
          const SizedBox(height: 10),
          Card(
            elevation: 6,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.statusjamkerja != null
                        ? Text("${widget.statusjamkerja}",
                            style: const TextStyle(color: Colors.black45))
                        : const Text("Normal",
                            style: TextStyle(color: Colors.black45)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.setjammasuk != null
                            ? Text("${widget.setjammasuk}", style: jam())
                            : Text(" - ", style: jam()),
                        widget.formattimemasuk != null
                            ? Text("${widget.formattimemasuk}", style: jam())
                            : Text(" AM", style: jam()),
                        Text(" : ", style: jam()),
                        widget.setjamkeluar != null
                            ? Text("${widget.setjamkeluar}", style: jam())
                            : Text(" - ", style: jam()),
                        widget.formattimekeluar != null
                            ? Text("${widget.formattimekeluar}", style: jam())
                            : Text(" PM", style: jam()),
                      ],
                    ),
                    widget.jumlahlokasi != null
                        ? TextButton(
                            onPressed: () {},
                            child: Text(
                                "See ${widget.jumlahlokasi} other attendance location"))
                        : const SizedBox(height: 0, width: 0),
                    const Divider(color: Colors.black45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.only(left: 25, right: 25),
                                primary: widget.colorperusahaan != null
                                    ? Color(warna!)
                                    : const Color(0xFF0D1037)),
                            onPressed: () {
                              showoption();
                            },
                            child: const Text("Clock In",
                                style: TextStyle(color: Colors.white))),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                primary: widget.colorperusahaan != null
                                    ? Color(warna!)
                                    : const Color(0xFF0D1037)),
                            onPressed: () {},
                            child: const Text("Clock Out",
                                style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Attendance log",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              TextButton(
                  onPressed: () {
                    Get.to(const MyHistory());
                  },
                  child: const Text(
                    "View log",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.normal),
                  )),
            ],
          ),
          if (widget.lengthdatalog > 0)
            for (int i = 0; i <= widget.lengthdatalog - 1; i++)
              attendancelog(
                  statusmasuk: widget.statusmasukkerjalog,
                  timesmasuk: widget.timelog)
          else
            const SizedBox(height: 0, width: 0)
        ],
      ),
    );
  }

// fungsi listtile history log
  Widget attendancelog({String? timesmasuk, statusmasuk}) {
    return Column(
      children: [
        ListTile(
          leading: Text(
            "$timesmasuk",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text("$statusmasuk"),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
        ),
        const Divider(color: Colors.black45)
      ],
    );
  }

// fungsi untuk textstyle log
  TextStyle jam() {
    return const TextStyle(
        color: Colors.black54, fontSize: 24, fontWeight: FontWeight.bold);
  }

  // fungsi untuk modalbottomsheet
  showoption() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              padding: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Container(
                      width: 60,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  menulogo()
                ],
              ),
            ),
          );
        });
  }

  // Row untuk menu saat logo perusahaan ditekan
  Widget menulogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          imagedatacontainer(
              function: () {
                scanQR(url: "https://invletter.com/profiles");
              },
              urlassets: "assets/icons/revisi/qr.png",
              nama: "Scan"),
          imagedatacontainer(
              function: () {
                if (lokasiku < 100) {
                  Get.to(const ClockIn());
                }
                if (lokasiku > 100) {
                  Get.to(const KondisiWfhIzinCuti());
                }
              },
              urlassets: "assets/icons/revisi/manual.png",
              nama: "Manual Activity"),
        ],
      ),
    );
  }

  GestureDetector imagedatacontainer(
      {String? urlassets, Function()? function, String? nama}) {
    return GestureDetector(
      onTap: function,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade200, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                urlassets!,
                scale: 6,
              ),
              const SizedBox(height: 10),
              Text(nama!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14))
            ],
          ),
        ),
      ),
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
