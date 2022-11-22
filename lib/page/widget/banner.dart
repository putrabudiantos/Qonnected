import 'dart:ffi';

import 'package:flutter/material.dart';

class bannerCustom extends StatelessWidget {
  const bannerCustom(
      {required this.customAsset, required this.customHeight, Key? key})
      : super(key: key);
  final String customAsset;
  final double customHeight;

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
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                  image: AssetImage('assets/images/icon/profile.png'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
