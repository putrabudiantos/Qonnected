import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AjukanPerubahanSaya extends StatefulWidget {
  const AjukanPerubahanSaya({Key? key}) : super(key: key);

  @override
  State<AjukanPerubahanSaya> createState() => _AjukanPerubahanSayaState();
}

class _AjukanPerubahanSayaState extends State<AjukanPerubahanSaya> {
  final status = TextEditingController();
  final email = TextEditingController();
  final nohp = TextEditingController();
  final alamat = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    status.dispose();
    email.dispose();
    nohp.dispose();
    alamat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1037),
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: const Text('Ajukan Perubahan',
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: ListView(
          children: [
            const Text(
              'Ajukan perubahan data akan menunggu konfirmasi dari tim HR untuk dapat di ACC. Anda bisa mengedit semua atau beberapa informasi yang ingin diubah.',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "Inter", fontSize: 16),
            ),
            const SizedBox(height: 10),
            editing(
                controller: email,
                label: "Email",
                type: TextInputType.emailAddress),
            const SizedBox(height: 10),
            editing(
                controller: nohp, label: "No Hp", type: TextInputType.phone),
            const SizedBox(height: 10),
            editing(
                controller: alamat,
                label: "Alamat",
                type: TextInputType.streetAddress),
            const SizedBox(height: 10),
            editing(
                controller: status, label: "Status", type: TextInputType.name),
          ],
        ),
      ),
      bottomNavigationBar: submit(
        title: "Submit",
        function: () async {
          if (status.text.isEmpty ||
              email.text.isEmpty ||
              nohp.text.isEmpty ||
              alamat.text.isEmpty) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.scale,
              title: 'Gagal',
              desc:
                  'Mohon isi salah satu form untuk dapat request perubahan data.',
              autoHide: const Duration(seconds: 2),
              onDismissCallback: (type) {
                debugPrint('Dialog Dissmiss from callback $type');
              },
            ).show();
          }
          if (status.text.isNotEmpty ||
              email.text.isNotEmpty ||
              nohp.text.isNotEmpty ||
              alamat.text.isNotEmpty) {
            await AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.scale,
              title: 'Berhasil ajukan perubahan',
              desc: 'Tunggu beberapa saat untuk dapat di ACC dari pihak HR.',
              autoHide: const Duration(seconds: 3),
              onDismissCallback: (type) {
                debugPrint('Dialog Dissmiss from callback $type');
              },
            ).show();
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  //fungsi untuk textfield
  TextField editing(
      {String? label,
      String? isi,
      TextEditingController? controller,
      TextInputType? type}) {
    return TextField(
      keyboardType: type!,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0D1037)),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        labelText: label,
      ),
    );
  }

  //fungsi umtuk button submit
  Padding submit({String? title, Function()? function}) {
    return Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
        child: ElevatedButton(
          onPressed: function,
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
        ));
  }
}
