import 'package:flutter/material.dart';
import './ajukanperubahansaya.dart';
import 'package:get/get.dart';

class TentangSaya extends StatelessWidget {
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
  TentangSaya(
      {Key? key,
      this.gender,
      this.nama,
      this.jabatan,
      this.namaperusahaan,
      this.warnaperusahaan,
      this.agama,
      this.alamat,
      this.email,
      this.nip,
      this.npwp,
      this.nohp,
      this.rekening,
      this.tanggallahir,
      this.status,
      this.tempatlahir})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warnaperusahaan == null
            ? const Color(0xFF0D1037)
            : Color(warnaperusahaan!),
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Account',
          style: TextStyle(color: Colors.white, fontFamily: "Inter"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
        child: ListView(
          children: [
            // circle profile image
            if (gender == "laki-laki")
              profileimage(
                  colorsperusahaan: warnaperusahaan,
                  urlimage: "assets/icons/male.png",
                  name: nama,
                  jabatan: jabatan,
                  namaperusahaan: namaperusahaan)
            else
              profileimage(
                  colorsperusahaan: warnaperusahaan,
                  urlimage: "assets/icons/female.png",
                  name: nama,
                  jabatan: jabatan,
                  namaperusahaan: namaperusahaan),
            const SizedBox(height: 10),
            //nama
            nama != null
                ? textdata(
                    context: context, lable: "Nama", information: "$nama")
                : textdata(context: context, lable: "Nama", information: "-"),
            //alamat
            alamat != null
                ? textdata(
                    context: context, lable: "Alamat", information: "$alamat")
                : textdata(context: context, lable: "Alamat", information: "-"),
            //agama
            nip != null
                ? textdata(context: context, lable: "NIP", information: nip)
                : textdata(context: context, lable: "NIP", information: "-"),
            //jabatan
            jabatan != null
                ? textdata(
                    context: context, lable: "Jabatan", information: "$jabatan")
                : textdata(
                    context: context, lable: "Jabatan", information: "-"),
            //email
            email != null
                ? textdata(
                    context: context, lable: "Email", information: "$email")
                : textdata(context: context, lable: "Email", information: "-"),
            //tempat lahir
            tempatlahir != null
                ? textdata(
                    context: context,
                    lable: "Tempat Lahir",
                    information: "$tempatlahir")
                : textdata(
                    context: context, lable: "Tempat Lahir", information: "-"),
            //tanggal lahir
            tanggallahir != null
                ? textdata(
                    context: context,
                    lable: "Tanggal lahir",
                    information: "$tanggallahir")
                : textdata(
                    context: context, lable: "Tempat Lahir", information: "-"),
            //Jenis kelamin
            gender != null
                ? textdata(
                    context: context,
                    lable: "Jenis kelamin",
                    information: "$gender")
                : textdata(
                    context: context, lable: "Jenis kelamin", information: "-"),
            //status
            status != null
                ? textdata(
                    context: context, lable: "Status", information: "$status")
                : textdata(context: context, lable: "Status", information: "-"),
            //nomor telpon
            nohp != null
                ? textdata(
                    context: context, lable: "Nomor Hp", information: "$nohp")
                : textdata(context: context, lable: "No Hp", information: "-"),
            //agama
            agama != null
                ? textdata(
                    context: context, lable: "Agama", information: "$agama")
                : textdata(context: context, lable: "Agama", information: "-"),
            //NPWP
            npwp != null
                ? textdata(
                    context: context, lable: "NPWP", information: "$npwp")
                : textdata(context: context, lable: "NPWP", information: "-"),
            //No. Rekening
            rekening != null
                ? textdata(
                    context: context,
                    lable: "Nomor Rekening",
                    information: "$rekening")
                : textdata(
                    context: context, lable: "Nomer Rekening", information: "-")
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
            child: const Text(
              'Ajukan Perubahan',
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }

  Widget profileimage(
      {String? urlimage,
      int? colorsperusahaan,
      String? name,
      String? jabatan,
      String? namaperusahaan}) {
    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Color(colorsperusahaan!),
            borderRadius: BorderRadius.circular(80),
          ),
          child: CircleAvatar(
            child: Image.asset(
              urlimage!,
              width: 50,
              height: 50,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            Text(jabatan!),
            Text(namaperusahaan!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ],
        )
      ],
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
