import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qonnected_app/controller/profile_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/page/profile/myhistory.dart';
import 'package:qonnected_app/page/widget/banner.dart';
import 'package:qonnected_app/page/profile/tentangsaya.dart';
import 'package:url_launcher/url_launcher.dart';
import '../profile/pekerjaan.dart';
import '../profile/pengingatcico.dart';
import '../profile/chatkehr.dart';

class ProfilesDetails extends StatelessWidget {
  final profilesC = Get.put(ProfileController());
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

  ProfilesDetails(
      {Key? key,
      this.urlimage,
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
      this.rekening})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerCustom(
              customAsset: "$urlimage",
              customHeight: .3,
            ),
            const SizedBox(
              height: 46,
            ),

            // Info user dibawah foto gender pada tab profile
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
                  infoSummary(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('  Info Saya',
                          style: FontMedium(context, 18, FontWeight.w700,
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
                            Get.to(TentangSaya(
                                gender: gender,
                                namaperusahaan: namaperusahaan,
                                nama: nama,
                                jabatan: jabatan,
                                warnaperusahaan: warnaperusahaan,
                                agama: agama,
                                alamat: alamat,
                                email: email,
                                nip: nip,
                                nohp: nohp,
                                npwp: npwp,
                                rekening: rekening,
                                tanggallahir: tanggallahir,
                                status: status,
                                tempatlahir: tempatlahir));
                          },
                          icons: Icons.person,
                          colors: Colors.black),
                      iconsButton(
                          functions: () {
                            Get.to(MyHistory(
                              urlimages: "$urlimage",
                            ));
                          },
                          icons: Icons.list,
                          colors: Colors.black),
                      iconsButton(
                          functions: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                    'Log Out',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: const Text(
                                      'Apakah anda yakin ingin keluar dari akun ini?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        profilesC.SignOut(context);
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
                          style: FontMedium(context, 18, FontWeight.w700,
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
                              whatsappdirect(nomor: nohp);
                            },
                            icons: FontAwesomeIcons.whatsapp,
                            colors: Colors.green),
                        const SizedBox(width: 15),
                        iconsButton(
                            functions: () {
                              launchUrlEmail(email);
                            },
                            icons: Icons.email,
                            colors: Colors.yellow.shade900),
                        const SizedBox(width: 15),
                        iconsButton(
                            functions: () {},
                            icons: FontAwesomeIcons.instagram,
                            colors: Colors.purple.shade900),
                        const SizedBox(width: 15),
                        iconsButton(
                            functions: () {},
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
                      iconsButton(
                          functions: () {},
                          icons: FontAwesomeIcons.tiktok,
                          colors: Colors.black),
                      const SizedBox(width: 15),
                      iconsButton(
                          functions: () {},
                          icons: FontAwesomeIcons.internetExplorer,
                          colors: Colors.blueAccent),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
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

  Widget infoSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          summary(context),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget summary(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textSummary(context, 'WFH', '0'),
            textSummary(context, 'IZIN', '0'),
            textSummary(context, 'CUTI', '0')
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
          profilesC.SignOut(context);
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

  Widget textSummary(BuildContext context, String title, String summary) {
    return Column(
      children: [
        Text(summary,
            style: FontMedium(
                context, 20, FontWeight.w700, const Color(0xFF0D1037))),
        Text(title,
            style: FontMedium(
                context, 10, FontWeight.w500, const Color(0xFF0D1037)))
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
  //fungsi untuk alert saat ingin log out

}

/*
            roundedCard(context, 'profile', Icons.person_outline_outlined),
            roundedCard(context, 'home', Icons.person_outline_outlined),
            roundedCard(context, 'logout', Icons.logout_outlined),
*/
