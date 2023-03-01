import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:drawingapp/widgets/gettext.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../paintpages/PaintClass.dart';
import 'dart:math' as math; // import this
import 'dart:ui' as ui;

const directoryName = 'drawings';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<_HomePageState> globalKey = GlobalKey();



 final _offsets = <Offset>[];
 var image ;



  rendered()  async{
  debugPrint('called');
   ui.PictureRecorder recorder = ui.PictureRecorder();
   Canvas canvas = Canvas(recorder);
   DrawMirrorImage painter = DrawMirrorImage(_offsets);
   var size = context.size;
   painter.paint(canvas, size!);
   // recorder.isRecording?
   // print('image file${recorder.endRecording().toImage(size.width.floor(), size.height.floor())}'):
   // print('not recording${recorder.endRecording().toImage(size.width.floor(), size.height.floor())}');
   image = await recorder.endRecording().toImage(size.width.floor(), size.height.floor());
   showImage();


 }
  showImage() async{
     var pngImage = await image?.toByteData(format:ImageByteFormat.png);

     // Directory? directory = await getExternalStorageDirectory();
     Directory? directory = await getApplicationDocumentsDirectory();
     String path = directory.path;
     debugPrint('directory path$path');
     await Directory('$path/$directoryName').create(recursive: true);
     File('$path/$directoryName.png').writeAsBytesSync(pngImage!.buffer.asInt8List());

     showImageOne(pngImage);



 }
 showImageOne(pngImage){
   showDialog<Null>(
       context: context,
       builder: (context) {
         return AlertDialog(
           title: Text(
             'Please check your device\'s Signature folder',
             style: TextStyle(
                 fontFamily: 'Roboto',
                 fontWeight: FontWeight.w300,
                 color: Theme.of(context).primaryColor,
                 letterSpacing: 1.1
             ),
           ),
           content: Image.memory(Uint8List.view(pngImage.buffer)),
         );
       }
   );

 }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   title: getText("home", 14, FontWeight.w400, Colors.black),
        //   centerTitle: true,
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width,height: height/2-48,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onPanDown: (details){
                        final renderBox =  context.findRenderObject() as RenderBox;
                        final localPosition = renderBox.globalToLocal(details.globalPosition);

                        _offsets.add(localPosition);
                        debugPrint('localPosition$localPosition');
                        //debugPrint('localPosition .. one--  ${ details.localPosition}');
                        setState(() {});
                      },
                      onPanStart: (details){
                        final renderBox =  context.findRenderObject() as RenderBox;
                        final localPosition = renderBox.globalToLocal(details.globalPosition);
                        _offsets.add(localPosition);
                        setState(() {});
                      },
                      onPanUpdate: (details) async{
                        final renderBox =  context.findRenderObject() as RenderBox;
                        final localPosition = renderBox.globalToLocal(details.globalPosition);
                        _offsets.add(localPosition);
                        debugPrint('localPosition on update$localPosition');
                        // ui.Image imageOnw = await rendered;
                        setState(() {
                          // image = imageOnw;
                        });
                      },
                    onPanEnd:null,
                      // onPanEnd: (details){
                      //   // savedOffsets =_offsets;
                      //   // print('savedOffsets${savedOffsets.length}');
                      //   // _offsets.clear();
                      //   // setState(() {});
                      // },
                      child: ClipRect (
                        clipBehavior: Clip.hardEdge,
                        child: CustomPaint(
                          painter: DrawMirrorImage(_offsets),
                          //foregroundPainter:FlipBookPainter(_offsets) ,
                          child:  Container(
                            width: width/2-1,
                            height:height/2-1,
                            // color: Colors.red[50],

                          ),
                        ),
                      )

                  ),
                  const VerticalDivider(
                    thickness: 1, color: Colors.black,width:0.1,
                  ),
                  ClipRect(
                    clipBehavior: Clip.hardEdge,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: CustomPaint(
                        painter: DrawMirrorImage(_offsets),
                        child: Container(
                          //color: Colors.blue,
                          width: width/2,
                          height:height/2-40,
                         // color: Colors.red[50],

                        ),
                      ),
                    ),
                  ),
                ]),
            ),
            const Divider(thickness: 1, color: Colors.black,height: 0.5,),
            SizedBox(
              width: width,height: height/2-48,
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
                        painter: DrawMirrorImage(_offsets),
                        child: Container(
                          width: width/2-1,
                          height:height/2-40,
                         // color: Colors.red[50],

                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 1, color: Colors.black,width: 0.1,
                  ),
                  ClipRect(
                    clipBehavior: Clip.hardEdge,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(math.pi),
                      child: CustomPaint(
                        painter: DrawMirrorImage(_offsets),
                        child: Container(
                          width: MediaQuery.of(context).size.width/2,
                          height:height/2-40,
                          //color: Colors.red[50],

                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1, color: Colors.black,height: 0.5,),
            const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButtonUI(100.0,50.0, Colors.green,"Remove",(){
                  _offsets.clear();
                  setState(() {

                  });
                }),
                const SizedBox(width: 10,),
                _buildButtonUI(100.0,50.0, Colors.green,"Save",() {

                   // ui.Image recordedImage =  await rendered();
                    rendered();
                  // rendered;
                  setState(() {
                    // image = recordedImage;

                  });
                }),
              ],
            ),

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
      ),
    );
  }
  Widget _buildButtonUI( double btnWidth, double btnHeight, Color btnBackgroundColor,btnName, Function() onTap){
    return   Padding(
      padding: const EdgeInsets.only(left:10),
      child: InkWell(
        onTap:  onTap,
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

