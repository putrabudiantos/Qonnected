import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qonnected_app/controller/coworkers_controller.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:qonnected_app/global_variabel.dart';
import 'package:qonnected_app/page/widget/banner.dart';

import '../../controller/profile_controller.dart';
import '../profile/chatkehr.dart';
import '../profile/pengingatcico.dart';
import '../profile/tentangsaya.dart';
import 'profile.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  CoWorkersController workerC = Get.put(CoWorkersController());
  final profilesC = Get.put(ProfileController());

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
                children: const [
                  SizedBox(
                    height: 35,
                  ),
                  Text("Settings",
                      style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          ),
          Container(
              transform: Matrix4.translationValues(0.0, -50.0, 0.0),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              padding: const EdgeInsets.only(top: 30),
              child: Column(
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
                      Get.to(ProfilesDetails(
                        agama: "Katholik",
                        alamat: "Japanan",
                        email: "example@gmail.com",
                        gender: "Laki-laki",
                        jabatan: "Developer",
                        nama: "Novita",
                        namaperusahaan: "MyDevTeam",
                        nip: "378dhw3",
                        nohp: "08287363",
                        npwp: "278edb3",
                        rekening: "283782634",
                        status: "Belum Menikah",
                        tanggallahir:
                            DateFormat.yMMMEd().format(DateTime.now()),
                        warnaperusahaan: 0xFF0D1037,
                        tempatlahir: "Gempol",
                        urlimage:
                            "https://www.markdesign.net/images/product/resize_755_3000/a3d63-my-devteam2.jpg",
                      ));
                    },
                    title: const Text("Profile"),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Pengingat()));
                    },
                    title: const Text("Pengingat Clock In/Out"),
                  ),
                  const Divider(color: Colors.black38),
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatHR()));
                    },
                    title: const Text("Chat ke Management"),
                  ),
                  const Divider(color: Colors.black38),
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
                  const Divider(color: Colors.black38),
                ],
              )),
        ],
      )),
    );
  }
}
