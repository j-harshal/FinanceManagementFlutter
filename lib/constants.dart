import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MyTheme {
  MyTheme._();
  static Color kPrimaryColor = const Color(0xff7C7B9B);
  static Color kPrimaryColorVariant = const Color(0xff686795);
  static Color kAccentColor = const Color(0xffFCAAAB);
  static Color kAccentColorVariant = const Color(0xffF7A3A2);
  static Color kUnreadChatBG = const Color(0xffEE1D1D);

  static final TextStyle kAppTitle = GoogleFonts.grandHotel(
    fontSize: 36,
  );

  static final TextStyle heading2 = TextStyle(
    color: Color(0xff686795),
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );

  static final TextStyle chatSenderName = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );

  static final TextStyle bodyText1 = TextStyle(
      color: Color(0xffAEABC9),
      fontSize: 14,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w500);

  static final TextStyle kHeadingTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 23,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w500);

  static final TextStyle bodyTextMessage =
  TextStyle(fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.w600);

  static final TextStyle bodyTextTime = TextStyle(
    color: Color(0xffAEABC9),
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
}

class Colours {
  static Color purplish = Color(0xFF4e3d77);
  static Color orangyish = Color(0xFFFFac00);
  static Color greyish = Color(0xFF656566);
}
