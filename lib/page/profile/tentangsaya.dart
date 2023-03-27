import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qonnected_app/service/notifforbirthday.dart';
import './ajukanperubahansaya.dart';
import 'package:get/get.dart';

class TentangSaya extends StatelessWidget {
  const TentangSaya({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1037),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text('Info Personal'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
        child: ListView(
          children: [
            //nama
            textdata(
                context: context,
                lable: "Nama",
                information: "Saputra Budianto"),
            //alamat
            textdata(
                context: context, lable: "Alamat", information: "Sidoarjo"),
            //agama
            textdata(
              context: context,
              lable: "NIP",
              information: "A15B",
            ),
            //jabatan
            textdata(
                context: context,
                lable: "Jabatan",
                information: "Mobile Developer"),
            //email
            textdata(
                context: context,
                lable: "Email",
                information: "localhosting8080@gmail.com"),
            //tempat lahir
            textdata(
                context: context,
                lable: "Tempat Lahir",
                information: "Surabaya"),
            //tanggal lahir
            textdata(
                context: context,
                lable: "Tanggal lahir",
                information: "23/11/1999"),
            //Jenis kelamin
            textdata(
                context: context,
                lable: "Jenis kelamin",
                information: "Laki-laki"),
            //status
            textdata(context: context, lable: "Status", information: "Lajang"),
            //nomor telpon
            textdata(
                context: context,
                lable: "Nomor Hp",
                information: "081237131587"),
            //agama
            textdata(
              context: context,
              lable: "Agama",
              information: "Islam",
            ),
            //NPWP
            textdata(
              context: context,
              lable: "NPWP",
              information: "38294729384",
            ),
            //No. Rekening
            textdata(
              context: context,
              lable: "Nomor Rekening",
              information: "14133958384",
            ),
          ],
        ),
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
            child: const Text('Ajukan Perubahan'),
          )),
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
