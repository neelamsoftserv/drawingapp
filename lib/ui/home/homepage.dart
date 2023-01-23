import 'dart:ui';

import 'package:drawingapp/widgets/gettext.dart';
import 'package:flutter/material.dart';
import '../paintpages/PaintClass.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


 final _offsets = <Offset>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   title: getText("home", 14, FontWeight.w400, Colors.black),
      // ),
      body: Column(
        children: [
          GestureDetector(
              onPanDown: (details){
                //_offsets.clear();
                final renderBox =  context.findRenderObject() as RenderBox;
                final localPostion = renderBox.globalToLocal(details.globalPosition);
                _offsets.add(localPostion);
                print('localPostion${localPostion}');
                setState(() {});
              },
              onPanStart: (details){
                final renderBox =  context.findRenderObject() as RenderBox;
                final localPostion = renderBox.globalToLocal(details.globalPosition);
                _offsets.add(localPostion);
                setState(() {});
              },
              onPanUpdate: (details){
                final renderBox =  context.findRenderObject() as RenderBox;
                final localPostion = renderBox.globalToLocal(details.globalPosition);
                _offsets.add(localPostion);
                print('localPostion on update${localPostion}');
                setState(() {});
              },
              onPanEnd: null,
              child: ClipRect (
                clipBehavior: Clip.hardEdge,
                child: CustomPaint(
                  painter: FlipBookPainter(_offsets),
                  //foregroundPainter:FlipBookPainter(_offsets) ,
                  child:  Container(
                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height/2-30,
                    // color: Colors.red[50],

                  ),
                ),
              )

          ),
          const Divider(
            thickness: 2, color: Colors.black,
          ),
          const SizedBox(height: 10,),
          ClipRect(
            clipBehavior: Clip.hardEdge,
            child: CustomPaint(
                painter: FlipBookPainter(_offsets),
                child: RotatedBox(
                  quarterTurns: 4,
                  child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height/2,
                  // color: Colors.red[50],

                ),
              ),
            ),
          ),


        ],
      )


      // Container(
      //   padding: const EdgeInsets.only(left: 20,right: 20),
      //   child: Column(
      //     children: [
      //       Expanded(
      //           child: Container(
      //             width: MediaQuery.of(context).size.width,
      //             height: MediaQuery.of(context).size.height,
      //             color: Colors.white,
      //             child: CustomPaint(
      //               painter: PaintClass(),
      //             ),
      //
      //           )
      //       ),
      //       Container(
      //         padding: const EdgeInsets.all(10),
      //         child: Row(
      //           children: [
      //             _buildButtonUI(100.0,50.0, Colors.blue,"Edit"),
      //             const SizedBox(width: 10,),
      //             _buildButtonUI(100.0,50.0, Colors.green,"Save")
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
  Widget _buildButtonUI( double btnWidth, double btnHeight, Color btnBackgroundColor,btnName){
    return   Container(
       width: 100, height: 45,
       alignment: Alignment.center,
       decoration: BoxDecoration(
         color: btnBackgroundColor,
         borderRadius: BorderRadius.circular(10)
       ),
       child: getText(btnName, 16, FontWeight.w400, Colors.black),
    );
  }
}



class FlipBookPainter extends CustomPainter{
  final offsets;
  FlipBookPainter(this.offsets);

  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint()
    ..color =Colors.deepPurple
    ..isAntiAlias= true
    ..strokeWidth = 3.0;


    //for (var offset in offsets){
      //print('offset${offset}');
      // canvas.drawPoints(
      //     PointMode.points,
      //     [offset],
      //     paint);
    if(offsets.length!=0){
      var p2;
      for (var i = 0;i<offsets.length;i++){
        print('offsets${offsets[i]}');
        if(i==offsets.length-1){
           p2 = offsets[i];
        }
        else {
         p2 = offsets[i+1];
        }
        canvas.drawLine(offsets[i], p2, paint);
      }

    }

  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate)=> true;



}