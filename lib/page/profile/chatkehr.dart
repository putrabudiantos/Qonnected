import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class ChatHR extends StatefulWidget {
  const ChatHR({super.key});

  @override
  State<ChatHR> createState() => _ChatHRState();
}

class _ChatHRState extends State<ChatHR> {
  final chat = TextEditingController();

  @override
  void dispose() {
    chat.dispose();
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
          title: const Text(
            'Chat ke HR',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: ListView(
            children: [
              const Text(
                'Anda bisa konsultasi atau pesan langsung ke HR dengan mudah..',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Inter", fontSize: 16),
              ),
              const SizedBox(height: 10),
              SizedBox(
                // <-- SEE HERE
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: TextField(
                  controller: chat,
                  decoration: const InputDecoration(
                    labelText: 'Pesan Anda',
                    hintText: "Pesan anda",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: submit(
            title: "Submit",
            function: () async {
              if (chat.text.isNotEmpty) {
                await AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.scale,
                  title: 'Berhasil ajukan perubahan',
                  desc:
                      'Tunggu beberapa saat untuk dapat di ACC dari pihak HR.',
                  autoHide: const Duration(seconds: 3),
                  onDismissCallback: (type) {
                    debugPrint('Dialog Dissmiss from callback $type');
                  },
                ).show();
                Navigator.pop(context);
              }
            }));
  }

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
            'Submit',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
