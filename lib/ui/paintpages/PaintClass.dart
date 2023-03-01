import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

class DrawMirrorImage extends CustomPainter{
  final offsets;
  DrawMirrorImage(this.offsets);

  @override
  void paint(Canvas canvas, Size size)  async{
    // ui.PictureRecorder recorder = ui.PictureRecorder();
    // Canvas canvas = Canvas(recorder);

    var paint = Paint()
      ..color = Colors.deepPurple
      ..isAntiAlias= true
      ..strokeWidth = 3.0;

    if(offsets.length!=0)
    print('entered');
    {
      var p2;
      for (var i = 0;i<offsets.length;i++){
        if(i==offsets.length-1){
          p2 = offsets[i];
        }
        else {
          p2 = offsets[i+1];
        }
       canvas.drawLine(offsets[i], p2, paint);

      }
    }
   // var Image =  await recorder.endRecording().toImage(size.width.floor(), size.height.floor());
   //  print('Image${Image}');

  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate)=> true;



}
