import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF006B53);
const Color secondaryColor = Color(0xFFDCF7EB);
const Color tertiaryColor = Color(0xFFEDF8F3);

const MaterialColor primaryGreen = MaterialColor(
  _greenPrimaryValue,
  <int, Color>{
    50: Color(0xFF006B53),
    100: Color(0xFF006B53),
    200: Color(0xFF006B53),
    300: Color(0xFF006B53),
    400: Color(0xFF006B53),
    500: Color(_greenPrimaryValue),
    600: Color(0xFF006B53),
    700: Color(0xFF006B53),
    800: Color(0xFF006B53),
    900: Color(0xFF006B53),
  },
);
const int _greenPrimaryValue = 0xFF006B53;