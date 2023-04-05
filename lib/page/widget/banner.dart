import 'package:flutter/material.dart';

class BannerCustom extends StatelessWidget {
  final String customAsset;
  final double customHeight;
  final bool imageAvailable = false;
  final String? gender;
  const BannerCustom(
      {required this.customAsset,
      required this.customHeight,
      this.gender,
      Key? key,
      String? imageUrl})
      : super(key: key);

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
        Positioned(
            right: 10,
            top: 25,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ))),
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
                child: Image(
                  width: 50,
                  height: 50,
                  //nanti ini dirubah sesuai API
                  image: gender == "pria"
                      ? Image.asset('assets/icons/male.png',
                              width: 30, height: 30)
                          .image
                      : Image.asset('assets/icons/female.png',
                              width: 30, height: 30)
                          .image,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
