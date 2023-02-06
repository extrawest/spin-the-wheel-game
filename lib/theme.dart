import 'package:flutter/material.dart';

const lightOrange = Color(0xffF1EED1);
const orange1 = Color(0xffD69317);
const orange2 = Color(0xffD8AC3C);
const orange3 = Color(0xffee8b10);
const orange4 = Color(0xffb97f11);
const orange5 = Color(0xffCC890B);
const orange6 = Color(0xffFFF38F);

const darkOrange = Color(0xffc29139);

const orangeGradientLight = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment(0.5, 0.8),
  colors: [
    orange5,
    orange6,
  ],
);

class TextStyles {
  static const bodyReg16 = TextStyle(fontFamily: 'Gluten', fontSize: 16);
  static const bodyReg20 = TextStyle(fontFamily: 'Gluten', fontSize: 20, color: lightOrange);
}
