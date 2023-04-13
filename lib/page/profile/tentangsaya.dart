import 'dart:convert';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:qonnected_app/model/profile/profile.dart';
import '../../controller/profile_controller.dart';
import './ajukanperubahansaya.dart';
import 'package:get/get.dart';
import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;

class TentangSaya extends StatefulWidget {
  @override
  State<TentangSaya> createState() => _TentangSayaState();
}

class _TentangSayaState extends State<TentangSaya> {
  final profileC = Get.put(ProfileController());

  Future<ProfileModel> fetchProfile() async {
    var headers = {
      'Authorization': 'Token adCrbmpXTUpcMokI7OkivNC71QgsV067',
      'Cookie':
          'route=1681096813.535.308.981237|1f6839247221289d5dff78ead76ea2bb'
    };
    final request = http.Request(
        'GET',
        Uri.parse(
            'https://api.baserow.io/api/database/rows/table/154795/1/?user_field_names=true'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ProfileModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  late Future<ProfileModel> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1037),
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Account',
          style: TextStyle(color: Colors.white, fontFamily: "Inter"),
        ),
      ),
      body: FutureBuilder<ProfileModel>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
              child: ListView(
                children: [
                  // circle profile image
                  if (snapshot.data!.gender == "laki-laki")
                    profileimage(
                        colorsperusahaan: 0xFF0D1037,
                        urlimage: "assets/icons/male.png",
                        name: "${snapshot.data!.fullname}",
                        jabatan: snapshot.data!.position.value,
                        namaperusahaan: snapshot.data!.company_group_id.value)
                  else
                    profileimage(
                        colorsperusahaan: 0xFF0D1037,
                        urlimage: "assets/icons/female.png",
                        name: "${snapshot.data!.fullname}",
                        jabatan: "${snapshot.data!.address}",
                        namaperusahaan: "${snapshot.data!.email}"),
                  const SizedBox(height: 10),
                  //nama
                  snapshot.data!.fullname != null
                      ? textdata(
                          context: context,
                          lable: "Name",
                          information: "${snapshot.data!.fullname}")
                      : textdata(
                          context: context, lable: "Name", information: "-"),
                  //alamat
                  snapshot.data!.address != null
                      ? textdata(
                          context: context,
                          lable: "Address",
                          information: "${snapshot.data!.address}")
                      : textdata(
                          context: context, lable: "Address", information: "-"),
                  //agama
                  snapshot.data!.nip != null
                      ? textdata(
                          context: context,
                          lable: "NIP",
                          information: "${snapshot.data!.nip}")
                      : textdata(
                          context: context, lable: "NIP", information: "-"),
                  //jabatan
                  snapshot.data!.position.value != null
                      ? textdata(
                          context: context,
                          lable: "Position",
                          information: snapshot.data!.position.value)
                      : textdata(
                          context: context,
                          lable: "Position",
                          information: "-"),
                  //email
                  snapshot.data!.email != null
                      ? textdata(
                          context: context,
                          lable: "Email",
                          information: "${snapshot.data!.email}")
                      : textdata(
                          context: context, lable: "Email", information: "-"),
                  //tempat lahir
                  snapshot.data!.place_of_birth != null
                      ? textdata(
                          context: context,
                          lable: "Place of Birth",
                          information: "${snapshot.data!.place_of_birth}")
                      : textdata(
                          context: context,
                          lable: "Place of Birth",
                          information: "-"),
                  //tanggal lahir
                  snapshot.data!.date_of_birth != null
                      ? textdata(
                          context: context,
                          lable: "Date of Birth",
                          information: "${snapshot.data!.date_of_birth}")
                      : textdata(
                          context: context,
                          lable: "Date of Birth",
                          information: "-"),
                  //Jenis kelamin
                  snapshot.data!.gender != null
                      ? textdata(
                          context: context,
                          lable: "Gender",
                          information: "${snapshot.data!.gender}")
                      : textdata(
                          context: context, lable: "Gender", information: "-"),
                  //status
                  snapshot.data!.marital_status.value != null
                      ? textdata(
                          context: context,
                          lable: "Marital Status",
                          information: snapshot.data!.marital_status.value)
                      : textdata(
                          context: context,
                          lable: "Marital Status",
                          information: "-"),
                  //nomor telpon
                  snapshot.data!.phone != null
                      ? textdata(
                          context: context,
                          lable: "Phone Number",
                          information: "${snapshot.data!.phone}")
                      : textdata(
                          context: context,
                          lable: "Phone Number",
                          information: "-"),
                  //agama
                  snapshot.data!.religion != null
                      ? textdata(
                          context: context,
                          lable: "Religion",
                          information: "${snapshot.data!.religion}")
                      : textdata(
                          context: context,
                          lable: "Religion",
                          information: "-"),
                  //NPWP
                  snapshot.data!.npwp != null
                      ? textdata(
                          context: context,
                          lable: "NPWP",
                          information: "${snapshot.data!.npwp}")
                      : textdata(
                          context: context, lable: "NPWP", information: "-"),
                  //No. Rekening
                  snapshot.data!.bank_account_number != null
                      ? textdata(
                          context: context,
                          lable: "Bank Account Number",
                          information: "${snapshot.data!.bank_account_number}")
                      : textdata(
                          context: context,
                          lable: "Bank Account Number",
                          information: "-"),
                  snapshot.data!.tiktok != null
                      ? textdata(
                          context: context,
                          lable: "TikTok Account",
                          information: "${snapshot.data!.tiktok}")
                      : textdata(
                          context: context,
                          lable: "TikTok Account",
                          information: "-"),
                  snapshot.data!.instagram != null
                      ? textdata(
                          context: context,
                          lable: "Instagram Account",
                          information: "${snapshot.data!.instagram}")
                      : textdata(
                          context: context,
                          lable: "Instagram Account",
                          information: "-"),
                  snapshot.data!.portofolio_url != null
                      ? textdata(
                          context: context,
                          lable: "Portofolio URL",
                          information: "${snapshot.data!.portofolio_url}")
                      : textdata(
                          context: context,
                          lable: "Portofolio URL",
                          information: "-"),
                  snapshot.data!.linkedin != null
                      ? textdata(
                          context: context,
                          lable: "Linkedin URL",
                          information: "${snapshot.data!.linkedin}")
                      : textdata(
                          context: context,
                          lable: "Linkedin URL",
                          information: "-"),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }

          // By default, show a loading spinner.
          return Center(
              child: Container(
            width: 70,
            height: 70,
            color: Colors.transparent,
            child: LoadingIndicator(
                indicatorType: Indicator.ballRotateChase,
                colors: [
                  Colors.blue.shade800,
                  Colors.red,
                  Colors.pink,
                  Colors.green
                ],
                strokeWidth: 2,
                backgroundColor: Colors.transparent,
                pathBackgroundColor: Colors.black),
          ));
        },
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
          child: ElevatedButton(
            onPressed: () {
              //notifikasi
              // NotificationService().showNotification(
              //     title: "Selamat ulang tahun",
              //     body: "Hari ini mas putra ulang tahun");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AjukanPerubahanSaya()));
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF0D1037),
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
            ),
            child: const Text(
              'Ajukan Perubahan',
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }

  Widget profileimage(
      {String? urlimage,
      int? colorsperusahaan,
      String? name,
      String? jabatan,
      String? namaperusahaan}) {
    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Color(colorsperusahaan!),
            borderRadius: BorderRadius.circular(80),
          ),
          child: CircleAvatar(
            child: Image.asset(
              urlimage!,
              width: 50,
              height: 50,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            Text(jabatan!),
            Text(namaperusahaan!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ],
        )
      ],
    );
  }

  //fungsi untuk box decoration information
  Column textdata({BuildContext? context, String? lable, String? information}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(" $lable",
            style: const TextStyle(fontFamily: "Inter", fontSize: 15)),
        const SizedBox(height: 5),
        Container(
          width: MediaQuery.of(context!).size.width,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26, width: 1.7),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
            child: Text(
              information!,
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 17,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}
