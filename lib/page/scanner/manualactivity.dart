import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ManualActivity extends StatefulWidget {
  final int? colorperusahaan;

  const ManualActivity({Key? key, this.colorperusahaan}) : super(key: key);

  @override
  State<ManualActivity> createState() => _ManualActivityState();
}

class _ManualActivityState extends State<ManualActivity> {
  final timeclockin = DateFormat('HH:mm').format(DateTime.now()).toString();
  final dateclockin = DateFormat.yMMMMd().format(DateTime.now()).toString();
  final String weekdaytimemasuk = '08.30';
  final String weekdaytimekeluar = '17.30';
  bool clockin = true;
  Position? position;
  String? address;
  String jarak = "", catatan = "", waktu = "";
  bool titikKoma = true;
  Timer? timer;
  final controllerCatatan = TextEditingController();
  double latkantor = -7.26964, longkantor = 112.80511;
  late double lat;
  late double long;
  final Set<Marker> marker = {};
  var apikey = Uri.parse(
      "https://api.mapbox.com/styles/v1/dhruv25/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token='pk.eyJ1Ijoibm92aXRha2Q5ODEiLCJhIjoiY2trYnpwNzE0MDAyaTJwbjE4MjU5dmI4dCJ9.BEjeK0mmQP7OpMPrNzBs0w");

  void getCurrentLocation() async {
    Position position = await _determinePosition();
    String address = await _getAddressFormLatLongOnline(position);
    setState(() {
      position = position;
      lat = position.latitude;
      long = position.longitude;
      address = address;
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
      return address =
          "${place.country} ${place.postalCode} ${place.administrativeArea} ${place.subAdministrativeArea} ${place.locality} ${place.subLocality} ${place.thoroughfare} ${place.subThoroughfare} ${place.name}";
    } catch (e) {
      return "Log error$e";
    }
  }

  void markers() async {
    Position pos = await Geolocator.getCurrentPosition();
    setState(() {
      marker.add(
        Marker(
          markerId: const MarkerId("Lokasi saat ini"),
          position: LatLng(pos.latitude, pos.longitude),
          infoWindow: InfoWindow(
            title: "Posisi Anda Sekarang",
            snippet: address,
          ),
        ),
      );
    });
    setState(() {
      jarak = Geolocator.distanceBetween(
              latkantor, longkantor, pos.latitude, pos.longitude)
          .floor()
          .toString();
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

  File? image;
  getFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.camera);
    setState(() {
      image = File(imagePicked!.path);
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    markers();
    super.initState();
  }

  @override
  void dispose() {
    controllerCatatan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                getFromCamera();
              },
              tooltip: "Ambil Gambar",
              icon: const Icon(Icons.camera_alt, color: Colors.white))
        ],
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        backgroundColor: widget.colorperusahaan != null
            ? Color(widget.colorperusahaan!)
            : const Color(0xFF0D1037),
        title: DigitalClock(
          areaWidth: MediaQuery.of(context).size.width / 1.6,
          showSecondsDigit: false,
          amPmDigitTextStyle: const TextStyle(color: Colors.white),
          is24HourTimeFormat: true,
          hourMinuteDigitTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          secondDigitTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15),
          colon: const Text(
            ":",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: position != null
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(lat, long),
                      zoom: 15,
                    ),
                    markers: marker,
                  )
                : null,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Catatan",
                    ),
                    controller: controllerCatatan,
                  ),
                ),
                const SizedBox(height: 10),
                Text("Jarak anda dengan kantor $jarak meter"),
                const SizedBox(height: 10),
                image != null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              color: Colors.transparent,
                              width: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(image!)),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: widget.colorperusahaan != null
                ? Color(widget.colorperusahaan!)
                : const Color(0xFF0D1037),
          ),
          child: const Text(
            "Clock In",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
