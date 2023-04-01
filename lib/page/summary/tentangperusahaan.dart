import 'package:flutter/material.dart';

class TentangPerusahaan extends StatelessWidget {
  const TentangPerusahaan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          //stack image untuk backgrount image perusahaan dan logo perusahaan
          banner(
              urlbackground:
                  "https://www.chendracahyadi.com/images/gallery/4d888-cover-telkom-architecture-photo-surabaya-jakarta-photography.jpg",
              urllogo:
                  "https://www.telkom.co.id/data/image_upload/page/1594108255409_compress_logo%20telkom%20indonesia.png"),

          const SizedBox(height: 55),
          //deskripsi perusahaan
          deskripsi(namaperusahaan: "Telkom Landmark Tower", deskripsi: """
  TUJUAN
Sebagai penyedia layanan properti teknologi terbaik di kelasnya mampu memberikan dampak nilai terbaik bagi pemangku kepentingan perusahaan. To make impact as best-in-class technology property service provider as well as deliver the best value to our stakeholders.


VISI
Mewujudkan sebuah perusahaan publik yang dapat menciptakan properti pintar sebagai etalase panutan dengan menerapkan kaidah ramah lingkungan dan dapat memberdayakan masyarakat. To be the showcase of smart, healthy & green property public company to empower the society


MISI
Memberikan pengalaman digital properti yang berkelanjutan untuk memberikan layanan terbaik di kelasnya kepada pelanggan. Menerapkan standar terbaik didalam aktifitas usaha yang cerdas pada manajemen tim yang lincah & ramping. Membina talenta digital di industri properti guna membantu mengembangkan kemampuan digital grup dan meningkatkan adopsi digital. Provide best-in-class digital and sustainable property services and experiences to clients. Strive to be exceptional in smart operation & service with agile team-work & lean management. Nurture digital talent in property industry that helps develop group's digital capabilities and increase digital adoption.


SASARAN
Membangun kemampuan digital dengan memanfaatkan sumber daya yang ada untuk memenangkan persaingan di pasar eksternal dan membuktikan bahwa asset yang dikelola merupakan properti pintar serta ramah terhadap kehehatan guna mengembangkan nilai manfaat pada aset perusahaan di tahun 2025. Build capabilities by leveraging digital to win in external market and showcase best-in-class smart office, smart building & healthy building to unlock value in 2025.
""")
        ],
      ),
    );
  }

  //fungsi untuk title dan subtitle perusahaan
  Padding deskripsi({String? namaperusahaan, String? deskripsi}) {
    namaperusahaan ??= "";
    deskripsi ??= "";
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              namaperusahaan,
              style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              deskripsi,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: "Inter", fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  //fungsi untuk banner background image dan logo perusahaan
  Stack banner({String? urlbackground, String? urllogo}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: Image.network(urlbackground!).image,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.srcOver),
          )),
        ),
        Positioned.fill(
          bottom: -40,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(120),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image(
                  fit: BoxFit.cover,
                  width: 70,
                  height: 70,
                  image: Image.network(
                    urllogo!,
                    scale: 0.4,
                  ).image,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
