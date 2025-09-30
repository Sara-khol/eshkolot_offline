import 'dart:math' as math;
import 'dart:ui';

import 'package:eshkolot_offline/models/quiz.dart';
import 'package:eshkolot_offline/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../custom_widgets/html_data_widget.dart';
import '../course_main/questionnaire_tab.dart';

class UpgradedEditorWidget extends StatefulWidget {
  const UpgradedEditorWidget(this.question,
      {super.key, required this.questionController});

  final Question question;
  final QuestionController questionController;


  @override
  State<UpgradedEditorWidget> createState() => _UpgradedEditorWidgetState();
}

class _UpgradedEditorWidgetState extends State<UpgradedEditorWidget> {
  late double increaseSize ;
  late MoreData customData;
  List<Widget> positionedItems = [];
  List<Widget> overlayInteractiveItems = [];

  // final List<Widget> positionedImages = [];
  // final List<Widget> positionedTexts  = [];

  late List<String> ans = [];
  List<TextEditingController> myControllers = [];
  List<int> pointsList = [];

  List<FocusNode> focusNodes = [];
  late double myWidth = 700;
  late double myHeight = 700;
   double kDefaultScale = 1;
  final ScrollController _hCtrl = ScrollController();



  // final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    customData = widget.question.moreData!;
    setPositionItems();
    widget.questionController.isCorrect = isCorrect;
    widget.questionController.isFilled = isFilled;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _getContainerConstraints();
    // });
    super.initState();
  }



  @override
  void didUpdateWidget(covariant UpgradedEditorWidget oldWidget) {
    ans.clear();
    myControllers.clear();
    focusNodes.clear();
    pointsList.clear();
    customData = widget.question.moreData!;
    setPositionItems();
    widget.questionController.isCorrect = isCorrect;
    widget.questionController.isFilled = isFilled;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _getContainerConstraints();
    // });
    super.didUpdateWidget(oldWidget);
  }


  double _bucketScale(double v) {
    // Decide scale bucket from a single dimension
    // v < 50  -> 10
    // 50-100  -> 8
    // 100-300 -> 2
    // >= 300  -> 1.5
    if (v < 50)  return 9 /*10*/;
    //when 10 makes 55181 question 11  quiz in גאומטריה מתקדמת א
    //to cut text
    if (v < 100) return 8;
    if (v < 300) return 2;
    if (v < 400) return 1.5;
    return kDefaultScale;
  }

  void setIncreaseSize(double baseW, double baseH) {
    // Use the stricter requirement of width/height
    final sW = _bucketScale(baseW);
    final sH = _bucketScale(baseH);
    increaseSize = math.max(sW, sH); // one final decision
  }


  setPositionItems() {
    positionedItems.clear();
    overlayInteractiveItems.clear();

    final baseW = double.parse(customData.customQuizQuestionsWidth);
    final baseH = double.parse(customData.customQuizQuestionsHeight);
    debugPrint('baseW $baseW baseH $baseH');
   setIncreaseSize(baseW, baseH);

    debugPrint('increaseSize $increaseSize');


    // שילוב שני העולמות: הגדלה + התאמה למסך
    final sx = increaseSize * ScreenUtil().scaleWidth;
    final sy = increaseSize * ScreenUtil().scaleHeight;
    final sf = increaseSize * math.min(ScreenUtil().scaleWidth, ScreenUtil().scaleHeight);

    myWidth  = baseW * sx;
    myHeight = baseH * sy;

    // myWidth =
    //     baseW * increaseSize.w;
    // myHeight =
    //     baseH * increaseSize.h;
    for (final field in customData.quizFields) {
      if (field.name.isEmpty || field.xPosition.isEmpty || field.yPosition.isEmpty) continue;

        // double xPosition = double.parse(field.xPosition) * sx;
        // double yPosition = double.parse(field.yPosition) * sy;
        // double itemWidth =
        //     field.width != '' ? double.parse(field.width) * sx : 0;
        // double itemHeight =
        //     field.height != '' ? double.parse(field.height) * sy : 0;

      final x = double.parse(field.xPosition) * sx;
      final y = double.parse(field.yPosition) * sy;
      final w = field.width.isNotEmpty  ? double.parse(field.width)  * sx : null;
      final h = field.height.isNotEmpty ? double.parse(field.height) * sy : null;
      final maxW = field.maxWidth.isNotEmpty ? double.parse(field.maxWidth) * sx : null;
      final font =field.fontSize.isNotEmpty? double.parse(field.fontSize) * sf:null;

        // --------- Editable? Put its TextField ONLY in the overlay ----------
        if (field.editable.isNotEmpty) {
          ans.add(field.correctAnswer);
          var textEditingController = TextEditingController();
          var focusNode = FocusNode();
          myControllers.add(textEditingController);
          focusNodes.add(focusNode);
          pointsList.add(field.points.isNotEmpty ? int.parse(field.points) : 0);
          final wrapW = maxW ?? math.max(0.0, myWidth - x - 12 * sx); // margin קטן מימין

          overlayInteractiveItems.add(
            Positioned(
              left: x,
              top: y,
              child: SizedBox(
                width: wrapW,
                height: h,
                child: TextField(
                  controller: textEditingController,
                  scrollPhysics: const NeverScrollableScrollPhysics(), // prevent inner horizontal scroll

                  focusNode: focusNode,
                  buildCounter: null,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: field.defaultValue,
                    // If your colors come as hex strings like "#5956da",
                    // convert them before using. (Your current code assumes int)
                  ),
                  cursorColor:
                  field.color != '' ? Color(int.parse(field.color)) : null,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  textDirection: field.direction == 'rtl'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  strutStyle: const StrutStyle(height: 1.22, forceStrutHeight: true),

                  style: TextStyle(
                    fontWeight: field.bold.isNotEmpty
                        ? FontWeight.bold
                        : FontWeight.normal,
                   // height: 1,
                    color: field.color != ''
                        ? Color(int.parse(field.color))
                        : null,
                    fontSize: font,
                  ),
                  onEditingComplete: () {
                    final index = focusNodes.indexOf(focusNode);
                    if (index < myControllers.length - 1) {
                      FocusScope.of(context)
                          .requestFocus(focusNodes[index + 1]);
                    } else {
                      FocusScope.of(context).requestFocus(focusNodes[0]);
                    }
                  },
                ),
              ),
            )
          );

          continue;
        }

        // --------- Non-editable: keep in the base layer as-is ----------
Widget myW=  Positioned(
  left: x,
  top: y,
  child: field.type == 'image'
      ? (field.defaultValue.isNotEmpty
      ? SizedBox(
    width: w,
    height: h,
    child: HtmlDataWidget(
      '<img src="${field.defaultValue.substring(field.defaultValue.lastIndexOf('/'))}" alt=""/>',
      quizId: widget.question.quizId,
    ),
  )
      : const SizedBox())
      : SizedBox(
    width:maxW,
    child: Text(
      field.defaultValue,
      style: TextStyle(
        fontWeight: field.bold.isNotEmpty
            ? FontWeight.bold
            : FontWeight.normal,
        fontSize:
        font,
        color: field.color != ''
            ? Color(int.parse(field.color))
            : null,
      ),
      textDirection: field.direction == 'rtl'
          ? TextDirection.rtl
          : TextDirection.ltr,
    ),
  ),
);

      positionedItems.add(myW);

    }
  }

/*  void setPositionItems1() {
    positionedItems.clear();
    overlayInteractiveItems.clear();

    // keep whatever logic sets increaseSize (1.5 / 3 / 10), or set it manually
    final double scale = increaseSize;

    // ⬅️ scale once here
    myWidth  = double.parse(customData.customQuizQuestionsWidth)  * scale;
    myHeight = double.parse(customData.customQuizQuestionsHeight) * scale;

    for (var field in customData.quizFields) {
      if (field.name.isEmpty || field.xPosition.isEmpty || field.yPosition.isEmpty) continue;

      final double x = double.parse(field.xPosition) * scale;
      final double y = double.parse(field.yPosition) * scale;
      final double w = field.width.isNotEmpty  ? double.parse(field.width)  * scale : 0;
      final double h = field.height.isNotEmpty ? double.parse(field.height) * scale : 0;
      final double? maxW = field.maxWidth.isNotEmpty ? double.parse(field.maxWidth) * scale : null;
      final double font =field.fontSize.isNotEmpty? double.parse(field.fontSize) * scale:0;

      if (field.editable.isNotEmpty) {
        // overlay (TextField)
        ans.add(field.correctAnswer);
        final controller = TextEditingController();
        final focusNode  = FocusNode();
        myControllers.add(controller);
        focusNodes.add(focusNode);
        pointsList.add(field.points.isNotEmpty ? int.parse(field.points) : 0);

        overlayInteractiveItems.add(
          Positioned(
            left: x,
            top:  y,
            child: SizedBox(
              width: maxW,
              height: h > 0 ? h : null,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                buildCounter: null,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 0)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                ),
                cursorColor: field.color.isNotEmpty ? Color(int.parse(field.color)) : null,
                textAlign: TextAlign.center,
                maxLines: 1,
                textDirection: field.direction == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
                style: TextStyle(
                  fontWeight: field.bold.isNotEmpty ? FontWeight.bold : FontWeight.normal,
                  height: 1,
                  color: field.color.isNotEmpty ? Color(int.parse(field.color)) : null,
                  fontSize: font, // ⬅️ scaled once
                ),
                onEditingComplete: () {
                  final i = focusNodes.indexOf(focusNode);
                  FocusScope.of(context).requestFocus(focusNodes[(i + 1) % myControllers.length]);
                },
              ),
            ),
          ),
        );
        continue;
      }

      // base layer (non-editable)
      positionedItems.add(
        Positioned(
          left: x,
          top:  y,
          child: field.type == 'image'
              ? (field.defaultValue.isNotEmpty
              ? SizedBox(
            width: w,
            height: h,
            child: HtmlDataWidget(
              '<img src="${field.defaultValue.substring(field.defaultValue.lastIndexOf('/'))}" alt=""/>',
              quizId: widget.question.quizId,
            ),
          )
              : const SizedBox())
              : SizedBox(
            width: maxW,
            child: Text(
              field.defaultValue,
              style: TextStyle(
                fontWeight: field.bold.isNotEmpty ? FontWeight.bold : FontWeight.normal,
                fontSize: font, // ⬅️ scaled once
                color: field.color.isNotEmpty ? Color(int.parse(field.color)) : null,
              ),
              textDirection: field.direction == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
            ),
          ),
        ),
      );
    }
  }*/


  //List<String> ans=[];
  @override
  Widget build(BuildContext context) {
    return Padding(
        //padding: const EdgeInsets.all(100),
        padding: EdgeInsets.only(top: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          HtmlDataWidget(widget.question.question,
              quizId: widget.question.quizId),
          SizedBox(
            height: 35.h,
          ),
          /*Center(
            child: Container(
                width: myWidth,
                height: myHeight,
                child: LayoutBuilder(builder: (context, constraints) {
                  if (myWidth > constraints.maxWidth) debugPrint('fffff');
                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Base layer: images + static text in the original server order
                        AbsorbPointer(
                          absorbing: true,
                          // prevents the hidden/underlayer from stealing focus
                          child: Center(child: Stack(alignment: Alignment.center,
                              children: positionedItems)),
                        ),

                        // Overlay: only the TextFields, drawn last (visible & tappable)
                        ...overlayInteractiveItems,
                      ],
                    ),
                  );
                })),
          )*/
              Center(
                child: buildCanvas() /*SingleChildScrollView( // horizontal
                  scrollDirection: Axis.horizontal,
                  // primary: false, // important
                  // physics: const ClampingScrollPhysics(),

                  child: SizedBox(
                    width: myWidth,   // already = baseW * increaseSize
                    height: myHeight, // already = baseH * increaseSize
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        AbsorbPointer(
                          absorbing: true,
                          child: Stack(  clipBehavior: Clip.none,   // ← הוסף/י
                              alignment: Alignment.center, children: positionedItems),
                        ),
                        ...overlayInteractiveItems,
                      ],
                    ),
                  ),
                )*/,
              )
        ]));
  }

  Widget buildCanvas() {

    return SizedBox(
      height: myHeight, // the canvas height
      child: Scrollbar(
        controller: _hCtrl,
        thumbVisibility: true,          // always show thumb when scrollable
        trackVisibility: true,          // show track (desktop/web)
        interactive: true,              // allow dragging the thumb
        scrollbarOrientation: ScrollbarOrientation.bottom, // put it at the bottom
        child: ListView(
          controller: _hCtrl,
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          children: [
            // GestureDetector to drag the whole canvas when grabbing the image
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragUpdate: (d) {
                if (!_hCtrl.hasClients) return;
                final max = _hCtrl.position.maxScrollExtent;
                final next = (_hCtrl.offset - d.delta.dx).clamp(0.0, max);
                _hCtrl.jumpTo(next);
              },
              child: SizedBox(
                width: myWidth,  // <- dynamic canvas width
                height: myHeight,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // base layer (images/text)
                    Stack(clipBehavior: Clip.none, children: positionedItems),

                    // overlay inputs
                    // (Tip: TextField should not scroll itself)
                    ...overlayInteractiveItems,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQAnswers() {
    bool isOk = isCorrect() == widget.question.points;
    return Padding(
        //padding: const EdgeInsets.all(100),
        padding: EdgeInsets.only(top: 25.h),
        child: Column(children: [
          HtmlDataWidget(widget.question.question,
              quizId: widget.question.quizId),
          SizedBox(
            height: 35.h,
          ),
          SizedBox(
              width: myWidth,
              height: myHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: setPositionItemsAnswer(),
              )),
          Container(
            height: 80.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: isOk
                    ? Colors.greenAccent.withOpacity(0.5)
                    : Colors.redAccent.withOpacity(0.5)),
            child: Center(
                child: Text(
              isOk ? 'תשובה נכונה!' : 'אחת או יותר מהתשובות לא נכונות',
              style: TextStyle(fontSize: 20.sp),
            )),
          )
        ]));
  }

  List<Widget> setPositionItemsAnswer() {
    List<Widget> positionedItemsAnswers = [];

    final baseW = double.parse(customData.customQuizQuestionsWidth);
    final baseH = double.parse(customData.customQuizQuestionsHeight);

    final base = <Widget>[]; // images + non-editable text
    final overlay = <Widget>[]; // the colored answers (on top)

    Widget myTextField = Container();

    if (baseW < 300 &&
        baseW > 100) {
      debugPrint('333');

      increaseSize = 2;
    } else if (baseW <= 100) {
      increaseSize = 8;
    }

    if (baseH < 300 &&
        baseH > 100) {
      debugPrint('4444');

      increaseSize = 2;
    } else if (baseH <= 100) {
      increaseSize = 8;
    }

    myWidth =
        baseW * increaseSize.w;

    myHeight =
        baseH * increaseSize.h;
    int i = 0;
    for (var field in customData.quizFields) {
      if (field.name.isEmpty ||
          field.xPosition.isEmpty ||
          field.yPosition.isEmpty) continue;

      double xPosition = double.parse(field.xPosition) * increaseSize;
      double yPosition = double.parse(field.yPosition) * increaseSize;
      double itemWidth =
          field.width != '' ? double.parse(field.width) * increaseSize : 0;
      double itemHeight =
          field.height != '' ? double.parse(field.height) * increaseSize : 0;

      if (field.editable.isNotEmpty) {
        bool isCorrect = myControllers[i].text == ans[i];

        myTextField = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: field.maxWidth != ''
                    ? double.parse(field.maxWidth) * increaseSize.w
                    : null,
                // height: 35.h,
                decoration: BoxDecoration(
                    color: isCorrect
                        ? Colors.greenAccent
                        : Colors.redAccent.withOpacity(0.5),
                    border: Border.all(
                        color: isCorrect ? Colors.green : Colors.red)),
                child: Text(
                  textAlign: TextAlign.center,
                  myControllers[i].text,
                  style: TextStyle(
                      fontWeight: field.bold.isNotEmpty
                          ? FontWeight.bold
                          : FontWeight.normal,
                      height: 1.2,
                      color: field.color != ''
                          ? Color(int.parse(field.color))
                          : null,
                      fontSize: double.parse(field.fontSize) * increaseSize.sp),
                  strutStyle: const StrutStyle(      // ← מבטיח גובה מינימום לשורת הטקסט
                    height: 1.2,
                    forceStrutHeight: true,
                  ),
                )),
            if (!isCorrect) /* SizedBox(
                  width: field.maxWidth != ''
                      ? double.parse(field.maxWidth) * increaseSize.w
                      : null,
                  child:*/
              Text(
                '(${ans[i]})',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: field.bold.isNotEmpty
                        ? FontWeight.bold
                        : FontWeight.normal,
                    height: 1,
                    color: blackColorApp,
                    fontSize: double.parse(field.fontSize) * increaseSize.sp),
                strutStyle: const StrutStyle(      // ← מבטיח גובה מינימום לשורת הטקסט
                  height: 1.2,
                  forceStrutHeight: true,
                ),
              )
            //)
          ],
        );

        overlay.add(
          Positioned(
            left: xPosition.w,
            top: yPosition.h,
            child: myTextField,
          ),
        );

       i++;
        continue; // do NOT also add this to the base layer
      }

      // Non-editable: images / static text -> BASE layer (drawn first, may be opaque)
      base.add(
        Positioned(
          left: xPosition.w,
          top: yPosition.h,
          child: field.type == 'image'
              ? (field.defaultValue.isNotEmpty
                  ? SizedBox(
                      width: itemWidth.w > 0 ? itemWidth.w : null,
                      height: itemHeight.h > 0 ? itemHeight.h : null,
                      child: Image.network(
                          field.defaultValue), // or HtmlDataWidget if you need
                    )
                  : const SizedBox())
              : SizedBox(
                  width: field.maxWidth != ''
                      ? double.parse(field.maxWidth) * increaseSize.w
                      : null,
                  child: Text(
                    field.defaultValue,
                    style: TextStyle(
                      fontWeight: field.bold.isNotEmpty
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: double.parse(field.fontSize) * increaseSize.sp,
                      color: field.color != ''
                          ? Color(int.parse(field.color))
                          : null,
                    ),
                    textDirection: field.direction == 'rtl'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                  ),
                ),
        ),
      );

      /*  positionedItemsAnswers.add(Positioned(
            left: xPosition.w,
            top: yPosition.h,
            child: field.type == 'image'
                //image
                ? field.defaultValue.isNotEmpty
                    ? SizedBox(
                        width: itemWidth.w,
                        height: itemHeight.h,
                        child: Image.network(
                          field.defaultValue,
                        ))
                    : const SizedBox()
                : field.editable.isEmpty
                    ?
                    //text
                    SizedBox(
                        width: field.maxWidth != ''
                            ? double.parse(field.maxWidth) * increaseSize.w
                            : null,
                        //goes on top of image and see some white
                        // color:  field.background != ''
                        //     ? Color(int.parse(field.background))
                        //     : null,
                        child: Text(field.defaultValue,
                            style: TextStyle(
                                fontWeight: field.bold.isNotEmpty
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: double.parse(field.fontSize) *
                                    increaseSize.sp,
                                color: field.color != ''
                                    ? Color(int.parse(field.color))
                                    : null),
                            textDirection: field.direction == 'rtl'
                                ? TextDirection.rtl
                                : TextDirection.ltr),
                      )
                    : myTextField));*/
    }

    // Return as a single list for your existing Stack(children: ...)
    return [
      // Base visuals under an AbsorbPointer so they don’t take taps
      AbsorbPointer(
        absorbing: true,
        child: Stack(children: base),
      ),
      // Overlay answers (drawn last = visible above opaque images)
      ...overlay,
    ];
  }

  bool isFilled() {
    for (var controller in myControllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    // setPositionItemsAnswer();
    widget.questionController.displayWithAnswers = buildQAnswers();
    return true;
  }

  int isCorrect() {
    debugPrint('list points $pointsList');
    calculateTotalPoints();
    if (widget.question.points < 2) {
      int i = 0;
      for (String s in ans) {
        if (s.isNotEmpty) {
          if (s != myControllers[i].text) return 0;
        }
        i++;
      }
      return 1;
    } else {
      int numPoints = 0;
      int i = 0;
      for (String s in ans) {
        if (s.isNotEmpty) {
          if (s == myControllers[i].text) {
            numPoints += pointsList[i];
            i++;
          }
        }
      }
      return numPoints;
    }
  }

  calculateTotalPoints() {
    int totalPoints = 0;
    for (int i in pointsList) {
      totalPoints += i;
    }
    debugPrint(
        'totalPoints original: ${widget.question.points} calculate: $totalPoints');
    widget.question.points = totalPoints;
  }

  @override
  void dispose() {
    super.dispose();
    // Clean up the controller when the widget is disposed.
    for (var controller in myControllers) {
      controller.dispose();
    }
  }
}
