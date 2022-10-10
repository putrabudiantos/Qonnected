import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonRoundedWidget extends StatelessWidget {
  const ButtonRoundedWidget({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 3), blurRadius: 3.0)
          ],
          gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
                Color(0xFF0D1037),
                Color(0xFF0D1037),
              ]),
          borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: Colors.white,
            textStyle: Theme.of(context).textTheme.bodyMedium,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
