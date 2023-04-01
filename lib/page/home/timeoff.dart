import 'package:flutter/material.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

enum SingingCharacter { cuti, ijin }

class TimeOff extends StatefulWidget {
  const TimeOff({super.key});

  @override
  State<TimeOff> createState() => _TimeOffState();
}

class _TimeOffState extends State<TimeOff> {
  SingingCharacter? character = SingingCharacter.cuti;
  final alasanC = TextEditingController();
  List status = [
    {'label': 'Ditolak', 'value': 'Ditolak'}, // label is required and unique
    {'label': 'Diterima', 'value': 'Diterima'},
  ];

  final dateC = TextEditingController();
  final hariC = TextEditingController();

  @override
  void initState() {
    dateC.text = "";
    super.initState();
  }

  //fungsi untuk radio button
  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Pengajuan TimeOff'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Radio<SingingCharacter>(
                                  value: SingingCharacter.cuti,
                                  groupValue: character,
                                  onChanged: (SingingCharacter? value) {
                                    setState(() {
                                      character = value;
                                    });
                                  }),
                              const Expanded(
                                child: Text('Cuti'),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Radio<SingingCharacter>(
                                  value: SingingCharacter.ijin,
                                  groupValue: character,
                                  onChanged: (SingingCharacter? value) {
                                    character = value;
                                  }),
                              const Expanded(
                                child: Text('Ijin'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: dateC,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Tanggal',
                        icon: Icon(Icons.date_range_outlined),
                      ),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2025));

                        if (pickeddate != null) {
                          print(pickeddate);
                          String formatdate =
                              DateFormat('dd-MM-yyyy').format(pickeddate);

                          setState(() {
                            dateC.text = formatdate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    TextFormField(
                      controller: alasanC,
                      decoration: const InputDecoration(
                        labelText: 'Alasan',
                        icon: Icon(Icons.text_snippet_outlined),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: hariC,
                      decoration: const InputDecoration(
                        labelText: 'Banyak cuti satuan Hari',
                        icon: Icon(Icons.numbers_rounded),
                      ),
                      onTap: () async {},
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: const Text("Batal"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: const Text("Submit"),
                  onPressed: () async {
                    print(dateC.text);
                    print(alasanC.text);
                    print(hariC.text);
                    if (alasanC.text.isNotEmpty &&
                        dateC.text.isNotEmpty &&
                        hariC.text.isNotEmpty) {
                      await AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.scale,
                        title: "Berhasil",
                        desc:
                            'Berhasil request TimeOff, permintaan anda akan direview oleh tim HR dan anda akan mendapatkan notifikasi.',
                        autoHide: const Duration(seconds: 3),
                        onDismissCallback: (type) {
                          debugPrint('Dialog Dissmiss from callback $type');
                        },
                      ).show();
                      Navigator.pop(context);
                    }
                  })
            ],
          );
        });
  }

  String? codeDialog;
  String? valueText;

  @override
  void dispose() {
    hariC.dispose();
    dateC.dispose();
    alasanC.dispose();
    super.dispose();
  }

//time off UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF0D1037),
        title: const Text(
          "Time Off",
          style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white),
        ),
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () async {
                // requestingform(context: context, alasanC: alasan);
                displayTextInputDialog(context);
              },
              tooltip: "Request time off",
              icon: const Icon(FontAwesomeIcons.hand))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            CoolDropdown(
              dropdownHeight: 150,
              resultWidth: 150,
              dropdownWidth: 120,
              dropdownList: status,
              onChange: (_) {},
              defaultValue: status[0],
            ),
            cardtimeoff(
                employeeid: "12",
                name: "Frendy",
                status: "rejected",
                title: "Ijin cuti",
                date: "12-31-2023"),
            const SizedBox(height: 15),
            cardtimeoff(
                employeeid: "13",
                name: "Putra",
                status: "accepted",
                title: "Ijin cuti",
                date: "12-31-2023"),
            const SizedBox(height: 15),
            cardtimeoff(
                employeeid: "12",
                name: "Frendy",
                status: "rejected",
                title: "Ijin cuti",
                date: "12-31-2023"),
            const SizedBox(height: 15),
            cardtimeoff(
                employeeid: "13",
                name: "Putra",
                status: "accepted",
                title: "Ijin cuti",
                date: "12-31-2023"),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  //fungsi untuk membuat kontainer timeoff untuk employee view
  Widget cardtimeoff(
      {String? title,
      String? date,
      String? name,
      String? employeeid,
      String? status}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // untuk judul request izin
            Text(
              title!,
              style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            // untuk tanggal timeoff
            Text(
              "Tanggal : $date",
              style: const TextStyle(fontFamily: "Inter", fontSize: 13),
            ),
            // garis divider
            Divider(
              color: Colors.grey.shade700,
            ),
            // row untuk circleavatar, nama, dan employe id
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(height: 5),
                Text(
                  "Employee id :  $employeeid",
                  style: const TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ],
            ),
            // garis divider
            Divider(
              color: Colors.grey.shade700,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Status : "),
                if (status == "accepted")
                  const Text(
                    "Diijinkan",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 15),
                  ),
                if (status == "rejected")
                  const Text(
                    "Tidak Diijinkan",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 13),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
