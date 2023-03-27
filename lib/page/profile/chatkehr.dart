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
        automaticallyImplyLeading: true,
        title: const Text('Ajukan Perubahan'),
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
              width: 200,
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
    );
  }
}
