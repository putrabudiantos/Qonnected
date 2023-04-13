import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              bannerProfiles(
                context: context,
              ),
              const SizedBox(height: 30),
              const Text(
                "Nama Perusahaan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              infoContainer(effectiveday: "0")
            ]),
      ),
    );
  }

// fungsi untuk gambar dan stack button di atas gambar
  Widget bannerProfiles(
      {BuildContext? context, String? urlimages, String? gender}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context!).size.height * .3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: urlimages == null
                  ? const NetworkImage(
                      'https://akcdn.detik.net.id/community/media/visual/2022/09/22/ilustrasi-legalitas-perusahaan_169.jpeg?w=700&q=90')
                  : NetworkImage(urlimages),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            left: 10,
            top: 25,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ))),
      ],
    );
  }

  // fungsi untuk informasi hari efektif dan hari libur
  Widget infoContainer({String? effectiveday, String? holyday}) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 80,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            children: [Text(effectiveday ?? "-"), const Text("Hari Efektif")],
          ),
          const VerticalDivider(
            thickness: 2,
            color: Colors.black54,
          ),
          Column(
            children: [Text(holyday ?? "-"), const Text("Hari Libur")],
          ),
        ]),
      ),
    );
  }
}
