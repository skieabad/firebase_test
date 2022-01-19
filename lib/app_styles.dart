import 'package:firebase_test/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kPrimaryColor = const Color(0xffFC9D45);
Color kSecondaryColor = const Color(0xff573353);
Color white = const Color(0xffFFFFFF);
Color black = const Color(0xff000000);
Color etc = const Color(0xFF808080);

final kTitle = GoogleFonts.roboto(
    fontSize: SizeConfig.blockSizeH! * 7,
    color: black,
    fontWeight: FontWeight.bold);

final kTitle1 = GoogleFonts.roboto(
  fontSize: SizeConfig.blockSizeH! * 6,
  color: kSecondaryColor,
);

final kBodyText1 = TextStyle(
  color: kSecondaryColor,
  fontSize: SizeConfig.blockSizeH! * 7,
  fontWeight: FontWeight.bold,
);
