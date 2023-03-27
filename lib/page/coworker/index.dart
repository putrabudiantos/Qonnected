import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/controller/coworkers_controller.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:qonnected_app/global_variabel.dart';
import 'package:qonnected_app/page/widget/banner.dart';

class IndexCoWorkers extends StatefulWidget {
  const IndexCoWorkers({Key? key}) : super(key: key);

  @override
  State<IndexCoWorkers> createState() => _IndexCoWorkersState();
}

class _IndexCoWorkersState extends State<IndexCoWorkers> {
  CoWorkersController workerC = Get.put(CoWorkersController());
  final searchcontroller = TextEditingController();
  int jumlahkaryawan = 0;

  List<Map<String, dynamic>> founduser = [];

  List<Map<String, String>> datakaryawan = [
    {
      'nama': 'Nadzila Afifa',
      'jabatan': 'Accounting Manager',
      'nomor': '09385839246',
      'email': 'example@email.com',
      'imageurl':
          'https://media.licdn.com/dms/image/C5603AQF4UMVifTENjA/profile-displayphoto-shrink_800_800/0/1630468969909?e=2147483647&v=beta&t=udbP56QjpMVwOfl-m7Z_NLiXWxU_WjnCTw8LOHgbPNw',
      'namaperusahaan': 'PT Gojek Indonesia',
      'cabang': 'Surabaya',
      'departement': 'Indihome',
      'posisipekerjaan': 'Accounting Manager',
      'levelpekerjaan': 'Tetap',
      'statuspekerjaan': '',
      'tanggalbergabung': '',
      'masakerja': '',
      'idkaryawan': '',
      'jeniskelamin': '',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': ''
    },
    {
      'nama': 'Karina Santika',
      'jabatan': 'English Translator',
      'nomor': '09385839246',
      'email': 'example@email.com',
      'imageurl':
          'https://media.licdn.com/dms/image/C5603AQGNQzV3KSgoQg/profile-displayphoto-shrink_800_800/0/1660284631987?e=2147483647&v=beta&t=nlOwOQFoyKmAka1IhrZNrwEiCn-WTKggsuEdDtFs270',
      'namaperusahaan': '',
      'cabang': '',
      'departement': '',
      'posisipekerjaan': '',
      'levelpekerjaan': '',
      'statuspekerjaan': '',
      'tanggalbergabung': '',
      'masakerja': '',
      'idkaryawan': '',
      'jeniskelamin': '',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': ''
    },
    {
      'nama': 'Intan Nurita Sari',
      'jabatan': 'Accounting Manager',
      'nomor': '09385839246',
      'email': 'example@email.com',
      'imageurl':
          'https://media.licdn.com/dms/image/C5603AQHK1Q2_PzWEwA/profile-displayphoto-shrink_800_800/0/1634366567499?e=1683158400&v=beta&t=7cVDzVNJml0F17c7qxHX18mHptzL6ABWKDgzsgdR48g',
      'namaperusahaan': '',
      'cabang': '',
      'departement': '',
      'posisipekerjaan': '',
      'levelpekerjaan': '',
      'statuspekerjaan': '',
      'tanggalbergabung': '',
      'masakerja': '',
      'idkaryawan': '',
      'jeniskelamin': '',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': ''
    },
    {
      'nama': 'Ariska Riris',
      'jabatan': 'Accounting Manager',
      'nomor': '09385839246',
      'email': 'example@email.com',
      'imageurl':
          'https://media.licdn.com/dms/image/C5603AQEpLLe7GUZ-Fw/profile-displayphoto-shrink_800_800/0/1627022282091?e=2147483647&v=beta&t=AQ_RkkT0mmbU0WcFvSQ-c-6N1JEjAvfHEKXfkc9Ohc0',
      'namaperusahaan': '',
      'cabang': '',
      'departement': '',
      'posisipekerjaan': '',
      'levelpekerjaan': '',
      'statuspekerjaan': '',
      'tanggalbergabung': '',
      'masakerja': '',
      'idkaryawan': '',
      'jeniskelamin': '',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': ''
    },
    {
      'nama': 'Arum Purwita Sari',
      'jabatan': 'Accounting Manager',
      'nomor': '09385839246',
      'email': 'example@email.com',
      'imageurl':
          'https://media.licdn.com/dms/image/D5603AQEJZLMKFcYW_A/profile-displayphoto-shrink_800_800/0/1677652695634?e=1683158400&v=beta&t=uC3BYaus8_ukTV8CvWwYwuP-fEnjn5jmDu4e7e8GtNE',
      'namaperusahaan': '',
      'cabang': '',
      'departement': '',
      'posisipekerjaan': '',
      'levelpekerjaan': '',
      'statuspekerjaan': '',
      'tanggalbergabung': '',
      'masakerja': '',
      'idkaryawan': '',
      'jeniskelamin': '',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': ''
    },
  ];

  @override
  initState() {
    founduser = datakaryawan;
    super.initState();
  }

  //fungsi untuk mencari nama karyawan
  void runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> result = [];
    if (enteredKeyword.isEmpty) {
      result = datakaryawan;
    } else {
      result = datakaryawan
          .where((element) => element['nama']!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(
      () {
        founduser = result;
      },
    );
  }

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

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

                  Text("Jumlah Karyawan ${datakaryawan.length}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                          fontSize: 17)),

                  const SizedBox(height: 15),
                  // Obx(() => Text('${workerC.coworkersModel.value.length} Teams',
                  //     style: FontMedium(
                  //         context, 15, FontWeight.w500, Colors.white))),
                  TextField(
                    onChanged: (value) => runFilter(value),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.white),
                        fillColor: Colors.grey.shade800,
                        contentPadding: const EdgeInsets.all(17),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "Cari",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            transform: Matrix4.translationValues(0.0, -50.0, 0.0),
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            padding: const EdgeInsets.only(top: 30),
            child: Obx(() => Wrap(
                  children: [
                    for (var i = 0; i < workerC.coworkersModel.length; i++)
                      cardList(
                          workerC.coworkersModel.value[i].fullname!,
                          workerC.coworkersModel.value[i].position!,
                          workerC.coworkersModel.value[i].worker_status!),
                  ],
                )),
          ),
        ],
      )),
    );
  }

  cardList(String name, String position, String status) {
    dynamic act;
    if (status == 'wfo') {
      act = Colors.green;
    } else if (status == 'wfh') {
      act = Colors.blue;
    } else if (status == 'izin') {
      act = Colors.grey;
    } else if (status == 'cuti') {
      act = Colors.black;
    } else {
      act = Colors.red;
    }

    return Container(
        width: MediaQuery.of(context).size.width * .5 - 20,
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: const [
                    Icon(
                      Icons.person_outline_rounded,
                      size: 50,
                    ),
                  ]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: vars.FontMedium(
                      context,
                      14,
                      FontWeight.w600,
                      const Color(0xFF0D1037),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: act,
                  )
                ],
              ),
              Text(
                position,
                style: vars.FontMedium(
                  context,
                  10,
                  FontWeight.w500,
                  const Color(0xFF0D1037),
                ),
              ),
            ]));
  }
}
