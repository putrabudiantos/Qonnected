import 'package:flutter/material.dart';

class MyHistory extends StatefulWidget {
  final String? urlimages;
  String? gender;
  MyHistory({Key? key, this.urlimages}) : super(key: key);

  @override
  State<MyHistory> createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  @override
  Widget build(BuildContext context) {
    String? urlimagess = widget.urlimages;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [bannerProfiles(heights: .3, urlimages: urlimagess)],
      ),
    ));
  }

  Widget bannerProfiles({String? urlimages, double? heights}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * heights!,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(urlimages!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          bottom: -40,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: const Image(
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                  image: AssetImage('assets/images/person.png'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
