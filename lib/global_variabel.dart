import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final bgImage = Image.asset("assets/images/bg.jpeg", fit: BoxFit.cover);
final logo = Image.asset("assets/images/logo.png", fit: BoxFit.cover);
final bgImage2 = Image.asset("assets/images/bg3.jpeg", fit: BoxFit.cover);

var idx = 0;

final client = Supabase.instance.client;

FontMedium(BuildContext context, double size, FontWeight weight, Color color) {
  return GoogleFonts.inter(
    color: color,
    textStyle: Theme.of(context).textTheme.bodyLarge,
    fontSize: size,
    fontWeight: weight,
  );
}

FontHeading(BuildContext context, double size, FontWeight weight, Color color) {
  return GoogleFonts.inter(
    color: color,
    textStyle: Theme.of(context).textTheme.headline1,
    fontSize: size,
    fontWeight: weight,
  );
}
