import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/controller/coworkers_controller.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
// import 'package:qonnected_app/global_variabel.dart';
// import 'package:qonnected_app/page/widget/banner.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IndexCoWorkers extends StatefulWidget {
  final String? urlimagecompany;
  const IndexCoWorkers({Key? key, this.urlimagecompany}) : super(key: key);

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
      'instagram': '@annonymouse'
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
      'golongandarah': '',
      'instagram': '@annonymouse'
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
      'golongandarah': '',
      'instagram': '@annonymouse'
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
      'jeniskelamin': 'wanita',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': '',
      'instagram': '@annonymouse'
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
      'jeniskelamin': 'pria',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': '',
      'instagram': '@annonymouse'
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
      'instagram': '@annonymouse'
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
      'golongandarah': '',
      'instagram': '@annonymouse'
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
      'golongandarah': '',
      'instagram': '@annonymouse'
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
      'jeniskelamin': 'wanita',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': '',
      'instagram': '@annonymouse'
    },
    {
      'nama': 'Arum Purwita Sari',
      'jabatan': 'Accounting Manager',
      'nomor': '09385839246',
      'email': '',
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
      'jeniskelamin': 'pria',
      'tanggallahir': '',
      'tempatlahir': '',
      'statuspernikahan': '',
      'agama': '',
      'golongandarah': '',
      'instagram': '@annonymouse'
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
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * .27,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CircleAvatar(
                        radius: 40,
                        // ambil gambar dari API
                        backgroundImage: NetworkImage(
                            "https://images.ctfassets.net/xvr9jywirbgw/3Hvty8DyOEUftI7YT8ecQ6/14b30fefbea79834da15b60b69bd9921/logo2.jpg"),
                      ),
                      //Nama Perusahaan diambil dari API
                      Text(
                        "MDT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      )
                    ],
                  )
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -50, 0),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (1 / 0.98),
                shrinkWrap: true,
                children: List.generate(datakaryawan.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          enableDrag: true,
                          context: context,
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.9,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                    color: Colors.white),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //slider button seperti apple
                                    Container(
                                      color: Colors.transparent,
                                      child: Container(
                                        width: 60,
                                        height: 8,
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    //info profil
                                    if (founduser[index]['jeniskelamin'] ==
                                        "wanita")
                                      Image.asset(
                                        'assets/icons/male.png',
                                        width: 60,
                                        height: 60,
                                      )
                                    else if (founduser[index]['jeniskelamin'] ==
                                        "pria")
                                      Image.asset(
                                        'assets/icons/female.png',
                                        width: 60,
                                        height: 60,
                                      )
                                    else
                                      CircleAvatar(
                                        backgroundColor: Colors.green.shade100,
                                        radius: 30,
                                        child: const Icon(
                                          Icons.person_outlined,
                                          size: 35,
                                        ),
                                      ),
                                    const SizedBox(height: 10),
                                    //informasi
                                    Text(
                                      "${founduser[index]['nama']}",
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${founduser[index]['jabatan']}",
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    //informasi socialmedia wa
                                    if (founduser[index]['whatsapp'] != '')
                                      whatsapplistile(
                                          number: founduser[index]['nomor'],
                                          ontap: () {
                                            whatsappdirect(
                                                nomor: founduser[index]
                                                    ['nomor']);
                                          }),

                                    //informasi socialmedia ig
                                    // if (founduser[index]['instagram'] != '')
                                    //   instagramlisttile(
                                    //       username: founduser[index]['instagram'],
                                    //       ontap: () {}),

                                    //informasi email
                                    if (founduser[index]['email'] != '')
                                      emaillisttile(
                                          email: founduser[index]['email'],
                                          ontap: () {
                                            launchUrlEmail(
                                                founduser[index]['email']);
                                          }),

                                    if (founduser[index]['nomor'] != '')
                                      telephone(
                                          number: founduser[index]['nomor'],
                                          ontap: () {
                                            launchUrlPhone(
                                                founduser[index]['nomor']);
                                          }),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Colors.grey.shade200, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade100,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (founduser[index]['jeniskelamin'] ==
                                    "wanita")
                                  Image.asset(
                                    'assets/icons/male.png',
                                    width: 60,
                                    height: 60,
                                  )
                                else if (founduser[index]['jeniskelamin'] ==
                                    "pria")
                                  Image.asset(
                                    'assets/icons/female.png',
                                    width: 60,
                                    height: 60,
                                  )
                                else
                                  CircleAvatar(
                                    backgroundColor: Colors.green.shade100,
                                    radius: 30,
                                    child: const Icon(
                                      Icons.person_outlined,
                                      size: 35,
                                    ),
                                  ),
                                const SizedBox(height: 7),
                                Text(
                                  "${founduser[index]['nama']}",
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${founduser[index]['jabatan']}",
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                //sementara
                                const Text(
                                  "Onsite",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    ));
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
