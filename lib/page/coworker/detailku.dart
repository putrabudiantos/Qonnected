import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qonnected_app/page/widget/banner.dart';

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
      this.phone})
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
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      whatsapp != null
                          ? iconsButton(
                              functions: () {},
                              icons: FontAwesomeIcons.whatsapp,
                              colors: Colors.green)
                          : const SizedBox(height: 0, width: 0),
                      email != null
                          ? iconsButton(
                              functions: () {},
                              icons: Icons.email,
                              colors: Colors.orange)
                          : const SizedBox(height: 0, width: 0),
                      phone != null
                          ? iconsButton(
                              functions: () {},
                              icons: Icons.call,
                              colors: Colors.red)
                          : const SizedBox(height: 0, width: 0),
                      ig != null
                          ? iconsButton(
                              functions: () {},
                              icons: FontAwesomeIcons.instagram,
                              colors: Colors.purple.shade300)
                          : const SizedBox(height: 0, width: 0),
                      linkedin != null
                          ? iconsButton(
                              functions: () {},
                              icons: FontAwesomeIcons.linkedin,
                              colors: Colors.blue)
                          : const SizedBox(height: 0, width: 0),
                    ],
                  ),
                )
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
}
