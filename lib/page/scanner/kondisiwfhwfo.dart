import 'package:awesome_dialog/awesome_dialog.dart';
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

  void handler(String value) {
    setState(() {
      _pilihan = value as pilihankerja;
    });
  }

  @override
  void dispose() {
    deskripsi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Clock In",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        backgroundColor: widget.colorperusahaan != null
            ? Color(widget.colorperusahaan!)
            : const Color(0xFF0D1037),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Card(
              elevation: 6,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("CLOCK IN",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      DigitalClock(
                        areaWidth: MediaQuery.of(context).size.width / 1.6,
                        showSecondsDigit: true,
                        amPmDigitTextStyle:
                            const TextStyle(color: Colors.white),
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
                          Container(
                              child: Row(
                            children: [
                              Radio(
                                value: pilihankerja.wfh,
                                groupValue: _pilihan,
                                onChanged: (pilihankerja? value) {
                                  setState(() {
                                    _pilihan = value!;
                                  });
                                },
                              ),
                              const Text("WFH"),
                            ],
                          )),
                          Container(
                              child: Row(
                            children: [
                              Radio(
                                value: pilihankerja.izin,
                                groupValue: _pilihan,
                                onChanged: (pilihankerja? value) {
                                  setState(() {
                                    _pilihan = value!;
                                  });
                                },
                              ),
                              const Text("IZIN"),
                            ],
                          )),
                          Container(
                              child: Row(
                            children: [
                              Radio(
                                value: pilihankerja.cuti,
                                groupValue: _pilihan,
                                onChanged: (pilihankerja? value) {
                                  setState(() {
                                    _pilihan = value!;
                                  });
                                },
                              ),
                              const Text("CUTI"),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        minLines: 4,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                          labelText: 'Alasan',
                        ),
                      ),
                      Text(
                        "Anda dihitung sebagai $_pilihan",
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Berhasil',
                    desc: 'Berhasil Clock In.',
                    autoHide: const Duration(seconds: 2),
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: widget.colorperusahaan != null
                      ? Color(widget.colorperusahaan!)
                      : const Color(0xFF0D1037),
                ),
                child: const Text("Clock In",
                    style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
