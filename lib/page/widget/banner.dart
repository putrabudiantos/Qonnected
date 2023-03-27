import 'dart:ffi';

import 'package:flutter/material.dart';

class BannerCustom extends StatelessWidget {
  BannerCustom(
      {required this.customAsset,
      required this.customHeight,
      Key? key,
      String? imageUrl})
      : super(key: key);
  final String customAsset;
  final double customHeight;
  bool imageAvailable = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: size.height * customHeight,
          decoration: BoxDecoration(
            // color: greenColor,
            // borderRadius: const BorderRadius.only(
            //     bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
            image: DecorationImage(
              image: Image.network(customAsset).image,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.srcOver),
              // )
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
