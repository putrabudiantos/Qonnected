import 'package:flutter/material.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/page/widget/banner.dart';

class IndexProfile extends StatelessWidget {
  const IndexProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          bannerCustom(
            customAsset:
                'https://www.markdesign.net/images/product/resize_755_3000/a3d63-my-devteam2.jpg',
          ),
          SizedBox(height: 50,),
        InfoSummary(context)
         
        ],
      )),
    );
  }

  Widget InfoSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Summary(context),
          SizedBox(
            height: 20,
          ),
          Info(context),
        ],
      ),
    );
  }

  Widget Summary(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextSummary(context, 'WFH', '0'),
            TextSummary(context, 'IZIN', '0'),
            TextSummary(context, 'CUTI', '0')
          ],
        ),
      ),
    );
  }

  Widget Info(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Info',
            style: FontMedium(context, 15, FontWeight.w700, Color(0xFF0D1037))),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            RoundedCard('home', Icons.person_outline_outlined),
            RoundedCard('home', Icons.person_outline_outlined),
            RoundedCard('home', Icons.logout_outlined),
          ],
        )
      ],
    );
  }

  Widget Sosmed(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sosial Media',
            style: FontMedium(context, 15, FontWeight.w700, Color(0xFF0D1037))),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            RoundedCard('home', Icons.person_outline_outlined),
            RoundedCard('home', Icons.person_outline_outlined),
            RoundedCard('home', Icons.logout_outlined),
          ],
        )
      ],
    );
  }

  Widget RoundedCard(String route, IconData icon) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                size: 25,
              ),
            ))),
      ),
    );
  }

  Widget TextSummary(BuildContext context, String title, String summary) {
    return Column(
      children: [
        Text(summary,
            style: FontMedium(context, 20, FontWeight.w700, Color(0xFF0D1037))),
        Text(title,
            style: FontMedium(context, 10, FontWeight.w500, Color(0xFF0D1037)))
      ],
    );
  }
}
