import 'package:flutter/material.dart';
import 'package:qonnected_app/controller/profile_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:qonnected_app/page/widget/banner.dart';
import 'package:qonnected_app/page/profile/tentangsaya.dart';
import '../profile/pekerjaan.dart';
import '../profile/pengingatcico.dart';

class IndexSettings extends StatelessWidget {
  final profilesC = Get.put(ProfileController());

  IndexSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerCustom(
              customAsset:
                  'https://www.markdesign.net/images/product/resize_755_3000/a3d63-my-devteam2.jpg',
              customHeight: .3,
            ),
            const SizedBox(
              height: 18,
            ),
            infoSummary(context)
          ],
        ),
      ),
    );
  }

  Widget infoSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          summary(context),
          const SizedBox(
            height: 20,
          ),
          info(context),
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

  Widget info(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('  Info Saya',
            style: FontMedium(
                context, 18, FontWeight.w700, const Color(0xFF0D1037))),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              iconColor: Colors.black87,
              textColor: Colors.black87,
              leading: const Icon(Icons.person_outline_rounded),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TentangSaya()));
              },
              title: const Text("Personal"),
            ),
            const Divider(color: Colors.black38),
            ListTile(
              iconColor: Colors.black87,
              textColor: Colors.black87,
              leading: const Icon(Icons.work_outline_outlined),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Pekerjaan()));
              },
              title: const Text("Pekerjaan"),
            ),
            const Divider(color: Colors.black38),
            ListTile(
              iconColor: Colors.black87,
              textColor: Colors.black87,
              leading: const Icon(Icons.warning_amber_rounded),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
              ),
              onTap: () {},
              title: const Text("Peringatan"),
            ),
            const Divider(color: Colors.black38),
            ListTile(
              iconColor: Colors.black87,
              textColor: Colors.black87,
              leading: const Icon(Icons.alarm),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Pengingat()));
              },
              title: const Text("Pengingat Clock In/Out"),
            ),
            const Divider(color: Colors.black38),
            const SizedBox(height: 10),
            Text('  Bantuan',
                style: FontMedium(
                    context, 18, FontWeight.w700, const Color(0xFF0D1037))),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              iconColor: Colors.black87,
              textColor: Colors.black87,
              leading: const Icon(Icons.star_border),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
              ),
              onTap: () {},
              title: const Text("Berikan Ulasan"),
            ),
            const Divider(color: Colors.black38),
            ListTile(
              iconColor: Colors.black87,
              textColor: Colors.black87,
              leading: const Icon(Icons.chat_bubble_outline_rounded),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
              ),
              onTap: () {},
              title: const Text("Chat ke Management"),
            ),
            const Divider(color: Colors.black38),

            //List tile untuk log out
            ListTile(
              iconColor: Colors.black87,
              textColor: Colors.black87,
              leading: const Icon(Icons.exit_to_app),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
              ),
              onTap: () => showDialog<String>(
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
                      onPressed: () => Navigator.pop(context, 'Cancel'),
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
              title: const Text("Log Out"),
            ),
          ],
        )
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
          Get.toNamed(route);
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

  //fungsi untuk alert saat ingin log out

}

/*
            roundedCard(context, 'profile', Icons.person_outline_outlined),
            roundedCard(context, 'home', Icons.person_outline_outlined),
            roundedCard(context, 'logout', Icons.logout_outlined),
*/
