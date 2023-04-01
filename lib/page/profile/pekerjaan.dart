import 'package:flutter/material.dart';

class Pekerjaan extends StatelessWidget {
  const Pekerjaan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1037),
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Info Pekerjaan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
        child: ListView(
          children: [
            //nama
            textdata(
                context: context,
                lable: "BPJS Ketenagakerjaan",
                information: "319829842"),
            textdata(
                context: context,
                lable: "BPJS Kesehatan",
                information: "319829842"),
            textdata(
                context: context, lable: "Masa Kerja", information: "245 Hari"),
            textdata(
                context: context,
                lable: "Waktu Kontrak",
                information: "43 Hari"),
            textdata(
                context: context,
                lable: "Status Karyawan",
                information: "Full Time / PKWTT"),
          ],
        ),
      ),
    );
  }

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
