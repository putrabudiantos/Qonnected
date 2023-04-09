import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qonnected_app/model/dummydata.dart';
import 'package:qonnected_app/page/widget/banner.dart';
import 'package:url_launcher/url_launcher.dart';

class Detailku extends StatelessWidget {
  final String? nama;
  final String? namaperusahaan;
  final String? jabatan;
  final String? urlimages;
  final String? gender;
  final String? whatsapp;
  final String? ig;
  final String? linkedin;
  final String? email;
  final String? tiktok;
  final String? phone;
  final int? index;
  final String? urlportofolio;
  const Detailku(
      {Key? key,
      this.nama,
      this.namaperusahaan,
      this.jabatan,
      this.urlimages,
      this.gender,
      this.whatsapp,
      this.ig,
      this.linkedin,
      this.email,
      this.tiktok,
      this.phone,
      this.index,
      this.urlportofolio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          BannerCustom(
              customAsset: "$urlimages", customHeight: .3, gender: "$gender"),
          const SizedBox(height: 46),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Text("$nama",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("$jabatan"),
                Text(
                  "$namaperusahaan",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Social Media",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    whatsapp != null
                        ? iconsButton(
                            functions: () {
                              whatsappdirect(
                                  nomor: phone, pesan: "Assalamualaikum\n");
                            },
                            icons: FontAwesomeIcons.whatsapp,
                            colors: Colors.green)
                        : const SizedBox(height: 0, width: 0),
                    email != null
                        ? iconsButton(
                            functions: () {
                              launchUrlEmail(email);
                            },
                            icons: Icons.email,
                            colors: Colors.orange)
                        : const SizedBox(height: 0, width: 0),
                    phone != null
                        ? iconsButton(
                            functions: () {
                              launchUrlPhone(phone);
                            },
                            icons: Icons.call,
                            colors: Colors.red)
                        : const SizedBox(height: 0, width: 0),
                    ig != null
                        ? iconsButton(
                            functions: () {
                              launchinstagram(username: ig);
                            },
                            icons: FontAwesomeIcons.instagram,
                            colors: Colors.purple.shade300)
                        : const SizedBox(height: 0, width: 0),
                    linkedin != null
                        ? iconsButton(
                            functions: () {
                              launchlinkedin(linkedinurl: linkedin);
                            },
                            icons: FontAwesomeIcons.linkedin,
                            colors: Colors.blue)
                        : const SizedBox(height: 0, width: 0),
                    tiktok != null
                        ? IconButton(
                            onPressed: () {
                              launchtiktok(username: tiktok);
                            },
                            icon: const Icon(
                              FontAwesomeIcons.tiktok,
                              color: Colors.white,
                            ))
                        : const SizedBox(height: 0, width: 0),
                    urlportofolio != null
                        ? IconButton(
                            onPressed: () {
                              launchurlportofolio(urlportofolio: urlportofolio);
                            },
                            icon: Icon(
                              FontAwesomeIcons.internetExplorer,
                              color: Colors.blue.shade700,
                            ))
                        : const SizedBox(height: 0, width: 0),
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  // Widget untuk icon social media
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
