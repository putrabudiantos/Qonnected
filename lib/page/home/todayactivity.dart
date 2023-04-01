import 'package:flutter/material.dart';

Widget todaysActivity(
    {String? gender, String? name, String? date, String? status}) {
  return Padding(
    padding: const EdgeInsets.only(left: 25, right: 25),
    child: Column(
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //penentuan gambar laki atau perempuan
            gender == 'laki-laki'
                ? Image.asset('assets/icons/male.png', width: 30, height: 30)
                : Image.asset('assets/icons/female.png', width: 30, height: 30),

            const SizedBox(width: 10),
            //penentuan wfh atau wfo
            status == 'wfh' ? onsite() : remote(),
            Text(
              " $name",
              style: const TextStyle(fontFamily: "Inter", fontSize: 15),
            ),
            status == "wfh" ? wfh() : wfo(),
            Text(" $date")
          ],
        ),
        const SizedBox(height: 5),
        const Divider(
          color: Colors.black26,
        ),
      ],
    ),
  );
}

Text wfo() {
  return const Text(" WFO",
      style: TextStyle(
          fontFamily: "Inter", fontSize: 15, fontWeight: FontWeight.bold));
}

Text wfh() {
  return const Text(" WFH",
      style: TextStyle(
          fontFamily: "Inter", fontSize: 15, fontWeight: FontWeight.bold));
}

Text izin() {
  return const Text("IZIN",
      style: TextStyle(
          fontFamily: "Inter", fontSize: 15, fontWeight: FontWeight.bold));
}

Container onsite() {
  return Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(
        color: Colors.green, borderRadius: BorderRadius.circular(20)),
  );
}

Container remote() {
  return Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(
        color: Colors.red, borderRadius: BorderRadius.circular(20)),
  );
}
