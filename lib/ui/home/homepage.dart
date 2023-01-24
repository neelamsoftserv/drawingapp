import 'dart:ui';

import 'package:drawingapp/widgets/gettext.dart';
import 'package:flutter/material.dart';
import '../paintpages/PaintClass.dart';
import 'dart:math' as math; // import this


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


 final _offsets = <Offset>[];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   title: getText("home", 14, FontWeight.w400, Colors.black),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width,height: height/2-34,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                          width: width/2-3,
                          height:height/2-1,
                          // color: Colors.red[50],

                        ),
                      ),
                    )

                ),
                const VerticalDivider(
                  thickness: 2, color: Colors.black,width: 3,
                ),
                ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: CustomPaint(
                      painter: FlipBookPainter(_offsets),
                      child: Container(
                        //color: Colors.blue,
                        width: width/2,
                        height:height/2,
                       // color: Colors.red[50],

                      ),
                    ),
                  ),
                ),
              ]),
          ),
          const Divider(thickness: 2, color: Colors.black,height: 1,),
          SizedBox(
            width: width,height: height/2-33,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: Transform(
                    alignment: Alignment.center,
                    //transform: Matrix4.rotationY(math.pi),
                    transform: Matrix4.rotationX(math.pi),
                    child: CustomPaint(
                      painter: FlipBookPainter(_offsets),
                      child: Container(
                        width: width/2-3,
                        height:height/2,
                       // color: Colors.red[50],

                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  thickness: 2, color: Colors.black,width: 3,
                ),
                ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(math.pi),
                    child: CustomPaint(
                      painter: FlipBookPainter(_offsets),
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        height:MediaQuery.of(context).size.height/2,
                        //color: Colors.red[50],

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 2, color: Colors.black,height: 1,),
          const SizedBox(height: 10,),
          _buildButtonUI(100.0,50.0, Colors.green,"Remove"),
          const SizedBox(height: 10,),
        ])

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
    return   Padding(
      padding: const EdgeInsets.only(left:10),
      child: InkWell(
        onTap: (){
          _offsets.clear();
        },
        child: Container(
           width: 100, height: 45,
           alignment: Alignment.center,
           decoration: BoxDecoration(
             color: btnBackgroundColor,
             borderRadius: BorderRadius.circular(10)
           ),
           child: getText(btnName, 16, FontWeight.w400, Colors.black),
        ),
      ),
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