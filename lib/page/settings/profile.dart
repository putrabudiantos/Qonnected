import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:qonnected_app/controller/firebaseauth/authrepo/authenticationrepository.dart';
import 'package:qonnected_app/controller/profile_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qonnected_app/model/profile/profile.dart';
import 'package:qonnected_app/page/profile/myhistory.dart';
import 'package:qonnected_app/page/widget/banner.dart';
import 'package:qonnected_app/page/profile/tentangsaya.dart';
import 'package:url_launcher/url_launcher.dart';
import '../profile/pekerjaan.dart';
import '../profile/pengingatcico.dart';
import '../profile/chatkehr.dart';

class ProfilesDetails extends StatefulWidget {
  String? urlimage;
  String? gender;
  String? nama;
  String? jabatan;
  String? namaperusahaan;
  int? warnaperusahaan;
  String? alamat;
  String? nip;
  String? tempatlahir;
  String? email;
  String? npwp;
  String? tanggallahir;
  String? agama;
  String? nohp;
  String? rekening;
  String? status;
  String? jumlahwfh;
  String? jumlahizin;
  String? jumlahcuti;
  String? instagram;
  String? date;
  String? hour;
  String? tiktok;
  String? urllinkedin;
  String? urlportofolio;

  ProfilesDetails(
      {Key? key,
      this.urlimage,
      this.urlportofolio,
      this.urllinkedin,
      this.tiktok,
      this.nama,
      this.jabatan,
      this.namaperusahaan,
      this.gender,
      this.warnaperusahaan,
      this.alamat,
      this.nip,
      this.tempatlahir,
      this.email,
      this.npwp,
      this.tanggallahir,
      this.status,
      this.agama,
      this.nohp,
      this.instagram,
      this.jumlahcuti,
      this.jumlahizin,
      this.jumlahwfh,
      this.date,
      this.hour,
      this.rekening})
      : super(key: key);

  @override
  State<ProfilesDetails> createState() => _ProfilesDetailsState();
}

class _ProfilesDetailsState extends State<ProfilesDetails> {
  final profilesC = Get.put(ProfileController());

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
      body: FutureBuilder<ProfileModel>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    bannerProfiles(
                        context: context,
                        gender: snapshot.data!.gender,
                        urlimages: widget.urlimage),
                    const SizedBox(
                      height: 46,
                    ),

                    // Info user dibawah foto gender pada tab profile
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          // Nama
                          snapshot.data!.fullname != null
                              ? Text("${snapshot.data!.fullname}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                              : const Text("-"),

                          // Jabatan
                          snapshot.data!.position.value != null
                              ? Text(snapshot.data!.position.value)
                              : const Text("-"),

                          // Nama Perusahaan
                          snapshot.data!.company_group_id.value != null
                              ? Text(
                                  snapshot.data!.company_group_id.value,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              : const Text("-"),

                          infoSummary(
                            jumlahcuti: widget.jumlahcuti != null
                                ? "${widget.jumlahcuti}"
                                : "0",
                            jumlahizin: widget.jumlahizin != null
                                ? "${widget.jumlahizin}"
                                : "0",
                            jumlahwfh: widget.jumlahwfh != null
                                ? "${widget.jumlahwfh}"
                                : "0",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('  Info Saya',
                                  style: FontMedium(
                                      context,
                                      18,
                                      FontWeight.w700,
                                      const Color(0xFF0D1037))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Button profile user
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //untuk integrasi API data lewat kelas parameter ini
                              iconsButton(
                                  functions: () {
                                    Get.to(TentangSaya());
                                  },
                                  icons: Icons.person,
                                  colors: Colors.black),
                              iconsButton(
                                  functions: () {
                                    Get.to(MyHistory(
                                      urlimages: "${widget.urlimage}",
                                      gender: widget.gender,
                                      jabatan: widget.jabatan,
                                      nama: widget.nama,
                                      namaperusahaan: widget.namaperusahaan,
                                      date: widget.date,
                                      hour: widget.hour,
                                      status: widget.status,
                                    ));
                                  },
                                  icons: Icons.list,
                                  colors: Colors.black),
                              iconsButton(
                                  functions: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                            'Log Out',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: const Text(
                                              'Apakah anda yakin ingin keluar dari akun ini?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Batal'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                // profilesC.SignOut(context);
                                                AuthenticationRepository
                                                    .instance
                                                    .logout();
                                              },
                                              child: const Text('Keluar'),
                                            ),
                                          ],
                                        ),
                                      ),
                                  icons: Icons.exit_to_app_rounded,
                                  colors: Colors.black)
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Button profile user
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('  Social Media',
                                  style: FontMedium(
                                      context,
                                      18,
                                      FontWeight.w700,
                                      const Color(0xFF0D1037))),
                            ],
                          ),
                          const SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                iconsButton(
                                    functions: () {
                                      whatsappdirect(
                                          nomor: snapshot.data!.phone,
                                          pesan: "Assalamualaikum");
                                    },
                                    icons: FontAwesomeIcons.whatsapp,
                                    colors: Colors.green),
                                const SizedBox(width: 15),
                                iconsButton(
                                    functions: () {
                                      launchUrlEmail(snapshot.data!.email);
                                    },
                                    icons: Icons.email,
                                    colors: Colors.yellow.shade900),
                                const SizedBox(width: 15),
                                snapshot.data!.instagram != null
                                    ? iconsButton(
                                        functions: () {
                                          launchinstagram(
                                              username:
                                                  snapshot.data!.instagram);
                                        },
                                        icons: FontAwesomeIcons.instagram,
                                        colors: Colors.purple.shade900)
                                    : Container(),
                                const SizedBox(width: 15),
                                snapshot.data!.linkedin != null
                                    ? iconsButton(
                                        functions: () {
                                          launchlinkedin(
                                              linkedinurl:
                                                  snapshot.data!.linkedin);
                                        },
                                        icons: FontAwesomeIcons.linkedin,
                                        colors: Colors.blue.shade400)
                                    : Container()
                              ],
                            ),
                          ),

                          const SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              snapshot.data!.tiktok != null
                                  ? iconsButton(
                                      functions: () {
                                        launchtiktok(
                                            username: snapshot.data!.tiktok);
                                      },
                                      icons: FontAwesomeIcons.tiktok,
                                      colors: Colors.black)
                                  : const SizedBox(height: 0, width: 0),
                              const SizedBox(width: 15),
                              snapshot.data!.portofolio_url != null
                                  ? iconsButton(
                                      functions: () {
                                        launchurlportofolio(
                                            urlportofolio:
                                                widget.urlportofolio);
                                      },
                                      icons: FontAwesomeIcons.internetExplorer,
                                      colors: Colors.blueAccent)
                                  : Container()
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    bannerProfiles(
                        context: context,
                        gender: snapshot.data!.gender,
                        urlimages: widget.urlimage),
                    const SizedBox(
                      height: 46,
                    ),

                    // Info user dibawah foto gender pada tab profile
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          // Nama
                          widget.nama != null
                              ? Text("${widget.nama}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                              : const Text("-"),

                          // Jabatan
                          widget.jabatan != null
                              ? Text("${widget.jabatan}")
                              : const Text("-"),

                          // Nama Perusahaan
                          widget.namaperusahaan != null
                              ? Text(
                                  "${widget.namaperusahaan}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              : const Text("-"),

                          infoSummary(
                            jumlahcuti: widget.jumlahcuti != null
                                ? "${widget.jumlahcuti}"
                                : "0",
                            jumlahizin: widget.jumlahizin != null
                                ? "${widget.jumlahizin}"
                                : "0",
                            jumlahwfh: widget.jumlahwfh != null
                                ? "${widget.jumlahwfh}"
                                : "0",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('  Info Saya',
                                  style: FontMedium(
                                      context,
                                      18,
                                      FontWeight.w700,
                                      const Color(0xFF0D1037))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Button profile user
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //untuk integrasi API data lewat kelas parameter ini
                              iconsButton(
                                  functions: () {
                                    Get.to(TentangSaya());
                                  },
                                  icons: Icons.person,
                                  colors: Colors.black),
                              iconsButton(
                                  functions: () {
                                    Get.to(MyHistory(
                                      urlimages: "${widget.urlimage}",
                                      gender: widget.gender,
                                      jabatan: widget.jabatan,
                                      nama: widget.nama,
                                      namaperusahaan: widget.namaperusahaan,
                                      date: widget.date,
                                      hour: widget.hour,
                                      status: widget.status,
                                    ));
                                  },
                                  icons: Icons.list,
                                  colors: Colors.black),
                              iconsButton(
                                  functions: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                            'Log Out',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: const Text(
                                              'Apakah anda yakin ingin keluar dari akun ini?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Batal'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                // profilesC.SignOut(context);
                                                AuthenticationRepository
                                                    .instance
                                                    .logout();
                                              },
                                              child: const Text('Keluar'),
                                            ),
                                          ],
                                        ),
                                      ),
                                  icons: Icons.exit_to_app_rounded,
                                  colors: Colors.black)
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Button profile user
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('  Social Media',
                                  style: FontMedium(
                                      context,
                                      18,
                                      FontWeight.w700,
                                      const Color(0xFF0D1037))),
                            ],
                          ),
                          const SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                iconsButton(
                                    functions: () {
                                      whatsappdirect(
                                          nomor: widget.nohp,
                                          pesan: "Assalamualaikum");
                                    },
                                    icons: FontAwesomeIcons.whatsapp,
                                    colors: Colors.green),
                                const SizedBox(width: 15),
                                iconsButton(
                                    functions: () {
                                      launchUrlEmail(widget.email);
                                    },
                                    icons: Icons.email,
                                    colors: Colors.yellow.shade900),
                                const SizedBox(width: 15),
                                iconsButton(
                                    functions: () {
                                      launchinstagram(
                                          username: widget.instagram);
                                    },
                                    icons: FontAwesomeIcons.instagram,
                                    colors: Colors.purple.shade900),
                                const SizedBox(width: 15),
                                iconsButton(
                                    functions: () {
                                      launchlinkedin(
                                          linkedinurl: widget.urllinkedin);
                                    },
                                    icons: FontAwesomeIcons.linkedin,
                                    colors: Colors.blue.shade400)
                              ],
                            ),
                          ),

                          const SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.tiktok != null
                                  ? iconsButton(
                                      functions: () {
                                        launchtiktok(username: widget.tiktok);
                                      },
                                      icons: FontAwesomeIcons.tiktok,
                                      colors: Colors.black)
                                  : const SizedBox(height: 0, width: 0),
                              const SizedBox(width: 15),
                              iconsButton(
                                  functions: () {
                                    launchurlportofolio(
                                        urlportofolio: widget.urlportofolio);
                                  },
                                  icons: FontAwesomeIcons.internetExplorer,
                                  colors: Colors.blueAccent),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
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
          }),
    );
  }

  Widget bannerProfiles(
      {BuildContext? context, String? urlimages, String? gender}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context!).size.height * .3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: urlimages == null
                  ? const NetworkImage(
                      'https://akcdn.detik.net.id/community/media/visual/2022/09/22/ilustrasi-legalitas-perusahaan_169.jpeg?w=700&q=90')
                  : NetworkImage(urlimages),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          bottom: -40,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image(
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                    image: gender == "laki-laki"
                        ? const AssetImage('assets/icons/male.png')
                        : const AssetImage('assets/icons/female.png')),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget iconsButton({IconData? icons, Function()? functions, Color? colors}) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 5,
      child: GestureDetector(
        onTap: functions,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey.shade100,
          ),
          child: Icon(
            icons,
            color: colors,
          ),
        ),
      ),
    );
  }

  Widget infoSummary(
      {String? jumlahwfh, String? jumlahizin, String? jumlahcuti}) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          summary(
              jumlahwfh: "$jumlahwfh",
              jumlahizin: "$jumlahizin",
              jumlahcuti: "$jumlahcuti"),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget summary({String? jumlahwfh, String? jumlahizin, String? jumlahcuti}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textSummary(status: "WFH", jumlah: "$jumlahwfh"),
            textSummary(status: "IZIN", jumlah: "$jumlahizin"),
            textSummary(status: "CUTI", jumlah: "$jumlahcuti")
          ],
        ),
      ),
    );
  }

  Widget info(BuildContext context, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: FontMedium(
                context, 18, FontWeight.w700, const Color(0xFF0D1037))),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget sosmed(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sosial Media',
            style: FontMedium(
                context, 18, FontWeight.w700, const Color(0xFF0D1037))),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            roundedCard(context, 'home', Icons.person_outline_outlined),
            roundedCard(context, 'home', Icons.person_outline_outlined),
            roundedCard(context, 'logout', Icons.logout_outlined),
          ],
        )
      ],
    );
  }

  Widget roundedCard(BuildContext context, String route, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (route == 'logout') {
          print('a');
          profilesC.signOut(context);
        } else {
          Get.to(route);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                size: 25,
              ),
            ))),
      ),
    );
  }

  Widget textSummary({String? status, String? jumlah}) {
    return Column(
      children: [
        Text("$jumlah",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        Text(status!, style: const TextStyle(fontSize: 15))
      ],
    );
  }

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

  // fungsi untuk direct ke aplikasi instagram
  Future<void> launchinstagram({String? username}) async {
    final url = Uri.parse("https://instagram.com/$username");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  // fungsi untuk direct ke aplikasi tiktok
  Future<void> launchtiktok({String? username}) async {
    final url = Uri.parse("https://tiktok.com/@$username");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  // fungsi untuk direct ke aplikasi linkedin
  Future<void> launchlinkedin({String? linkedinurl}) async {
    final url = Uri.parse("$linkedinurl");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  // fungsi untuk direct ke aplikasi tiktok
  Future<void> launchurlportofolio({String? urlportofolio}) async {
    final url = Uri.parse("$urlportofolio");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

/*
            roundedCard(context, 'profile', Icons.person_outline_outlined),
            roundedCard(context, 'home', Icons.person_outline_outlined),
            roundedCard(context, 'logout', Icons.logout_outlined),
*/
