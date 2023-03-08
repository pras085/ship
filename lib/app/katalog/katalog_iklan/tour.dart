import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/widgets/tutorial.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class Tour extends StatefulWidget {
  @override
  _TourState createState() => _TourState();
}

class _TourState extends State<Tour> {
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = List();

  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  GlobalKey keyButton5 = GlobalKey();


  OverlayEntry overlayEntry;

  @override
  void initState() {
    initTargets();
    // showTutorial();
    super.initState();
  }

  // Remove the OverlayEntry.
  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    removeHighlightOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tutorial().showTutor();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // createHighlightOverlay();
      return;
    });
    return TutorialAwal(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              // key: keyButton1,
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
            PopupMenuButton(
              key: keyButton1,
              icon: Icon(Icons.view_list, color: Colors.white),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Is this"),
                ),
                PopupMenuItem(
                  child: Text("What"),
                ),
                PopupMenuItem(
                  child: Text("You Want?"),
                ),
              ],
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    key: keyButton,
                    color: Colors.blue,
                    height: 100,
                    width: MediaQuery.of(context).size.width - 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        child: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          showTutorial();
                          // TutorialAwal();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: RaisedButton(
                    key: keyButton2,
                    onPressed: () {},
                  ),
                ),
              ),
              Positioned(
                // alignment: Alignment.bottomCenter,.
                bottom: -100,
                left: 100,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: RaisedButton(
                      key: keyButton3,
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: RaisedButton(
                      key: keyButton4,
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: RaisedButton(
                      key: keyButton5,
                      onPressed: () {},
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: keyButton1,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Titulo lorem ipsum",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: keyButton,
        color: Colors.purple,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );
    targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: keyButton4,
      contents: [
        TargetContent(
            align: ContentAlign.left,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Multiples content",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )),
        TargetContent(
            align: ContentAlign.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Multiples content",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: keyButton5,
      contents: [
        TargetContent(
            align: ContentAlign.right,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Title lorem ipsum",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TargetFocus(
      identify: "Target 4",
      keyTarget: keyButton3,
      contents: [
        TargetContent(
            align: ContentAlign.top,
            child: Container(
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      tutorialCoachMark.previous();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(
                        "https://juststickers.in/wp-content/uploads/2019/01/flutter.png",
                        height: 200,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Image Load network",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      identify: "Target 5",
      keyTarget: keyButton2,
      contents: [
        TargetContent(
            align: ContentAlign.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Multiples contents",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )),
        TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Multiples contents",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Container(
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
  }

  void showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.green,
      textSkip: "SKIP",
      paddingFocus: 50,
      opacityShadow: 0.8,
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onSkip: () {
        print("skip");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
    )..show();
  }

  void createHighlightOverlay() {
    // Remove the existing OverlayEntry.
    removeHighlightOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        // Align is used to position the highlight overlay
        // relative to the NavigationBar destination.
        return GestureDetector(
          onTap: (){
            removeHighlightOverlay();
          },
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
              )
            ],
          ),
        );
        },
    );

    // Add the OverlayEntry to the Overlay.
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry);
  }

}



class Tour2 extends StatefulWidget {
  const Tour2({ Key key }) : super(key: key);

  @override
  State<Tour2> createState() => _Tour2State();
}

class _Tour2State extends State<Tour2> {
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = List();

  GlobalKey keyScroll = GlobalKey();
  GlobalKey keyButton0 = GlobalKey();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  GlobalKey keyButton5 = GlobalKey();

  ScrollController scrollController = ScrollController();

  RenderBox renderBoxMerah;
  Size sizeMerah;
  Offset offsetMerahTerhadapLayar;
  RenderBox renderBoxBiru;
  Size sizeBiru;
  Offset offsetBiruTerhadapLayar;
  RenderBox renderBoxScroll;
  Size sizeScroll;
  Offset offsetMerahTerhadapScroll;
  Offset offsetBiruTerhadapScroll;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => (){

    });
    
    initTargets();

    return WillPopScope(
      onWillPop: (){
        tutorialCoachMark.finish();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: (){
            Get.back();
          },),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.red[200],
            height: 400,
            child: SingleChildScrollView(
              key: keyScroll,
              controller: scrollController,
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: double.infinity,),
                  
                  Padding(
                    padding: EdgeInsets.all(80),
                    child: Container(
                      key: keyButton0,
                      color: Colors.red,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      

                      renderBoxMerah = keyButton0.currentContext?.findRenderObject() as RenderBox;
                      sizeMerah = renderBoxMerah.size; // or _widgetKey.currentContext?.size
                      print('Size Merah: ${sizeMerah.width}, ${sizeMerah.height}');
                      offsetMerahTerhadapLayar = renderBoxMerah.localToGlobal(Offset.zero,);
                      print('Offset Merah Terhadap Layar: ${offsetMerahTerhadapLayar.dx}, ${offsetMerahTerhadapLayar.dy}');

                      renderBoxBiru = keyButton2.currentContext?.findRenderObject() as RenderBox;
                      sizeBiru = renderBoxBiru.size; // or _widgetKey.currentContext?.size
                      
                      print('Size Biru: ${sizeBiru.width}, ${sizeBiru.height}');
                      offsetBiruTerhadapLayar = renderBoxBiru.localToGlobal(Offset.zero,);
                      print('Offset Biru Terhadap Layar: ${offsetBiruTerhadapLayar.dx}, ${offsetBiruTerhadapLayar.dy}');

                      renderBoxScroll = keyScroll.currentContext?.findRenderObject() as RenderBox;
                      sizeScroll = renderBoxScroll.size; // or _widgetKey.currentContext?.size
                      print('Size Scroll: ${sizeScroll.width}, ${sizeScroll.height}');
                      offsetMerahTerhadapScroll = renderBoxScroll.globalToLocal(offsetMerahTerhadapLayar);
                      print('Offset Merah Terhadap Scroll: ${offsetMerahTerhadapScroll.dx}, ${offsetMerahTerhadapScroll.dy}');
                      offsetBiruTerhadapScroll = renderBoxScroll.globalToLocal(offsetBiruTerhadapLayar);
                      print('Offset Biru Terhadap Scroll Bawah: ${sizeBiru.height + offsetBiruTerhadapScroll.dy - sizeScroll.height }');
                      
                      print(scrollController.position.pixels);
                      
                      // print("max scroll ${}");
                      // print("media query height ${MediaQuery.of(context).size.height}");
                      // print("media query width ${MediaQuery.of(context).size.width}");

                      // scrollController.animateTo(scrollController.position.pixels + (sizeBiru.height + offsetBiruTerhadapScroll.dy - sizeScroll.height), duration: Duration(seconds: 1), curve: Curves.linear);
                    showTutorial();
                  }, child: Text("show")),
                  Padding(
                    padding: EdgeInsets.all(80),
                    child: Container(
                      key: keyButton1,
                      color: Colors.blue,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(80),
                    child: Container(
                      key: keyButton2,
                      color: Colors.green,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      final RenderBox renderBox = keyScroll.currentContext?.findRenderObject() as RenderBox;
                      final Size size = renderBox.size; // or _widgetKey.currentContext?.size
                      print('Size: ${size.width}, ${size.height}');
                      final Offset offset = renderBox.localToGlobal(Offset.zero);
                      print('Offset: ${offset.dx}, ${offset.dy}, ${offset.distance}');

                      final RenderBox renderBox1 = keyButton0.currentContext?.findRenderObject() as RenderBox;
                      final Size size1 = renderBox1.size; // or _widgetKey.currentContext?.size
                      print('Size1: ${size1.width}, ${size1.height}');
                      final Offset offset1 = renderBox1.localToGlobal(Offset.zero);
                      print('Offset1: ${offset1.dx}, ${offset1.dy}, ${offset1.distance}');
                      
                      
                      // print("max scroll ${}");
                      // print("media query height ${MediaQuery.of(context).size.height}");
                      // print("media query width ${MediaQuery.of(context).size.width}");

                      // scrollController.animateTo(80, duration: Duration(seconds: 1), curve: Curves.bounceIn);
                    // showTutorial();
                  }, child: Text("show")),
                  Container(
                    key: keyButton3,
                    margin: EdgeInsets.all(80),
                    color: Colors.pink,
                    width: 50,
                    height: 50,
                  ),
                  Container(
                    key: keyButton4,
                    margin: EdgeInsets.all(80),
                    color: Colors.yellow,
                    width: 50,
                    height: 50,
                  ),
                  Container(
                    key: keyButton5,
                    margin: EdgeInsets.all(80),
                    color: Colors.cyanAccent,
                    width: 50,
                    height: 50,
                  ),
              ],),
            ),
          ),
        ),
      ),
    );
  }

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: keyButton0,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Titulo lorem ipsum",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: keyButton1,
        color: Colors.purple,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: keyButton2,
        color: Colors.purple,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );
    
    // targets.add(TargetFocus(
    //   identify: "Target 2",
    //   keyTarget: keyButton2,
    //   contents: [
    //     TargetContent(
    //         align: ContentAlign.left,
    //         child: Container(
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Text(
    //                 "Multiples content",
    //                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 10.0),
    //                 child: Text(
    //                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               )
    //             ],
    //           ),
    //         )),
    //     TargetContent(
    //         align: ContentAlign.top,
    //         child: Container(
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Text(
    //                 "Multiples content",
    //                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 10.0),
    //                 child: Text(
    //                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ))
    //   ],
    //   shape: ShapeLightFocus.RRect,
    // ));
    // targets.add(TargetFocus(
    //   identify: "Target 3",
    //   keyTarget: keyButton3,
    //   contents: [
    //     TargetContent(
    //         align: ContentAlign.right,
    //         child: Container(
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Text(
    //                 "Title lorem ipsum",
    //                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 10.0),
    //                 child: Text(
    //                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ))
    //   ],
    //   shape: ShapeLightFocus.RRect,
    // ));
    // targets.add(TargetFocus(
    //   identify: "Target 4",
    //   keyTarget: keyButton4,
    //   contents: [
    //     TargetContent(
    //         align: ContentAlign.top,
    //         child: Container(
    //           child: Column(
    //             children: <Widget>[
    //               InkWell(
    //                 onTap: () {
    //                   tutorialCoachMark.previous();
    //                 },
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10.0),
    //                   child: Image.network(
    //                     "https://juststickers.in/wp-content/uploads/2019/01/flutter.png",
    //                     height: 200,
    //                   ),
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(bottom: 20.0),
    //                 child: Text(
    //                   "Image Load network",
    //                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
    //                 ),
    //               ),
    //               Text(
    //                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //             ],
    //           ),
    //         ))
    //   ],
    //   shape: ShapeLightFocus.Circle,
    // ));
    // targets.add(TargetFocus(
    //   identify: "Target 5",
    //   keyTarget: keyButton5,
    //   contents: [
    //     TargetContent(
    //         align: ContentAlign.top,
    //         child: Container(
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: <Widget>[
    //               Padding(
    //                 padding: const EdgeInsets.only(bottom: 20.0),
    //                 child: Text(
    //                   "Multiples contents",
    //                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
    //                 ),
    //               ),
    //               Text(
    //                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //             ],
    //           ),
    //         )),
    //     TargetContent(
    //         align: ContentAlign.bottom,
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.only(bottom: 20.0),
    //               child: Text(
    //                 "Multiples contents",
    //                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
    //               ),
    //             ),
    //             Container(
    //               child: Text(
    //                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //             ),
    //           ],
    //         ))
    //   ],
    //   shape: ShapeLightFocus.Circle,
    // ));
  
  }

  void showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.green,
      textSkip: "SKIP",
      paddingFocus: 50,
      opacityShadow: 0.8,
      focusAnimationDuration: Duration(seconds: 1),
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
        if(target.identify == "Target 1") {
           scrollController.animateTo(scrollController.position.pixels + (sizeBiru.height + offsetBiruTerhadapScroll.dy - sizeScroll.height), duration: Duration(milliseconds: 500), curve: Curves.linear);
        }
      },
      onSkip: () {
        print("skip");
      },
      onClickOverlay: (target) {
        
        print('onClickOverlay: $target');
      },
    )..show();
  }

}