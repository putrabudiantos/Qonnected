import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:qonnected_app/controller/activity_controller.dart';
import 'package:qonnected_app/controller/coworkers_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
// import 'package:qonnected_app/helper/alert.dart';
// import 'package:qonnected_app/helper/shared_preferences.dart';
// import 'package:qonnected_app/page/widget/bottom_navigation.dart';
import 'package:qonnected_app/page/widget/field_text_area.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:qonnected_app/global_variabel.dart' as vars;

enum SingingCharacter { wfo, wfh, izin, cuti }

class IndexActivity extends StatefulWidget {
  const IndexActivity({Key? key}) : super(key: key);

  @override
  State<IndexActivity> createState() => _IndexActivityState();
}

class _IndexActivityState extends State<IndexActivity> {
  final ActivityController activityC = Get.put(ActivityController());
  final CoWorkersController workerC = Get.put(CoWorkersController());

  SingingCharacter? _character = SingingCharacter.wfo;
  TextEditingController text = TextEditingController();
  var activity;
  String location = 'Null, Press Button';
  String Address = 'search';
  bool isCheckin = false;
  File? _imageFileList;
  String ImgUrl = '';
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

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

  Future<void> _setImageFileListFromFile(XFile? value) async {
    _imageFileList = File(value!.path);

    final bytes = await _imageFileList!.readAsBytes();
    final fileExt = _imageFileList!.path.split('.').last;
    final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
    final filePath = fileName;
    final response =
        await vars.client.storage.from('avatars').uploadBinary(filePath, bytes);

    final res = vars.client.storage.from('avatars').getPublicUrl(fileName);
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 100,
      );
      // final File? imagefile = File(pickedFile!.path);
      setState(() {
        _setImageFileListFromFile(pickedFile);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
    ;
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
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * .25,
            decoration: const BoxDecoration(
              color: Color(0xFF0D1037),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Obx(() => Text(workerC.companyName.value,
                      style: FontMedium(
                          context, 20, FontWeight.w800, Colors.white))),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Activity',
                      style: FontMedium(
                          context, 15, FontWeight.w500, Colors.white))
                ],
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -50.0, 0.0),
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
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
                        color: Color(0xFF0D1037),
                        fontSize: 50,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  displayActivity(),
                  // Obx(() => activityC.distanceFar.value == true
                  //     ? descriptionBox()
                  //     : Container()),
                  const SizedBox(
                    height: 20,
                  ),
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
                                      color: Color(
                                          activityC.checkOut.value == false ? 0xFF0D1037 : 0xFF4F4F56))))),
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
                        // _onImageButtonPressed(ImageSource.camera,
                        //     context: context);
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
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Obx(() => Text(activityC.isLoading == true
                            ? 'PROCESSING'
                            : 'CHECK ${activityC.checkIn.value == false || activityC.checkIn.value == null ? 'IN' : 'OUT'}')),
                      )))
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget descriptionBox() {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
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
                contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
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
                contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                title: const Text('CUTI'),
                leading: Radio<SingingCharacter>(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
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
        // FieldTextArea(
        //   textfield: '',
        //   readonly: false,
        //   customController: text,
        //   customType: false,
        //   errorMessage: '',
        //   placeholder: '',
        // ),
        // SizedBox(
        //   height: 20,
        // )
      ],
    );
  }

  Widget displayActivity() {
    return Column(
      children: [
        locations(),
        const SizedBox(
          height: 20,
        ),
        Obx(() =>
            activityC.distanceFar.value == true ? uploadFoto() : Container()),
        const SizedBox(
          height: 20,
        ),
        Obx(() =>
            activityC.distanceFar.value == true ? displayType() : Container()),
        displayDescription()
      ],
    );
  }

  Widget locations() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/icon/map.png',
          width: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Location',
                  style: FontMedium(
                      context, 15, FontWeight.w700, const Color(0xFF0D1037))),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Text(activityC.address.value,
                  style: FontMedium(
                      context, 11, FontWeight.w500, const Color(0xFF0D1037)))),
            ],
          ),
        )
      ],
    );
  }

  Widget uploadFoto() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/icon/users_upload.png',
          width: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Take a photo',
                  style: FontMedium(
                      context, 15, FontWeight.w700, const Color(0xFF0D1037))),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  _imageFileList == null
                      ? Image.asset(
                          'assets/images/icon/user.png',
                          width: 50,
                        )
                      : Image.file(
                          _imageFileList!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(10)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF0D1037)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: const BorderSide(
                                        color: Color(0xFF0D1037))))),
                    onPressed: () {
                      _onImageButtonPressed(ImageSource.camera,
                          context: context);
                    },
                    child: Text('Upload Foto',
                        style: FontMedium(
                            context, 10, FontWeight.w600, Colors.white)),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget displayDate() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/icon/map.png',
          width: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date',
                  style: FontMedium(
                      context, 15, FontWeight.w700, const Color(0xFF0D1037))),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/icon/user.png',
                    width: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget displayDescription() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/icon/check-list.png',
          width: 15,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description',
                  style: FontMedium(
                      context, 15, FontWeight.w700, const Color(0xFF0D1037))),
              const SizedBox(
                height: 10,
              ),
              FieldTextArea(
                textfield: '',
                readonly: false,
                customController: text,
                customType: false,
                errorMessage: '',
                placeholder: '',
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget displayType() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/icon/worker.png',
              width: 15,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category',
                      style: FontMedium(context, 15, FontWeight.w700,
                          const Color(0xFF0D1037))),
                  const SizedBox(
                    height: 10,
                  ),
                  descriptionBox()
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
