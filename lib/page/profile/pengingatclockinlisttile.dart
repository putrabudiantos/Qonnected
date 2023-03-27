import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerPengingatClockIn extends StatefulWidget {
  const ContainerPengingatClockIn({super.key});

  @override
  State<ContainerPengingatClockIn> createState() =>
      _ContainerPengingatClockInState();
}

class _ContainerPengingatClockInState extends State<ContainerPengingatClockIn> {
  bool senin = false;
  bool selasa = false;
  bool rabu = false;
  bool kamis = false;
  bool jumat = false;
  bool sabtu = false;
  bool minggu = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          thickness: 4,
          color: Colors.grey.shade100,
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Hari Pengingat Clock In",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: "Inter", fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        //Senin
        ListTile(
          title: const Text("Senin"),
          trailing: CupertinoSwitch(
            activeColor: const Color(0xFF0D1037),
            value: senin,
            onChanged: (bool? value) {
              setState(
                () {
                  senin = value ?? false;
                },
              );
            },
          ),
        ),
        Divider(
          endIndent: 17,
          indent: 17,
          color: Colors.grey.shade300,
        ),
        //Selasa
        ListTile(
          title: const Text("Selasa"),
          trailing: CupertinoSwitch(
            activeColor: const Color(0xFF0D1037),
            value: selasa,
            onChanged: (bool? value) {
              setState(
                () {
                  selasa = value ?? false;
                },
              );
            },
          ),
        ),
        Divider(
          endIndent: 17,
          indent: 17,
          color: Colors.grey.shade300,
        ),
        //Rabu
        ListTile(
          title: const Text("Rabu"),
          trailing: CupertinoSwitch(
            activeColor: const Color(0xFF0D1037),
            value: rabu,
            onChanged: (bool? value) {
              setState(
                () {
                  rabu = value ?? false;
                },
              );
            },
          ),
        ),
        Divider(
          endIndent: 17,
          indent: 17,
          color: Colors.grey.shade300,
        ),
        //Kamis
        ListTile(
          title: const Text("Kamis"),
          trailing: CupertinoSwitch(
            activeColor: const Color(0xFF0D1037),
            value: kamis,
            onChanged: (bool? value) {
              setState(
                () {
                  kamis = value ?? false;
                },
              );
            },
          ),
        ),
        Divider(
          endIndent: 17,
          indent: 17,
          color: Colors.grey.shade300,
        ),
        //Jumat
        ListTile(
          title: const Text("Jumat"),
          trailing: CupertinoSwitch(
            activeColor: const Color(0xFF0D1037),
            value: jumat,
            onChanged: (bool? value) {
              setState(
                () {
                  jumat = value ?? false;
                },
              );
            },
          ),
        ),
        Divider(
          endIndent: 17,
          indent: 17,
          color: Colors.grey.shade300,
        ),
        //Sabtu
        ListTile(
          title: const Text("Sabtu"),
          trailing: CupertinoSwitch(
            activeColor: const Color(0xFF0D1037),
            value: sabtu,
            onChanged: (bool? value) {
              setState(
                () {
                  sabtu = value ?? false;
                },
              );
            },
          ),
        ),
        Divider(
          endIndent: 17,
          indent: 17,
          color: Colors.grey.shade300,
        ),
        //Minggu
        ListTile(
          title: const Text("Minggu"),
          trailing: CupertinoSwitch(
            activeColor: const Color(0xFF0D1037),
            value: minggu,
            onChanged: (bool? value) {
              setState(
                () {
                  minggu = value ?? false;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
