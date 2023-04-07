import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class KondisiWfhIzinCuti extends StatefulWidget {
  final int? colorperusahaan;
  const KondisiWfhIzinCuti({Key? key, this.colorperusahaan}) : super(key: key);

  @override
  State<KondisiWfhIzinCuti> createState() => _KondisiWfhIzinCutiState();
}

enum pilihankerja { wfh, izin, cuti }

class _KondisiWfhIzinCutiState extends State<KondisiWfhIzinCuti> {
  final deskripsi = TextEditingController();
  pilihankerja _pilihan = pilihankerja.wfh;

  @override
  void dispose() {
    deskripsi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            elevation: 6,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("CHECK IN",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  DigitalClock(
                    areaWidth: MediaQuery.of(context).size.width / 1.6,
                    showSecondsDigit: true,
                    amPmDigitTextStyle: const TextStyle(color: Colors.white),
                    is24HourTimeFormat: false,
                    hourMinuteDigitTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                    secondDigitTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 20),
                    colon: const Text(
                      ":",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.bitLength,
                        child: ListTile(
                          title: const Text("WFH"),
                          leading: Radio(
                            value: pilihankerja.wfh,
                            groupValue: _pilihan,
                            onChanged: (pilihankerja? value) {
                              setState(() {
                                _pilihan = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.bitLength,
                        child: ListTile(
                          title: const Text("IZIN"),
                          leading: Radio(
                            value: pilihankerja.izin,
                            groupValue: _pilihan,
                            onChanged: (pilihankerja? value) {
                              setState(() {
                                _pilihan = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.bitLength,
                        child: ListTile(
                          title: const Text("CUTI"),
                          leading: Radio(
                            value: pilihankerja.cuti,
                            groupValue: _pilihan,
                            onChanged: (pilihankerja? value) {
                              setState(() {
                                _pilihan = value!;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: deskripsi,
                    maxLines: 3,
                    decoration: const InputDecoration(hintText: "Alasan"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: widget.colorperusahaan != null
                    ? Color(widget.colorperusahaan!)
                    : const Color(0xFF0D1037),
              ),
              child:
                  const Text("Clock In", style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
