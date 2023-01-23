import 'package:flutter/material.dart';

Widget getText(text,double textSize,FontWeight fontWeight,Color color){

  return Text(text,

    style:  TextStyle(
      fontSize: textSize,
      fontWeight: fontWeight  ,
      color: color

    ),
  );
}