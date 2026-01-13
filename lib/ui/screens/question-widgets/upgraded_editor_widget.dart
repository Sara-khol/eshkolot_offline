import 'dart:math' as math;
import 'dart:ui';

import 'package:eshkolot_offline/models/quiz.dart';
import 'package:eshkolot_offline/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../custom_widgets/html_data_widget.dart';
import '../course_main/questionnaire_tab.dart';
import 'package:html_unescape/html_unescape.dart';

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
  final List<Widget> backgroundItems = [];
  final List<Widget> foregroundItems = [];
  List<Widget> overlayInteractiveItems = [];

  // final List<Widget> positionedImages = [];
  // final List<Widget> positionedTexts  = [];

  late List<String> ans = [];
  List<TextEditingController> myControllers = [];
  List<int> pointsList = [];

  List<FocusNode> focusNodes = [];
  late double myWidth = 700;
  late double myHeight = 700;
  late double _scale;
  double kDefaultScale = 1;
  var unescape = HtmlUnescape();


  MoreData get customData => widget.question.moreData!;


  @override
  void initState() {
    _initControllers();
    widget.questionController.isCorrect = isCorrect;
    widget.questionController.isFilled = isFilled;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant UpgradedEditorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question.idQues != widget.question.idQues) {
      debugPrint('didUpdateWidget');
      _initControllers();

    }
    widget.questionController.isCorrect = isCorrect;
    widget.questionController.isFilled = isFilled;

  }

  void _initControllers() {
    ans.clear();
    myControllers.clear();
    focusNodes.clear();
    pointsList.clear();

    for (final field in customData.quizFields) {
      if (field.name.isEmpty || field.xPosition.isEmpty || field.yPosition.isEmpty) continue;
      if (field.editable.isNotEmpty ) {
        myControllers.add(TextEditingController());
        focusNodes.add(FocusNode());
        ans.add(field.correctAnswer);
        pointsList.add(field.points.isNotEmpty ? int.parse(field.points) : 0);


      }
    }
  }

  setPositionItems(double scale) {

    backgroundItems.clear();
    foregroundItems.clear();
    overlayInteractiveItems.clear();


    final baseW = double.parse(customData.customQuizQuestionsWidth);
    final baseH = double.parse(customData.customQuizQuestionsHeight);
    debugPrint('baseW $baseW baseH $baseH');

    setIncreaseSize(baseW, baseH);

    myWidth  = baseW * scale;
    myHeight = baseH * scale;
    debugPrint('myWidth $myWidth myHeight $myHeight');


    int inputIndex=-1;
    // myWidth =
    //     baseW * increaseSize.w;
    // myHeight =
    //     baseH * increaseSize.h;
    for (final field in customData.quizFields) {
      if (field.name.isEmpty || field.xPosition.isEmpty || field.yPosition.isEmpty) continue;
      final x =double.parse(field.xPosition) * scale;

      // final x =double.parse(field.xPosition)>0? double.parse(field.xPosition) * scale:0.0;
      // if(x==0)
      //   {
      //     debugPrint('xPosition ${field.xPosition}');
      //   }
      final y = double.parse(field.yPosition) * scale;
      final w = field.width.isNotEmpty  ? double.parse(field.width)  * scale : null;
      final h = field.height.isNotEmpty ? double.parse(field.height) * scale : null;
      final maxW = field.maxWidth.isNotEmpty ? double.parse(field.maxWidth) * scale : null;
      final font =field.fontSize.isNotEmpty? double.parse(field.fontSize) * scale:null;


      // --------- Editable? Put its TextField ONLY in the overlay ----------
      if (field.editable.isNotEmpty) {
        double  calHeight=0;
        if(h==null)
        {
    calHeight = calcFieldHeight(
            fontSize: font??14.0,
            originalFont: double.parse(field.fontSize));
    debugPrint('calHeight $calHeight');
        }
        inputIndex++;
        final int currentIndex = inputIndex;
        // debugPrint('inputIndex $inputIndex ${field.width.isNotEmpty  ? double.parse(field.width):''}');
        //ans.add(field.correctAnswer);
        // var textEditingController = TextEditingController();
        //var textEditingController = myControllers[inputIndex];;
        // var focusNode = FocusNode();
        //myControllers.add(textEditingController);
        // focusNodes.add(focusNode);
        //pointsList.add(field.points.isNotEmpty ? int.parse(field.points) : 0);
        final wrapW = maxW ?? math.max(0.0, myWidth - x - 12 * scale); // margin קטן מימין
//debugPrint('increaseSize*3*sy ${increaseSize*3*sy} 65.h ${65.h}');
        overlayInteractiveItems.add(
            Positioned(
              key: ValueKey('q_${widget.question.idQues}_input_$currentIndex'),
              left: x,
              top: y,
              child: SizedBox(
                width: wrapW,
               height: h ?? calHeight,
                // height: h??(increaseSize*3*sy>80.h?increaseSize*3*sy:80.h),
                child: TextField(
                  onTap: (){
                    debugPrint('details:');
                    debugPrint('name: ${field.name}');
                    debugPrint('font: ${field.fontSize} $font');
                    debugPrint('x ${field.xPosition} y ${field.yPosition} maxWidth: ${field.maxWidth} $maxW');
                  },
                  controller: myControllers[inputIndex],
                  scrollPhysics: const NeverScrollableScrollPhysics(), // prevent inner horizontal scroll
                  focusNode: focusNodes[inputIndex],
                  buildCounter: null,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(

                   isDense: false,
                  //  isCollapsed: true,
                    filled: true,
                    //   contentPadding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    //   contentPadding: EdgeInsets.symmetric(vertical: 8 * scale),
                    contentPadding: EdgeInsets.zero,

                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: field.defaultValue,
                  ),
                  cursorColor:
                  field.color != '' ? Color(int.parse(field.color)) : null,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  textDirection: field.direction == 'rtl'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                 // strutStyle: const StrutStyle(height: 1.22, forceStrutHeight: true),

                  style: TextStyle(
                    fontWeight: field.bold.isNotEmpty
                        ? FontWeight.bold
                        : FontWeight.normal,
                    height: 1,
                    color: field.color != ''
                        ? Color(int.parse(field.color))
                        : null,
                    fontSize: font,
                    leadingDistribution: TextLeadingDistribution.even,

                  ),
                  onEditingComplete: () {
                    if (currentIndex < myControllers.length - 1) {
                      FocusScope.of(context)
                          .requestFocus(focusNodes[currentIndex + 1]);
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

      if(field.type=='image')
        {
          backgroundItems.add(Positioned(
            left: x,
              top: y,
              child: (field.defaultValue.isNotEmpty
              ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  debugPrint('details: image');
                  debugPrint('name: ${field.name}');
                  debugPrint('font: ${field.fontSize} $font');
                  debugPrint('x ${field.xPosition} y ${field.yPosition} w: ${field.width} $w');
                },
                child: SizedBox(
                            width: w,
                            height: h,
                            child: IgnorePointer(
                              child: HtmlDataWidget(
                                              '<img src="${field.defaultValue.substring(field.defaultValue.lastIndexOf('/'))}" alt=""/>',
                                              quizId: widget.question.quizId,
                              ),
                            ),
                          ),
              )
              : const SizedBox())));
        }
else
  {
    foregroundItems.add(Positioned(  left: x,
        top: y,
        child: SizedBox(
          width:maxW,
          child: GestureDetector(
            onTap: (){
              debugPrint('details:');
              debugPrint('name: ${field.name}');
              debugPrint('font: ${field.fontSize} $font');
              debugPrint('x ${field.xPosition} y ${field.yPosition} maxWidth: ${field.maxWidth} $maxW');
            },
            child: Text(
              unescape.convert(field.defaultValue),
              style: TextStyle(
                fontWeight: field.bold.isNotEmpty
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontSize: font,
                color: field.color != ''
                    ? Color(int.parse(field.color))
                    : null,
              ),
              textDirection: field.direction == 'rtl'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
            ),
          ),
        )));
  }
      // --------- Non-editable: keep in the base layer as-is ----------

   //   positionedItems.add(myW);
    }
  //  debugPrint('inputIndex ${inputIndex+1} positionedItems.length ${positionedItems.length}');
  }

  double calcFieldHeight({
    required double fontSize,
    double? originalFont,
  }) {
    // גובה בסיסי
    double h = fontSize * 1.45;

// if(originalFont!=null)
//   {
//     if(4>=originalFont)
//       {
//         debugPrint('oo $originalFont');
//      //   h*=1.12;
//       }
//   }
    return h;
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: EdgeInsets.only(top: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HtmlDataWidget(widget.question.question,
                  quizId: widget.question.quizId),
              SizedBox(
                height: 35.h,
              ),
              Center(
                child: buildCanvas(),
              )
            ]));
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

  void setIncreaseSize(double baseW, double baseH, {double maxDiff = 4.0}) {
    // Use the stricter requirement of width/height
    final sW = _bucketScale(baseW);
    final sH = _bucketScale(baseH);
    debugPrint('sw $sW sH $sH diff ${(sW - sH).abs()}');

    if ((sW - sH).abs() > maxDiff) {
      final big = sW > sH ? sW : sH;
      final small = sW > sH ? sH : sW;
      // if (wx > hy) {
      //   wx = hy + maxDiff;
      // } else {
      //   hy = wx + maxDiff;
      // }
      increaseSize= small+maxDiff;

    }
else {
      increaseSize = math.max(sW, sH); // one final decision
    }
    final int inputsCount =
        customData.quizFields.where((f) => f.editable.isNotEmpty).length;
    if(inputsCount>1) {
      increaseSize=increaseSize*2;
    }
    debugPrint('increaseSize $increaseSize inputsCount $inputsCount');
  }

  Widget buildCanvas() {
    final baseW = double.parse(customData.customQuizQuestionsWidth);
    final baseH = double.parse(customData.customQuizQuestionsHeight);

    return LayoutBuilder(
      builder: (context, constraints) {
      {
        // debugPrint('constraints: ${constraints.maxWidth}');
        // debugPrint('screen: ${ScreenUtil().screenWidth}');



        final scaleX = constraints.maxWidth / baseW;
        final scaleY = constraints.maxHeight / baseH;
        final scale = constraints.maxWidth / baseW;
       _scale=scale;
      setPositionItems(scale);

        final canvasW = baseW * scale;
        final canvasH = baseH * scale;


        debugPrint('scaleX $scaleX scaleY $scaleY');
        debugPrint('scale $scale');


        return  SizedBox(
                       height: canvasH,
                      child: SizedBox(
                        width: canvasW/*myWidth*/,  // <- dynamic canvas width
                        height: canvasH/*myHeight*/,
                        child:Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // ---------- BACKGROUND (תמיד מאחור) ----------
                            ...backgroundItems,

                            // ---------- CONTENT / ANSWERS ----------

                              ...foregroundItems,


                            // ---------- INPUTS (תמיד מעל הכול) ----------

                              ...overlayInteractiveItems,
                          ],
                        )

                        /*Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // base layer (images/text)
                            Stack(clipBehavior: Clip.none,
                                children:!isAnswer ?positionedItems:setPositionItemsAnswer(scale)),

                            // overlay inputs
                            // (Tip: TextField should not scroll itself)
                           if(!isAnswer) ...overlayInteractiveItems,
                          ],
                        ),*/
                                      //    ),
                                      //  ),

                              ),
                  //  )
        );
      }}
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
     buildCanvas(),
     /*     SizedBox(
              width: myWidth,
              height: myHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: setPositionItemsAnswer(),
              )),*/
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

  List<Widget> setPositionItemsAnswer(double scale) {

    final baseW = double.parse(customData.customQuizQuestionsWidth);
    final baseH = double.parse(customData.customQuizQuestionsHeight);
    debugPrint('baseW $baseW baseH $baseH');

    setIncreaseSize(baseW, baseH);

    myWidth  = baseW * scale;
    myHeight = baseH * scale;
    debugPrint('myWidth $myWidth myHeight $myHeight');

    final base = <Widget>[]; // images + non-editable text
    final overlay = <Widget>[]; // the colored answers (on top)

    Widget myTextField = Container();

   // setIncreaseSize(baseW, baseH);

    int i = 0;
    for (var field in customData.quizFields) {
      if (field.name.isEmpty ||
          field.xPosition.isEmpty ||
          field.yPosition.isEmpty) {
        continue;
      }


      final maxW = field.maxWidth.isNotEmpty ? double.parse(field.maxWidth) * scale : null;

      double xPosition = double.parse(field.xPosition) * scale;
      double yPosition = double.parse(field.yPosition) * scale;
      double? itemWidth =
          field.width.isNotEmpty?double.parse(field.width) * scale : null;
      double? itemHeight =
          field.height.isNotEmpty? double.parse(field.height) * scale : null;
      final wrapW = maxW ?? math.max(0.0, myWidth - xPosition - 12 * scale); // margin קטן מימין
      final font =field.fontSize.isNotEmpty? double.parse(field.fontSize) * scale:null;



      if (field.editable.isNotEmpty) {
        double  calHeightA=0;
        if(itemHeight==null) {
          calHeightA = calcFieldHeight(
              fontSize: font ?? 14.0,
              originalFont: double.parse(field.fontSize));
        }
        bool isCorrect = myControllers[i].text == ans[i];

        myTextField = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // opaque base so nothing shows through
                border: Border.all(color: isCorrect ? Colors.green : Colors.red),
              ),
              child: Container(
                  width:wrapW/* field.maxWidth != ''
                      ? double.parse(field.maxWidth) * increaseSize.w
                      : null*/,
                  // height: 25.h*sy,
                  height: itemHeight ??  calHeightA,
                  decoration: BoxDecoration(
                      color: isCorrect
                          ? Colors.greenAccent
                          : Colors.redAccent.withOpacity(0.5),
                      // border: Border.all(
                      //     color: isCorrect ? Colors.green : Colors.red)
                  ),
                  child: Center(
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
                          fontSize: font),
                      strutStyle: const StrutStyle(      // ← מבטיח גובה מינימום לשורת הטקסט
                        height: 1.2,
                        forceStrutHeight: true,
                      ),
                    ),
                  )),
            ),
            if (!isCorrect) /* SizedBox(
                  width: field.maxWidth != ''
                      ? double.parse(field.maxWidth) * increaseSize.w
                      : null,
                  child:*/
              Text(
                '(${ans[i]})',
                textAlign: TextAlign.center,
                textDirection:field.direction == 'rtl'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: TextStyle(
                    fontWeight: field.bold.isNotEmpty
                        ? FontWeight.bold
                        : FontWeight.normal,
                    height: 1,
                    color: blackColorApp,
                    fontSize: font),
                strutStyle: const StrutStyle(      // ← מבטיח גובה מינימום לשורת הטקסט
                  height: 1.2,
                  forceStrutHeight: true,
                ),
              )
            //)
          ],
        );

        // myTextField = SizedBox( // ← אותו רוחב לשתי השורות
        //   width: boxW,
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       // תיבת תשובת המשתמש
        //       Container(
        //         width: boxW,
        //         height: boxH,
        //         alignment: Alignment.center,
        //         decoration: BoxDecoration(
        //           color: isCorrect ? _opaqueTint(Colors.greenAccent, .35)
        //               : _opaqueTint(Colors.redAccent,   .35),
        //           border: Border.all(color: isCorrect ? Colors.green : Colors.red),
        //           borderRadius: BorderRadius.circular(4),
        //         ),
        //         child: Text(
        //           myControllers[i].text,
        //           textAlign: TextAlign.center,
        //           textScaleFactor: 1.0,
        //           style: TextStyle(
        //             fontSize: font,
        //             height: 1.0, // ללא מרווחים מיותרים
        //             fontWeight: field.bold.isNotEmpty ? FontWeight.bold : FontWeight.normal,
        //             color: Colors.black,
        //           ),
        //           strutStyle: const StrutStyle(height: 1.0, forceStrutHeight: true),
        //           textHeightBehavior: const TextHeightBehavior(
        //             applyHeightToFirstAscent: false,
        //             applyHeightToLastDescent: false,
        //           ),
        //         ),
        //       ),
        //
        //       // מרווח מינימלי מאוד בין הקופסה לשורה בסוגריים
        //       const SizedBox(height: 2),
        //
        //       // שורת התשובה בסוגריים – אותו רוחב וללא leading
        //       SizedBox(
        //         width: boxW,
        //         child: Text(
        //           '(${ans[i]})',
        //           textAlign: TextAlign.center,
        //           textScaleFactor: 1.0,
        //           style: TextStyle(
        //             fontSize: font * 0.85, // טיפה קטן יותר
        //             height: 1.0,
        //             color: Colors.black,
        //             fontWeight: field.bold.isNotEmpty ? FontWeight.bold : FontWeight.normal,
        //           ),
        //           strutStyle: const StrutStyle(height: 1.0, forceStrutHeight: true),
        //           textHeightBehavior: const TextHeightBehavior(
        //             applyHeightToFirstAscent: false,
        //             applyHeightToLastDescent: false,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // );

        overlay.add(
          Positioned(
            left: xPosition,
            top: yPosition,
            child: myTextField,
          ),
        );

       i++;
        continue; // do NOT also add this to the base layer
      }

      // Non-editable: images / static text -> BASE layer (drawn first, may be opaque)
      base.add(
        Positioned(
          left: xPosition,
          top: yPosition,
          child: field.type == 'image'
              ? (field.defaultValue.isNotEmpty
                  ?  SizedBox(
            width: itemWidth,
            height: itemHeight,
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

    //widget.questionController.displayWithAnswers = buildQAnswers();
    widget.questionController.answerSnapshotCustomEditor = buildAnswerSnapshot(_scale);
    return true;
  }

  AnswerSnapshot buildAnswerSnapshot(double scale) {
    bool isOk = isCorrect() == widget.question.points;

    final baseW = double.parse(customData.customQuizQuestionsWidth);
    final baseH = double.parse(customData.customQuizQuestionsHeight);

    final baseFields = <BaseFieldSnapshot>[];
    final answerFields = <AnswerFieldSnapshot>[];

    int i = 0;


    for (final field in customData.quizFields) {

      if (field.name.isEmpty ||
          field.xPosition.isEmpty ||
          field.yPosition.isEmpty) {
        continue;
      }

      final x = double.parse(field.xPosition) ;
      final y = double.parse(field.yPosition);

      // ---------- BASE (image / static text) ----------
      if (field.editable.isEmpty) {
        baseFields.add(
          BaseFieldSnapshot(
            type: field.type,
            x: x,
            y: y,
            width: field.width.isNotEmpty
                ? double.parse(field.width)
                : null,
            height: field.height.isNotEmpty
                ? double.parse(field.height)
                : null,
            value: field.defaultValue,
            fontSize: field.fontSize.isNotEmpty
                ? double.parse(field.fontSize)
                : null,
            bold: field.bold.isNotEmpty,
            color: field.color.isNotEmpty
                ? Color(int.parse(field.color))
                : null,
            direction: field.direction == 'rtl'
                ? TextDirection.rtl
                : TextDirection.ltr,
          ),
        );
        continue;
      }

      // ---------- ANSWER ----------
      final font = double.parse(field.fontSize) ;
      double  height=0;
      if(field.height.isEmpty) {
        height = calcFieldHeight(
            fontSize: font ?? 14.0,
            originalFont: double.parse(field.fontSize));
      }

      answerFields.add(
        AnswerFieldSnapshot(
          name: field.name,
          x: x,
          y: y,
          width: double.parse(field.maxWidth) ,
          height: height,
          fontSize: font,
          userAnswer: myControllers[i].text,
          correctAnswer: ans[i],
          isCorrect: myControllers[i].text == ans[i],
          bold: field.bold.isNotEmpty,
          color: field.color.isNotEmpty
              ? Color(int.parse(field.color))
              : null,
          direction: field.direction == 'rtl'
              ? TextDirection.rtl
              : TextDirection.ltr,
        ),
      );

      i++;
    }

    return AnswerSnapshot(
      isCorrect: isOk,
      question: widget.question.question,
      questionId: widget.question.quizId,
      baseWidth: baseW,
      baseHeight: baseH,
      baseFields: baseFields,
      answerFields: answerFields,
    );
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
class AnswerSnapshot {
  final int questionId;
  final double baseWidth;
  final double baseHeight;
  final bool isCorrect;
  final String question;

  final List<BaseFieldSnapshot> baseFields;
  final List<AnswerFieldSnapshot> answerFields;

  AnswerSnapshot( {
    required this.baseFields,
    required this.question,
    required this.isCorrect,
    required this.questionId,
    required this.baseWidth,
    required this.baseHeight,
    required this.answerFields,
  });
}

class AnswerFieldSnapshot {

  final String name;
  final double x;
  final double y;
  final double width;
  final double height;
  final double fontSize;

  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  final bool bold;
  final Color? color;
  final TextDirection direction;

  AnswerFieldSnapshot({
    required this.name,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    required this.bold,
    required this.color,
    required this.direction,
  });
}

class BaseFieldSnapshot {
  final String type; // image | text
  final double x;
  final double y;
  final double? width;
  final double? height;

  final String value; // image url OR text
  final double? fontSize;
  final bool bold;
  final Color? color;
  final TextDirection direction;

  BaseFieldSnapshot({
    required this.type,
    required this.x,
    required this.y,
    required this.value,
    this.width,
    this.height,
    this.fontSize,
    required this.bold,
    required this.color,
    required this.direction,
  });
}

