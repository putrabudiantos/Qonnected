import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/controller/coworkers_controller.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
// import 'package:qonnected_app/global_variabel.dart';
// import 'package:qonnected_app/page/widget/banner.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:qonnected_app/model/dummydata.dart';
import 'package:qonnected_app/page/coworker/detailku.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IndexCoWorkers extends StatefulWidget {
  final String? urlimagecompany;
  final int? warnaperusahaan;
  final String? namaperusahaan;
  const IndexCoWorkers(
      {Key? key,
      this.urlimagecompany,
      this.warnaperusahaan,
      this.namaperusahaan})
      : super(key: key);

  @override
  State<IndexCoWorkers> createState() => _IndexCoWorkersState();
}

class _IndexCoWorkersState extends State<IndexCoWorkers> {
  CoWorkersController workerC = Get.put(CoWorkersController());

  int jumlahkaryawan = 0;
  bool adagambar = true;

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
      'golongandarah': '',
      'instagram': '@annonymouse',
      'status': 'wfh'
    },
    {
      'nama': 'Karina Santika',
      'jabatan': 'English Translator',
      'nomor': '09385839246',
      'email': 'example@email.com',
      'imageurl':
          'https://media.licdn.com/dms/image/C5603AQGNQzV3KSgoQg/profile-displayphoto-shrink_800_800/0/1660284631987?e=2147483647&v=beta&t=nlOwOQFoyKmAka1IhrZNrwEiCn-WTKggsuEdDtFs270',
      'namaperusahaan': 'PT. Indofood Indonesia',
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
      'golongandarah': '',
      'instagram': '@annonymouse',
      'status': 'wfh'
    },
    {
      'nama': 'Intan Nurita Sari',
      'jabatan': 'Accounting Manager',
      'nomor': '09385839246',
      'email': 'example@email.com',
      'imageurl':
          'https://media.licdn.com/dms/image/C5603AQHK1Q2_PzWEwA/profile-displayphoto-shrink_800_800/0/1634366567499?e=1683158400&v=beta&t=7cVDzVNJml0F17c7qxHX18mHptzL6ABWKDgzsgdR48g',
      'namaperusahaan': 'PT. Maspion',
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
      'golongandarah': '',
      'instagram': '@annonymouse',
      'status': 'wfh'
    },
    {
      'nama': 'Ariska Riris',
      'jabatan': 'Accounting Manager',
      'nomor': '09385839246',
      'email': 'example@email.com',
      'imageurl':
          'https://media.licdn.com/dms/image/C5603AQEpLLe7GUZ-Fw/profile-displayphoto-shrink_800_800/0/1627022282091?e=2147483647&v=beta&t=AQ_RkkT0mmbU0WcFvSQ-c-6N1JEjAvfHEKXfkc9Ohc0',
      'namaperusahaan': 'PT. Jacobis',
      'cabang': '',
      'departement': '',
      'posisipekerjaan': '',
      'levelpekerjaan': '',
      'statuspekerjaan': '',
      'tanggalbergabung': '',
      'masakerja': '',
      'idkaryawan': '',
      'jeniskelamin': 'wanita',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': '',
      'instagram': '@annonymouse',
      'status': 'wfh'
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
      'posisipekerjaan': 'MyDevTeam',
      'levelpekerjaan': '',
      'statuspekerjaan': '',
      'tanggalbergabung': '',
      'masakerja': '',
      'idkaryawan': '',
      'jeniskelamin': 'pria',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': '',
      'instagram': '@annonymouse',
      'status': 'wfh'
    },
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
      'golongandarah': '',
      'instagram': '@annonymouse',
      'status': 'wfo'
    },
    {
      'nama': 'Karina Santika',
      'jabatan': 'English Translator',
      'nomor': '09385839246',
      'email': 'example@email.com',
      'imageurl':
          'https://media.licdn.com/dms/image/C5603AQGNQzV3KSgoQg/profile-displayphoto-shrink_800_800/0/1660284631987?e=2147483647&v=beta&t=nlOwOQFoyKmAka1IhrZNrwEiCn-WTKggsuEdDtFs270',
      'namaperusahaan': 'Telkom Indonesia',
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
      'golongandarah': '',
      'instagram': '@annonymouse',
      'status': 'wfo'
    },
    {
      'nama': 'Intan Nurita Sari',
      'jabatan': 'Accounting Manager',
      'nomor': '09385839246',
      'email': 'example@email.com',
      'imageurl':
          'https://media.licdn.com/dms/image/C5603AQHK1Q2_PzWEwA/profile-displayphoto-shrink_800_800/0/1634366567499?e=1683158400&v=beta&t=7cVDzVNJml0F17c7qxHX18mHptzL6ABWKDgzsgdR48g',
      'namaperusahaan': 'MNC Media',
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
      'golongandarah': '',
      'instagram': '@annonymouse',
      'status': 'wfh'
    },
    {
      'nama': 'Ariska Riris',
      'jabatan': 'Accounting Manager',
      'nomor': '09385839246',
      'email': 'example@email.com',
      'imageurl':
          'https://media.licdn.com/dms/image/C5603AQEpLLe7GUZ-Fw/profile-displayphoto-shrink_800_800/0/1627022282091?e=2147483647&v=beta&t=AQ_RkkT0mmbU0WcFvSQ-c-6N1JEjAvfHEKXfkc9Ohc0',
      'namaperusahaan': 'PT. Wika',
      'cabang': '',
      'departement': '',
      'posisipekerjaan': '',
      'levelpekerjaan': '',
      'statuspekerjaan': '',
      'tanggalbergabung': '',
      'masakerja': '',
      'idkaryawan': '',
      'jeniskelamin': 'wanita',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': '',
      'instagram': '@annonymouse',
      'status': 'wfh'
    },
    {
      'nama': 'Arum Purwita Sari',
      'jabatan': 'Accounting Manager',
      'nomor': '09385839246',
      'email': '',
      'imageurl':
          'https://media.licdn.com/dms/image/D5603AQEJZLMKFcYW_A/profile-displayphoto-shrink_800_800/0/1677652695634?e=1683158400&v=beta&t=uC3BYaus8_ukTV8CvWwYwuP-fEnjn5jmDu4e7e8GtNE',
      'namaperusahaan': 'PT. Gudang Garam TBk',
      'cabang': '',
      'departement': '',
      'posisipekerjaan': '',
      'levelpekerjaan': '',
      'statuspekerjaan': '',
      'tanggalbergabung': '',
      'masakerja': '',
      'idkaryawan': '',
      'jeniskelamin': 'pria',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': '',
      // 'instagram': '@annonymouse',
      'status': 'wfh'
    },
  ];

  @override
  initState() {
    founduser = datakaryawan;
    super.initState();
  }

  //fungsi untuk direct ke aplikasi gmail
  Future<void> launchUrlEmail(String? to) async {
    if (!await launchUrl(Uri(
        scheme: 'mailto',
        path: to,
        queryParameters: {'subject': 'Pekerjaan'}))) {
      throw Exception('Could not launch $to');
    }
  }

  //fungsi untuk direct ke aplikasi telpon
  Future<void> launchUrlPhone(String? tocall) async {
    if (!await launchUrl(Uri.parse('tel:$tocall'))) {
      throw Exception('Could not launch $tocall');
    }
  }

  // fungsi untuk direct ke aplikasi whatsapp
  Future<void> whatsappdirect({String? nomor, String? pesan}) async {
    bool whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");
    if (whatsapp) {
      await FlutterLaunch.launchWhatsapp(phone: nomor!, message: pesan!);
    }
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
  Widget build(BuildContext context) {
    String? url = widget.urlimagecompany;
    int? warna = widget.warnaperusahaan;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        title: url!.isEmpty
            ? Column(
                children: [
                  Image.asset('assets/icons/revisi/logo.png',
                      width: 80, height: 80),
                  Text(
                    "${widget.namaperusahaan}",
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : Column(
                children: [
                  Image.network(url),
                  Text(
                    "${widget.namaperusahaan}",
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (1 / 0.8),
          shrinkWrap: true,
          children: List.generate(datakaryawan.length, (index) {
            return GestureDetector(
                onTap: () {
                  Get.to(
                    Detailku(
                      urlimages:
                          "https://www.markdesign.net/images/product/resize_755_3000/a3d63-my-devteam2.jpg",
                      nama: founduser[index]['nama'],
                      jabatan: founduser[index]['jabatan'],
                      namaperusahaan: founduser[index]['namaperusahaan'],
                      gender: founduser[index]['jeniskelamin'],
                      email: founduser[index]['email'],
                      ig: founduser[index]['instagram'],
                      whatsapp: founduser[index]['nomor'],
                      phone: founduser[index]['nomor'],
                    ),
                  );
                },
                child: Column(
                  children: [
                    // container background image sesuai warna perusahaan
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: warna == null
                              ? const Color(0xFF0D1037)
                              : Color(warna)),
                      child: founduser[index]['jeniskelamin'] == "pria"
                          ? Padding(
                              padding: const EdgeInsets.all(13),
                              child: Image.asset(
                                'assets/icons/male.png',
                                width: 20,
                                height: 20,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(13),
                              child: Image.asset(
                                'assets/icons/female.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                    ),
                    const SizedBox(height: 10),
                    // Nama user
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          founduser[index]['nama'],
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        founduser[index]['status'] == "wfh"
                            ? status(color: Colors.amber.shade300)
                            : status(color: Colors.green.shade500),
                      ],
                    ),
                    Text(founduser[index]['jabatan'])
                  ],
                ));
          }),
        ),
      ),
    );
  }

  Container status({Color? color}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
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

ListTile whatsapplistile({String? number, Function()? ontap}) {
  return ListTile(
    onTap: ontap,
    hoverColor: Colors.grey,
    selectedColor: Colors.grey.shade300,
    leading: FaIcon(
      FontAwesomeIcons.whatsapp,
      color: Colors.green.shade600,
    ),
    title: Text(
      number!,
      style: const TextStyle(color: Colors.black),
    ),
  );
}

ListTile emaillisttile({String? email, Function()? ontap}) {
  return ListTile(
    onTap: ontap,
    hoverColor: Colors.green,
    selectedColor: Colors.grey.shade300,
    leading: FaIcon(
      Icons.email,
      color: Colors.yellow.shade700,
    ),
    title: Text(
      email!,
      style: const TextStyle(color: Colors.black),
    ),
  );
}

ListTile telephone({String? number, Function()? ontap}) {
  return ListTile(
    onTap: ontap,
    hoverColor: Colors.green,
    selectedColor: Colors.grey.shade300,
    leading: FaIcon(Icons.phone, color: Colors.blue.shade300),
    title: Text(
      number!,
      style: const TextStyle(color: Colors.black),
    ),
  );
}
