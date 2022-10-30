import 'package:flutter/material.dart';

class bannerCustom extends StatelessWidget {
  const bannerCustom(
      {
      required this.customAsset,
      Key? key})
      : super(key: key);
  final String customAsset;

  @override
  Widget build(BuildContext context) {
        
    Size size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: size.height * .3,
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                  image: NetworkImage(
                      'https://www.tutorialkart.com/img/hummingbird.png'),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
