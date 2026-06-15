import 'dart:io';
import 'dart:math' as math;

import 'package:eshkolot_offline/ui/custom_widgets/audio_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/video_widget.dart';
import 'package:eshkolot_offline/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_unescape/html_unescape.dart';
import 'package:eshkolot_offline/utils/constants.dart' as Constants;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:ui' as ui;
import 'package:html/parser.dart' as html_parser;


import '../../utils/common_funcs.dart';
import '../screens/course_main/main_page_child.dart';

typedef WidgetCallback = Widget Function(List<String?> s);

class HtmlDataWidget extends StatefulWidget {
  const HtmlDataWidget(this.text,
      {super.key, required this.quizId, this.onInputWidgetRequested,  this.textStyle,this.isImageMatrix=false});

  final String text;
  final int quizId;
  final TextStyle? textStyle;
  final WidgetCallback? onInputWidgetRequested;
  final bool isImageMatrix;

  @override
  State<HtmlDataWidget> createState() => _HtmlDataWidgetState();
}

class _HtmlDataWidgetState extends State<HtmlDataWidget> {
  Directory? appSupportDir;
  final _focusNode = FocusNode();

  initDirectory() async {
    appSupportDir = await CommonFuncs().getEshkolotWorkingDirectory();
    return appSupportDir;
  }

  @override
  Widget build(BuildContext context) {
    String s= convertCustomAudioTags(widget.text);
    // debugPrint('html: $s');
    return isHTML(s)
        ? FutureBuilder(
        future: initDirectory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var raw = HtmlUnescape().convert(convertCustomAudioTags(widget.text));
            if(widget.quizId==31692)
            {
              debugPrint('noDirrrrr');
              raw = removeDirectionStyle(raw);
            }
            final withLines = normalizeLtrDirToStyle(normalizeValueEqualsImg(normalizeLineBreaks(raw)));

            final fixed = restoreRowBreaks(normalizeNumberedEquationLine(normalizeInputImgBlock(normalizeStrongWrappedImgInput(withLines))));
            debugPrint('html: $fixed');
            return SelectionArea(
                focusNode: _focusNode,
                child: HtmlWidget(fixed,
                    textStyle:widget.textStyle ?? TextStyle(
                        fontSize: 27.sp /*20.sp*/,
                        fontWeight: FontWeight.w400,
                        color: blackColorApp),

                    //textStyle: TextStyle(fontSize: ScreenUtil().setSp(fontSize.toDouble())),
                    customWidgetBuilder: (element) {
                      return displayWidgetByHtml(element);
                    }));

            // )
          }
          return const CircularProgressIndicator();
        })
        : Text(
      widget.text,
      style:widget.textStyle ?? TextStyle(
          fontSize: 27.sp/*20.sp*/ ,
          fontWeight: FontWeight.w400,
          color: blackColorApp),
      textAlign: TextAlign.right,
    );
  }



  // מרנדר את ילדי פסקת-האלגברה כרשימת widgets *אטומיים* ל-Wrap RTL.
  // קריטי: pair/triple/text-between מפורקים ל-tokens נפרדים (תיבה, טקסט, תמונה)
  // ולא נשארים widget אחד — כדי שה-Wrap יוכל לשבור שורה *ביניהם* כמו הדפדפן
  // (אחרת תיבה "תקועה" בתוך composite לא יורדת לשורה הבאה). הסדר נשמר כמקור;
  // ה-Wrap עם textDirection: rtl הופך אותו לימין-לשמאל.
  // חשוב: בקשות הקלט (onInputWidgetRequested → counter) נשארות בסדר המקור.
  List<Widget> _renderRtlInline(List<dom.Node> nodes) {
    final out = <Widget>[];
    final style = widget.textStyle ??
        TextStyle(fontSize: 27.sp, fontWeight: FontWeight.w400, color: blackColorApp);

    List<dom.Element> imgsIn(dom.Element e) {
      final r = <dom.Element>[];
      void walk(dom.Node n) {
        if (n is dom.Element) {
          if (n.localName == 'img') r.add(n);
          for (final c in n.nodes) walk(c);
        }
      }
      walk(e);
      return r;
    }

    Widget imgWidget(dom.Element img) => displayFile(img.attributes['src']!,
        img.attributes['height'], img.attributes['width'], WidgetType.image,
        alt: img.attributes['alt']);

    Widget? inputWidget(String? val, String? ans) =>
        widget.onInputWidgetRequested != null
            ? widget.onInputWidgetRequested!([val, ans])
            : null;

    void addText(String raw) {
      var t = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
      if (t.isEmpty) return;
      t = t.replaceAllMapped(RegExp(r'\.(\d+)'), (m) => '${m[1]}.'); // ".3"→"3."
      out.add(Text(t, style: style, textDirection: TextDirection.rtl));
    }

    for (final node in nodes) {
      if (node is dom.Element) {
        final tag = node.localName;
        final layout = node.attributes['data-layout'];
        if (tag == 'br') {
          out.add(const SizedBox(width: double.infinity, height: 0));
        } else if (tag == 'img') {
          out.add(imgWidget(node));
        } else if (tag == 'span' && layout == 'text-between') {
          final i1 = inputWidget(node.attributes['data-input1'], node.attributes['data-answer1']);
          final i2 = inputWidget(node.attributes['data-input2'], node.attributes['data-answer2']);
          if (i1 != null) out.add(i1);
          addText(node.attributes['data-text'] ?? '');
          if (i2 != null) out.add(i2);
          for (final img in imgsIn(node)) out.add(imgWidget(img));
        } else if (tag == 'span' && layout == 'pair') {
          final inp = inputWidget(node.attributes['data-input'], node.attributes['data-answer']);
          final imgs = imgsIn(node);
          if (node.attributes['data-order'] == 'input-first') {
            if (inp != null) out.add(inp);
            for (final img in imgs) out.add(imgWidget(img));
          } else {
            for (final img in imgs) out.add(imgWidget(img));
            if (inp != null) out.add(inp);
          }
        } else if (tag == 'span' && layout == 'triple') {
          final imgs = imgsIn(node);
          final inp = inputWidget(node.attributes['data-input'], node.attributes['data-answer']);
          if (imgs.isNotEmpty) out.add(imgWidget(imgs.first));
          if (inp != null) out.add(inp);
          for (final img in imgs.skip(1)) out.add(imgWidget(img));
        } else if (tag == 'span' && node.attributes.containsKey('data-input')) {
          final inp = inputWidget(node.attributes['data-input'], node.attributes['data-answer']);
          if (inp != null) out.add(inp);
        } else {
          // strong/b/em/span-עיצוב/אחר → רקורסיה לתוכן
          out.addAll(_renderRtlInline(node.nodes));
        }
      } else if (node is dom.Text) {
        addText(node.text);
      }
    }
    return out;
  }

  Widget? displayWidgetByHtml(var element) {
    if (element is! dom.Element) return null;

    final srcAttribute = element.attributes['src'];
    final width = element.attributes['width'];
    final height = element.attributes['height'];
    final styleAttribute = element.attributes['style'];
    final fontWeightAttribute = element.attributes['font-weight'];
    final tagName = element.localName;

    // ===== פסקת אלגברה RTL =====
    // <p style="...text-align: left..."> ללא direction: ltr, שמכילה קלט = תוכן RTL
    // (עברי/אלגברה) שיושר שמאל. fwfh מרנדר LTR ולא הופך את סדר האלמנטים כמו האתר,
    // ולכן בונים בעצמנו Wrap עם textDirection: rtl ששולט בסדר. אנגלית מסומנת
    // direction: ltr ולכן לא נכללת; פסקאות ללא קלט לא נכללות (כדי לצמצם השפעה).
    if (element.localName == 'p') {
      final style = element.attributes['style'] ?? '';
      final isLeft =
          RegExp(r'text-align:\s*left', caseSensitive: false).hasMatch(style);
      final hasDirLtr =
          RegExp(r'direction:\s*ltr', caseSensitive: false).hasMatch(style);
      final hasInput = element.innerHtml.contains('data-input') ||
          element.innerHtml.contains('data-layout');
      if (isLeft && !hasDirLtr && hasInput) {
        final kids = _renderRtlInline(element.nodes);
        return Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: Wrap(
            textDirection: TextDirection.rtl,
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4.w,
            runSpacing: 6.h,
            children: kids,
          ),
        );
      }
      return null; // שאר ה-<p> → fwfh מטפל כרגיל
    }

    try{
      if (element.localName == 'span' &&
          element.attributes['data-layout'] == 'pair' &&
          widget.onInputWidgetRequested != null) {

        final inputVal = element.attributes['data-input'];
        final answer   = element.attributes['data-answer'];
        final order    = element.attributes['data-order'];

        if (inputVal == null) return null;

        final imgs = element.querySelectorAll('img');

        // 🔍 בדיקה אם יש direction:ltr באחד ההורים
        bool isLtr = false;
        dom.Element? p = element.parent;
        while (p != null) {
          final style = p.attributes['style'];
          if (style != null && style.contains('direction: ltr')) {
            isLtr = true;
            break;
          }
          p = p.parent;
        }

        final inputWidget = widget.onInputWidgetRequested!([inputVal, answer]);

        final imageWidgets = imgs.asMap().entries.map((entry) {
          final index = entry.key;
          final img = entry.value;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (index > 0) SizedBox(width: 20.w),
              displayFile(
                img.attributes['src']!,
                img.attributes['height'],
                img.attributes['width'],
                WidgetType.image,
              ),
            ],
          );
        }).toList();

        final children = <Widget>[];

        // סדר לפי data-order
        // הערה: ה-Wrap תמיד LTR (כדי שה-<br/> בין פריטים יעבוד).
        // לכן כשהתוכן RTL (!isLtr) צריך להפוך את סדר הילדים ידנית
        // כדי שה-input יופיע בצד ימין (כמו שהיה עם RTL Wrap).
        if (order == 'img-first') {
          if (isLtr) {
            // LTR: תמונה שמאלה, input ימינה
            children.add(SizedBox(width: 20.w));
            children.addAll(imageWidgets);
            children.add(SizedBox(width: 6.w));
            children.add(inputWidget);
          } else {
            // RTL: input שמאלה, תמונה ימינה
            children.add(inputWidget);
            children.add(SizedBox(width: 6.w));
            children.addAll(imageWidgets);
            children.add(SizedBox(width: 20.w));
          }
        } else {
          // input-first
          if (isLtr) {
            // LTR: input שמאלה, תמונה ימינה
            children.add(inputWidget);
            children.add(SizedBox(width: 6.w));
            children.addAll(imageWidgets);
            children.add(SizedBox(width: 20.w));
          } else {
            // RTL: תמונה שמאלה, input ימינה
            // כשיש מספר תמונות — הופכים את הסדר:
            // המקור {input} img1 img2 → קריאה RTL: input ימינה, img1 אחריו, img2 שמאלה
            // ולכן בתצוגה שמאל←ימין: img2 | img1 | input  (= imageWidgets.reversed)
            children.add(SizedBox(width: 20.w));
            children.addAll(imageWidgets.reversed);
            children.add(SizedBox(width: 6.w));
            children.add(inputWidget);
          }
        }

        return InlineCustomWidget(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 0,
              children: children,
            ),
          ),
        );
      }


      /*   if (element.localName == 'span' &&
        element.attributes['data-layout'] == 'pair' &&
        widget.onInputWidgetRequested != null) {

      final inputVal = element.attributes['data-input'];
      final answer   = element.attributes['data-answer'];
      final order    = element.attributes['data-order']; // input-first / img-first

      debugPrint('answer $answer');

      if (inputVal == null) return null;

      final imgs = element.querySelectorAll('img');

      // בונים את הווידג'טים
      final inputWidget = widget.onInputWidgetRequested!([inputVal, answer]);

      final imageWidgets = imgs.asMap().entries.map((entry) {
        final index = entry.key;
        final img = entry.value;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (index > 0) SizedBox(width: 20.w), // רווח בין תמונות
            displayFile(
              img.attributes['src']!,
              img.attributes['height'],
              img.attributes['width'],
              WidgetType.image,
            ),
          ],
        );
      }).toList();

      // לפי הסדר מה-HTML
      final children = <Widget>[];

      if (order == 'img-first') {
        children.add( SizedBox(width: 20.w));
        children.addAll(imageWidgets);
        children.add(SizedBox(width: 6.w));
        children.add(inputWidget);
      } else {
        // ברירת מחדל: input-first
        children.add(inputWidget);
        children.add(SizedBox(width: 6.w));
        children.addAll(imageWidgets);
      }

      return InlineCustomWidget(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 0,
          children: children,
        ),
      );
    }*/



      // ===== fraction: עמודת מונה / קו / מכנה =====
      // מוחזר כ-block widget (לא InlineCustomWidget) — מבטיח שורה נפרדת מעל התמונה
      if (element.localName == 'span' &&
          element.attributes['data-layout'] == 'fraction' &&
          widget.onInputWidgetRequested != null) {
        final input1  = element.attributes['data-input1'];
        final answer1 = element.attributes['data-answer1'];
        final input2  = element.attributes['data-input2'];
        final answer2 = element.attributes['data-answer2'];
        if (input1 == null || input2 == null) return null;

        final numWidget = widget.onInputWidgetRequested!([input1, answer1]);
        final denWidget = widget.onInputWidgetRequested!([input2, answer2]);

        // InlineCustomWidget עם <br/> לפני ואחרי (ב-reFraction) = שורה נפרדת
        return InlineCustomWidget(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              numWidget,
              Container(
                width: 140.w,
                height: 2,
                color: Colors.black,
                margin: EdgeInsets.symmetric(vertical: 4.h),
              ),
              denWidget,
            ],
          ),
        );
      }

      // ===== text-bar-stack: INPUT / טקסט-מקפים / INPUT (אנכי) =====
      // למשל: {6|1} π —————— {7|1}  → Column של שלוש שורות, תמונה כ-block מתחת
      if (element.localName == 'span' &&
          element.attributes['data-layout'] == 'text-bar-stack' &&
          widget.onInputWidgetRequested != null) {
        final input1  = element.attributes['data-input1'];
        final answer1 = element.attributes['data-answer1'];
        final input2  = element.attributes['data-input2'];
        final answer2 = element.attributes['data-answer2'];
        final barText = element.attributes['data-bar'] ?? '';
        if (input1 == null || input2 == null) return null;
        final inputWidget1 = widget.onInputWidgetRequested!([input1, answer1]);
        final inputWidget2 = widget.onInputWidgetRequested!([input2, answer2]);
        final textStyle = widget.textStyle ??
            TextStyle(fontSize: 27.sp, fontWeight: FontWeight.w400, color: blackColorApp);

        return InlineCustomWidget(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 32.w),
                child: inputWidget1,
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 2.h, right: 16.w),
                child: Text(barText, style: textStyle),
              ),
              Padding(
                padding: EdgeInsets.only(right: 32.w),
                child: inputWidget2,
              ),
            ],
          ),
        );
      }

      // ===== text-between: [INPUT_A] טקסט [INPUT_B] (+ תמונה אופציונלית) =====
      // מטפל בביטויים כמו {11}√{2} ו-{11}√{2}<img> שהפכו ל-data-layout="text-between"
      if (element.localName == 'span' &&
          element.attributes['data-layout'] == 'text-between' &&
          widget.onInputWidgetRequested != null) {
        final input1  = element.attributes['data-input1'];
        final answer1 = element.attributes['data-answer1'];
        final input2  = element.attributes['data-input2'];
        final answer2 = element.attributes['data-answer2'];
        final textContent = element.attributes['data-text'] ?? '';
        if (input1 == null || input2 == null) return null;

        // בדיקת isLtr מה-parent (כמו ב-pair)
        bool isLtr = false;
        dom.Element? ltrCheck = element.parent;
        while (ltrCheck != null) {
          final style = ltrCheck.attributes['style'];
          if (style != null && style.contains('direction: ltr')) {
            isLtr = true;
            break;
          }
          ltrCheck = ltrCheck.parent;
        }

        final inputWidget1 = widget.onInputWidgetRequested!([input1, answer1]);
        final inputWidget2 = widget.onInputWidgetRequested!([input2, answer2]);

        final textStyle = widget.textStyle ??
            TextStyle(fontSize: 27.sp, fontWeight: FontWeight.w400, color: blackColorApp);

        final textPadding = Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Text(textContent, style: textStyle),
        );

        // האם יש תמונה בתוך ה-span (מגיע מ-{11}√{2}<img>)
        final imgs = element.querySelectorAll('img');

        if (imgs.isNotEmpty) {
          final imageWidget = displayFile(
            imgs.first.attributes['src']!,
            imgs.first.attributes['height'],
            imgs.first.attributes['width'],
            WidgetType.image,
          );
          final rowChildren = <Widget>[
            inputWidget1, textPadding, inputWidget2,
            SizedBox(width: 6.w), imageWidget,
          ];
          return InlineCustomWidget(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
              children: rowChildren,
            ),
          );
        }

        // אין תמונה — טקסט קצר (סמל מתמטי): Row פשוט
        return InlineCustomWidget(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
            children: [inputWidget1, textPadding, inputWidget2],
          ),
        );
      }

      if (element.localName == 'span' &&
          element.attributes['data-layout'] == 'triple' &&
          widget.onInputWidgetRequested != null) {

        final inputVal = element.attributes['data-input'];
        final answer   = element.attributes['data-answer'];

        if (inputVal == null) return null;

        final imgs = element.querySelectorAll('img');

        return InlineCustomWidget(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6.w,
            children: [
              // תמונה(ות) לפני
              if (imgs.isNotEmpty) displayFile(
                imgs.first.attributes['src']!,
                imgs.first.attributes['height'],
                imgs.first.attributes['width'],
                WidgetType.image,
              ),

              // האינפוט באמצע
              widget.onInputWidgetRequested!([inputVal, answer]),

              // שאר התמונות אחרי
              ...imgs.skip(1).map((img) => displayFile(
                img.attributes['src']!,
                img.attributes['height'],
                img.attributes['width'],
                WidgetType.image,
              )),
            ],
          ),
        );
      }

      if (element.localName == 'span' &&
          element.attributes.containsKey('data-input') &&
          widget.onInputWidgetRequested != null) {
        final value = element.attributes['data-input'];
        final answer = element.attributes['data-answer'];

        return InlineCustomWidget(
          child: widget.onInputWidgetRequested!([value, answer]),
        );
      }
    }catch(e,s)
    {
      debugPrint('error $e');
      debugPrint(s.toString());
    }
    if (element.localName == 'img') {
      if (srcAttribute != null) {
        // תמונות עם גובה ≤50px = inline (נוסחאות / משוואות / סמלים — גם אם רחבות)
        // תמונות עם גובה >50px = block (איורים / דיאגרמות — שורה נפרדת)
        // הגיון: משוואה יכולה להיות 320×17, סמל חץ 19×19 — שניהם inline.
        //        עיגול גיאומטרי 209×196 — block.
        final h = double.tryParse(height ?? '');
        final isInline = h != null && h <= 50;
        final imgWidget = displayFile(srcAttribute, height, width, WidgetType.image,
            alt: element.attributes['alt']);
        // תמונות inline (נוסחאות/סמלים) זורמות בשורה. תמונות block (איורים) הן
        // שורה נפרדת — ב-RTL הן צריכות להיות מיושרות לימין ולא ממורכזות.
        return isInline
            ? InlineCustomWidget(child: imgWidget)
            : Align(alignment: Alignment.centerRight, child: imgWidget);
      }
    }
    if (element.localName == 'audio') {
      if (srcAttribute != null) {
        return InlineCustomWidget(
          child: displayFile(srcAttribute, height, width, WidgetType.audio),
        );
      }
      // else if (element.localName == 'br') {
      //   return SizedBox(height: 0); // Hide the line break
      // }
      return null;
    }
    if (element.localName == 'iframe'||element.localName == 'video' || element.localName == 'source') {
      String? src = element.attributes['src'];

      // אם זה <source> בתוך <video>, ננסה לקחת מההורה
      if (src == null && element.parent?.localName == 'video') {
        src = element.parent?.children
            .firstWhere((child) => child.localName == 'source',
            orElse: () => element)
            .attributes['src'];
      }

      if (srcAttribute != null) {
        if (srcAttribute.split('.').last == 'pdf') {
          return InlineCustomWidget(
            child: displayFile(srcAttribute, height, width, WidgetType.pdf),
          );
        }
        // if (srcAttribute.split('.').last == 'mp4') {
        return InlineCustomWidget(
          child: displayFile(
              srcAttribute.split('.').last == 'mp4'
                  ? srcAttribute
                  : '${srcAttribute.split('?').first}.mp4',
              height,
              width,
              WidgetType.video,
              isLesson: false),
        );
        // }
      }
    }


    return null;
  }



  Widget displayFile(
      String srcAttribute, var height, var width, WidgetType type,
      {isLesson = false,String? alt=''}) {
    String src=srcAttribute;
    if(alt!=null && alt.isNotEmpty)
    {
      final cleanAlt = alt.trim();

      if (cleanAlt.isNotEmpty && cleanAlt != '/' && cleanAlt != 'null') {
        src += cleanAlt;
        debugPrint('src $src');
      }
    }
    return FutureBuilder<File?>(
      // future: getCurrentFile(srcAttribute),
      future: getCurrentFile(src.split('/').last, isLesson),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Show an error message
        } else {
          final file = snapshot.data;
          if (file != null) {
            switch (type) {
              case WidgetType.image:
                bool isSvg = src.toLowerCase().endsWith('.svg');
                if (isSvg) {
                  return SizedBox(
                    width: double.tryParse(width ?? '') ?? 200.w,
                    height: double.tryParse(height ?? '') ?? 200.w,
                    child: SvgPicture.file(
                      file,
                      fit: BoxFit.contain,
                    ),
                  );
                }

                return FutureBuilder<ui.Image>(
                    future: decodeImageFromFile(file),
                    builder: (context, imageSnapshot) {
                      if (imageSnapshot.connectionState == ConnectionState.done &&
                          imageSnapshot.hasData) {
                        final image = imageSnapshot.data!;
                        if(widget.isImageMatrix) {
                          final aspect = image.width / image.height;

                          final w = math.min(200.w, image.width.toDouble());
                          final h = w / aspect;
                          debugPrint('w: $w h: $h');
                          return  SizedBox(
                            width: w,
                            height: h,
                            child:
                            Image.file(
                              file,
                              fit: BoxFit.contain,
                              filterQuality: FilterQuality.high,
                            ),
                          );
                        }

                        return SizedBox(
                          // width: image.width.toDouble(),
                          // height: image.height.toDouble(),
                          //width:width!=null? double.tryParse(width):image.width.toDouble(),
                          width: double.tryParse(width ?? '') ??
                              image.width.toDouble(),
                          height: double.tryParse(height ?? '') ??
                              image.height.toDouble(),
                          child: Image.file(
                            file,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                          ),
                        );

                      } else {
                        return const CircularProgressIndicator();
                      }});
            /*return Image.file(
                  file,
                  fit: BoxFit.contain,

                  // height: height != null
                  //     ? int.parse(height.toString()) * 2.w
                  //     : null,
                  // width:
                  //     width != null ? int.parse(width.toString()) * 2.h : null,
                );*/
              case WidgetType.audio:
                return AudioWidget(
                  path: file.path,
                );
              case WidgetType.video:
                return Padding(
                    padding: EdgeInsets.only(bottom: 7.h),
                    child: VideoWidget(
                      isLesson: isLesson,
                      key: Key(widget.quizId.toString()),
                      videoId: srcAttribute.split('.').first,
                      fileId: !isLesson
                          ? widget.quizId
                          : MainPageChild.of(context)!.widget.course.id,
                      width:
                      width != null ? int.parse(width.toString()).w : 914.w,
                      height: height != null
                          ? int.parse(height.toString()).h
                          : 515.h,
                    ));
              case WidgetType.pdf:
                return SizedBox(
                    width:
                    width != null ? int.parse(width.toString()).w : 100.w,
                    height:
                    height != null ? int.parse(height.toString()).h : 100.w,
                    child: SfPdfViewer.file(file));
            }
          } else {
            return Text(
                'No ${type.name} $src'); // If the file doesn't exist
          }
        }
      },
    );
  }

  Future<File?> getCurrentFile(String srcAttribute, isLesson) async {
    if (appSupportDir == null) {
      return null;
    }
    String path = !isLesson
        ? '${appSupportDir!.path}/${Constants.quizPath}/${widget.quizId}/$srcAttribute'
        : '${appSupportDir!.path}/${Constants.lessonPath}/${MainPageChild.of(context)!.widget.course.id}/$srcAttribute';
    File file = File(path);

    if (await file.exists()) {
      debugPrint('yesss path $path');
      return file;
      //check if file exists in course file from vimeo
    } else
    if (!isLesson && srcAttribute.contains('gif')) {

      final options = buildLatexFileNameOptions(srcAttribute);

      for (final fileName in options) {
        path= '${appSupportDir!.path}/${Constants.quizPath}/'
            '${widget.quizId}/$fileName';
        final file = File(path);
        if (file.existsSync()) {
          debugPrint('ffffff path $path');
          return file;
        }
        else
        {
          debugPrint('ffffff do not find path $path');
        }
      }

      return null;
    }
    else {
      if (!isLesson) {
        path =
        //  '${appSupportDir!.path}/${Constants.lessonPath}/${MainPageChild.of(context)!.widget.course.id}/$srcAttribute';
        '${appSupportDir!.path}/${Constants.lessonPath}/${MainPageChild
            .of(context)!
            .widget
            .course
            .id}/${widget.quizId}';
        File file = File(path);
        if (await file.exists()) {
          debugPrint('truuuuuuuuuu path $path');
          return file;
        }
        else {

        }
        return null;
      } else {
        return null;
      }
    }
  }

  Future<ui.Image> decodeImageFromFile(File file) async {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    // debugPrint('widthhhh  ${frame.image.width.toDouble()}');
    // debugPrint('heightttt  ${frame.image.height.toDouble()}');
    return frame.image;
  }

  String convertCustomAudioTags(String htmlContent) {
    final RegExp customAudioRegExp = RegExp(
      r'\[audio\s+(?:mp3|src)="([^"]+)"\]\[\/audio\]',
      caseSensitive: false,
      multiLine: false,
    );

    return htmlContent.replaceAllMapped(customAudioRegExp, (match) {
      final audioUrl = match.group(1);
      return '<audio src="$audioUrl" controls></audio>';
    });
  }

  bool isHTML(String str) {
    final RegExp htmlRegExp =
    RegExp('<[^>]*>', multiLine: true, caseSensitive: false);
    return htmlRegExp.hasMatch(str);
  }

  String addBreakAfterImgs(String html) {
    // תופס <img ...> (כולל self-closing) ומוסיף <br/> אחרי
    // final re = RegExp(r'(<img\b[^>]*>)', caseSensitive: false);
    final re = RegExp(
      r'(<img\b[^>]*>)(?!\s*<br\s*/?>)',
      caseSensitive: false,
    );
    //return html.replaceAllMapped(re, (m) => '${m[1]}<br/>');
    return html;
  }

  String normalizeLineBreaks(String html) {
    // 1. מאחדת סוגי אנטרים שונים (\r\n, \r) ל-\n
    String result = html.replaceAll('\r\n', '\n').replaceAll('\r', '\n');

    // 2. ממירה אנטרים ל-<br/>
    result = result.replaceAll('\n', '<br/>');

    // 3. מבטיחה שתגיות בלוק יגרמו לשורה חדשה
    // const blockTags = ['p', 'div', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6'];
    // for (final tag in blockTags) {
    //   result = result.replaceAllMapped(
    //     RegExp('</$tag>', caseSensitive: false),
    //         (m) => '</$tag><br/>',
    //   );
    // }

    return result;
  }

  // מוסיף <br/> בין פריטים עוקבים כדי שכל פריט יופיע בשורה נפרדת.
  // הגישה: כל </span> או <img/> שאחריהם (אפשר עם טקסט ביניים, ללא תגי HTML)
  //        מגיע <span data-input — מוסיפים <br/> כדי לשבור שורה לפני הפריט הבא.
  // זה תופס גם מעבר ישיר ("</span><span>") וגם מעבר דרך טקסט תווית ("</span>מצא... <span>").
  String restoreRowBreaks(String html) {
    // מקרה 0: <strong>N.</strong> או <strong>N. </strong> = מספר שאלה
    // תופס גם <br> מרובים שלפניהם ומנרמל ל-<br/> יחיד (חוץ מהשאלה הראשונה שלא צריכה <br/>)
    // דוגמאות: <strong>1.</strong>  /  <strong>1. </strong>  /  <br><br><strong>2.</strong>
    bool firstQuestion = true;
    html = html.replaceAllMapped(
      RegExp(r'(?:<br\s*/?>\s*)*(<strong>\d+\.\s*</strong>)', caseSensitive: false),
      (m) {
        if (firstQuestion) {
          firstQuestion = false;
          return m.group(1)!;          // שאלה ראשונה — ללא <br/>
        }
        return '<br/>${m.group(1)!}';  // שאלות הבאות — בדיוק <br/> אחד, ללא קשר לכמה היו לפני
      },
    );
    // בלוקים של <p style="text-align: left"> זורמים inline (LTR — אלגברה/אנגלית).
    // אסור להוסיף בהם מעברי שורה היוריסטיים (מקרים 1a/1c/2/3): מעבר שורה אמיתי
    // חייב להגיע מ-<br> מפורש במקור (ראו [[no-guessing-line-breaks]]).
    // מסתירים את הבלוקים האלה, מריצים את שאר המקרים, ומשחזרים בסוף.
    final ltrBlocks = <String>[];
    html = html.replaceAllMapped(
      RegExp(r'<p\b[^>]*text-align:\s*left[^>]*>.*?</p>',
          caseSensitive: false, dotAll: true),
      (m) {
        ltrBlocks.add(m.group(0)!);
        return '@@LTRBLOCK${ltrBlocks.length - 1}@@';
      },
    );
    // מקרה 1a: </span> ישירות (עם רווח בלבד) לפני <span data-input
    html = html.replaceAllMapped(
      RegExp(r'</span>\s*(?=<span\b[^>]*data-input)', caseSensitive: false),
      (_) => '</span><br/>',
    );
    // מקרה 1b הוסר — הוסיף <br/> על סמך אורך טקסט (≥10 תווים) שהיא הנחה שרירותית.
    // אם ה-HTML המקורי לא מכיל \n בין אלמנטים — הם אמורים להיות על אותה שורה.
    // normalizeLineBreaks כבר מטפל ב-\n → <br/>.
    // מקרה 1c: </span> + מפריד-סמלים בלבד + <span data-input>
    // תופס מפרידים כמו " = " בין pair spans (כבר אחרי שreTextBetween צרך סמלים מתמטיים).
    // המפריד אסור שיכיל אותיות — עברית (א-ת) או אנגלית (a-zA-Z) — כדי לא לשבור
    // משפטי תוכן: למשל "{Are} the singers ... {are}" באנגלית, או תווית עברית.
    // רק סמלים/רווחים/מספרים (כמו " = ") מפרידים שתי תיבות לשורות נפרדות.
    html = html.replaceAllMapped(
      RegExp(r'</span>([^<א-תa-zA-Z]*)(?=<span\b[^>]*data-input)', caseSensitive: false),
      (m) => '</span><br/>${m.group(1)}',
    );
    // מקרה 2: <img/> ישירות לפני <span data-input
    html = html.replaceAllMapped(
      RegExp(r'(<img\b[^>]*/?>)\s*(?=<span\b[^>]*data-input)', caseSensitive: false),
      (m) => '${m.group(1)!}<br/>',
    );
    // מקרה 3: <span data-input> ישירות לפני span של קו שבר (id="קו_ארוך_[—]")
    // מוסיף <br/> בין המונה לקו השבר כדי שהשבר יוצג אנכית: מונה / קו / מכנה
    html = html.replaceAllMapped(
      RegExp(
        r'(<span\b[^>]*data-input="[^"]*"[^>]*>\s*</span>)\s*(?=<span\b[^>]*id="[^"]*קו_ארוך)',
        caseSensitive: false,
      ),
      (m) => '${m.group(1)!}<br/>',
    );
    // שחזור בלוקי ה-LTR שהוסתרו
    for (int k = 0; k < ltrBlocks.length; k++) {
      html = html.replaceAll('@@LTRBLOCK$k@@', ltrBlocks[k]);
    }
    return html;
  }

  String removeDirectionStyle(String html) {
    // מסיר direction: ltr !important מכל style
    return html.replaceAll(
      RegExp(r'direction\s*:\s*ltr\s*!important;?', caseSensitive: false),
      '',
    );
  }

  // מיישר שורות שכתובות הפוך במקור: {קלט} =<img תווית>  →  <img תווית> = {קלט}
  // כל שאר השאלות כתובות "תווית = קלט" (תמונה ואז קלט). ב-4.3 דווקא ה-a₁/S₉
  // נכתבו "קלט = תווית" (ערך ואז תמונה) ומחוץ ל-<p dir=ltr>, מה שגרם לתצוגה הפוכה.
  // ההמרה דטרמיניסטית (לא ניחוש) ומאחדת לכיוון אחד עקבי.
  String normalizeValueEqualsImg(String html) {
    return html.replaceAllMapped(
      RegExp(r'(<span\b[^>]*data-input="[^"]*"[^>]*>\s*</span>)\s*=\s*(<img\b[^>]*>)',
          caseSensitive: false),
      (m) => '${m.group(2)} = ${m.group(1)}',
    );
  }

  // <p dir="ltr" ... text-align: left ...> = תוכן אנגלי LTR. fwfh מתעלם מ-dir
  // attribute ומכבד רק direction ב-style, ובנוסף ה-<p> handler של האלגברה תופס
  // בטעות בלוקים כאלה (text-align:left + קלט). מוסיפים direction: ltr ל-style כדי:
  //   (1) ש-fwfh ירנדר LTR, (2) שה-handler לא יתפוס (כי hasDirLtr יהיה true).
  // לא נוגע באלגברה (אין לה dir) ולא במתמטיקה (text-align:right).
  String normalizeLtrDirToStyle(String html) {
    return html.replaceAllMapped(
      RegExp(r'<p\b([^>]*)>', caseSensitive: false),
      (m) {
        final attrs = m.group(1)!;
        final hasDirLtr =
            RegExp('''dir\\s*=\\s*["']ltr["']''', caseSensitive: false).hasMatch(attrs);
        final hasLeft =
            RegExp(r'text-align:\s*left', caseSensitive: false).hasMatch(attrs);
        final hasDirectionStyle =
            RegExp(r'direction:\s*ltr', caseSensitive: false).hasMatch(attrs);
        if (hasDirLtr && hasLeft && !hasDirectionStyle) {
          if (RegExp(r'style\s*=', caseSensitive: false).hasMatch(attrs)) {
            final newAttrs = attrs.replaceFirstMapped(
              RegExp('style\\s*=\\s*"([^"]*)"', caseSensitive: false),
              (s) => 'style="${s.group(1)} direction: ltr;"',
            );
            return '<p$newAttrs>';
          }
          return '<p$attrs style="direction: ltr;">';
        }
        return m.group(0)!;
      },
    );
  }

  String normalizeStrongWrappedImgInput(String html) {
    return html.replaceAll(
      RegExp(
        r'<strong>\s*(<img\b[^>]*>)\s*({[^}]+})\s*(<img\b[^>]*>)\s*</strong>',
        caseSensitive: false,
      ),
      r'\1<strong>\2</strong>\3',
    );
  }

  String normalizeInputImgBlock(String html) {

    String? _getAttr(String spanHtml, String name) {
      final m = RegExp('$name="([^"]*)"', caseSensitive: false)
          .firstMatch(spanHtml);
      return m?.group(1);
    }

    String _buildSpan({
      required String? input,
      String? answer,
      required String layout,
      String? order,
      required String innerHtml,
    }) {
      final b = StringBuffer('<span');

      if (input != null)  b.write(' data-input="$input"');
      if (answer != null) b.write(' data-answer="$answer"');
      b.write(' data-layout="$layout"');
      if (order != null)  b.write(' data-order="$order"');

      b.write('>');
      b.write(innerHtml);
      b.write('</span>');
      return b.toString();
    }

    // ===== מקרה FRACTION: span + קו_ארוך_span(s) + span ==> fraction =====
    // מזהה {מונה} + <span id="קו_ארוך_[—]">————</span> + {מכנה}
    // ועוטף אותם ב-data-layout="fraction" → יוצג כ-Column (מונה / קו / מכנה)
    // חייב לרוץ לפני reInputFirst כדי שהמכנה לא ייצמד לתמונה שאחריו
    final reFraction = RegExp(
      r'(<span\b[^>]*data-input="[^"]*"[^>]*>\s*</span>)'   // מונה
      r'\s*'
      // קו השבר — span אחד או יותר עם id=קו_ארוך; מאפשר <br/> אחרי כל span
      r'((?:<span\b[^>]*id="[^"]*קו_ארוך[^"]*"[^>]*>[^<]*</span>(?:\s*<br\s*/?>\s*)*\s*)+)'
      r'(<span\b[^>]*data-input="[^"]*"[^>]*>\s*</span>)',   // מכנה
      caseSensitive: false,
    );

    html = html.replaceAllMapped(reFraction, (m) {
      final span1   = m.group(1)!;
      final span2   = m.group(3)!;
      final input1  = _getAttr(span1, 'data-input')  ?? '';
      final answer1 = _getAttr(span1, 'data-answer');
      final input2  = _getAttr(span2, 'data-input')  ?? '';
      final answer2 = _getAttr(span2, 'data-answer');
      final buf = StringBuffer('<span data-layout="fraction"');
      buf.write(' data-input1="$input1"');
      if (answer1 != null) buf.write(' data-answer1="$answer1"');
      buf.write(' data-input2="$input2"');
      if (answer2 != null) buf.write(' data-answer2="$answer2"');
      buf.write('></span>');
      // <br/> לפני ואחרי מבטיחים שורה נפרדת מ-yi. שלפניו ומהתמונה שאחריו
      return '<br/>${buf.toString()}<br/>';
    });

    // ===== מקרה TEXT-BAR-STACK: span + טקסט-עם-מקפים + span + img =====
    // למשל: {6|1} π -------------- <strong><em> </em></strong> {7|1} <img/>
    // ממיר ל-data-layout="text-bar-stack" + img עצמאי (block)
    // כך שה-Column מציג INPUT1 / טקסט / INPUT2 אנכית, והתמונה מתחת כ-block.
    //
    // גישה: Tempered Greedy Token — (?:(?!<span\b[^>]*data-input).)
    //   = כל תו שאינו פותח span עם data-input (כלומר: לא חוצה לspan אחר).
    //   dotAll:true — . מתאים גם לשורות חדשות (אם נותרו אחרי normalizeLineBreaks).
    //   *? lazy — עוצר ב-span2 בהקדם האפשרי.
    final reFractionTextBarPair = RegExp(
      r'(<span\b[^>]*data-input="[^"]*"[^>]*>\s*</span>)'                       // span1 ריק (group1)
      r'((?:(?!<span\b[^>]*data-input).)*?-{3,}(?:(?!<span\b[^>]*data-input).)*?)' // תוכן עם 3+ מקפים (group2)
      r'(<span\b[^>]*data-input="[^"]*"[^>]*>\s*</span>)'                       // span2 ריק (group3)
      r'\s*(<img\b[^>]*/?>)',                                                     // img עצמאי (group4)
      caseSensitive: false,
      dotAll: true,
    );
    debugPrint('FRAC_BAR_MATCH: ${reFractionTextBarPair.hasMatch(html)}');
    html = html.replaceAllMapped(reFractionTextBarPair, (m) {
      // מסיר תגי HTML מהתוכן (כגון <strong><em>...</em></strong>) לקבלת טקסט רגיל
      final bar = m.group(2)!.replaceAll(RegExp(r'<[^>]+>'), '').trim();
      debugPrint('reFractionTextBarPair MATCHED: bar="$bar"');
      final span1  = m.group(1)!;
      final span2  = m.group(3)!;
      final imgTag = m.group(4)!;
      final input1  = _getAttr(span1, 'data-input')  ?? '';
      final answer1 = _getAttr(span1, 'data-answer');
      final input2  = _getAttr(span2, 'data-input')  ?? '';
      final answer2 = _getAttr(span2, 'data-answer');
      final buf = StringBuffer('<span data-layout="text-bar-stack"');
      buf.write(' data-input1="${input1.replaceAll('"', '&quot;')}"');
      if (answer1 != null) buf.write(' data-answer1="${answer1.replaceAll('"', '&quot;')}"');
      buf.write(' data-bar="${bar.replaceAll('"', '&quot;')}"');
      buf.write(' data-input2="${input2.replaceAll('"', '&quot;')}"');
      if (answer2 != null) buf.write(' data-answer2="${answer2.replaceAll('"', '&quot;')}"');
      buf.write('></span>');
      buf.write(imgTag);
      return buf.toString();
    });

    // ===== מקרה 0: img + span + img  ==> triple =====
    // (?<!</span>) = לא להתחיל triple כאשר ה-img הראשון בא מיד אחרי </span>
    // (כלומר: img ששייכת לפריט הקודם — מונע חיבור בין-פריטי שגוי)
    final reTriple = RegExp(
      r'(?<!</span>)(<img\b[^>]*>\s*(?:<br\s*/?>\s*)*)'
      r'(?:\s*</?(?:strong|b|em)>\s*)*'
      r'(?:\s*<br\s*/?>\s*)*'
      r'(<span\b[^>]*data-input="[^"]*"[^>]*>\s*</span>)'
      r'(?:\s*</?(?:strong|b|em)>\s*)*'
      r'(?:\s*<br\s*/?>\s*)*'
      r'(<img\b[^>]*>\s*(?:<br\s*/?>\s*)*)',
      caseSensitive: false,
    );

    html = html.replaceAllMapped(reTriple, (m) {
      final img1 = m.group(1)!;
      final span = m.group(2)!;
      final img2 = m.group(3)!;

      final input  = _getAttr(span, 'data-input');
      final answer = _getAttr(span, 'data-answer');

      return _buildSpan(
        input: input,
        answer: answer,
        layout: 'triple',
        innerHtml: img1 + img2,
      );
    });

    // ===== מקרה 0.5: span + טקסט (לא HTML) + span  ==>  text-between =====
    // מזהה {A}TEXT{B} כמו {11}√{2} ועוטף אותם ב-widget אחד שמציג
    // [INPUT_A] TEXT [INPUT_B] כ-Row מפורש — כך √ תמיד באמצע.
    // תומך גם ב-{11}√{2}<img> — מוסיף <img> לתוך ה-span כדי שהתמונה
    // תיכלל באותו widget (widget אחד רחב, לא שני אלמנטים נפרדים).
    // חייב לרוץ לפני reInputFirst כדי לצרוך את שני ה-spans לפני שהם מתפרדים.
    final reTextBetween = RegExp(
      r'(<span\b[^>]*data-input="[^"]*"[^>]*>\s*</span>)'
      r'([^<\r\nא-ת]{1,20})'  // סמל מתמטי קצר בלבד (√ / = / +), ללא עברית ומקסימום 20 תווים
      r'(<span\b[^>]*data-input="[^"]*"[^>]*>\s*</span>)'
      r'((?:\s*<br\s*/?>\s*)*<img\b[^>]*>)?',  // תמונה אופציונלית אחרי (גם אם יש <br/> ביניהם)
      caseSensitive: false,
    );
    html = html.replaceAllMapped(reTextBetween, (m) {
      final span1        = m.group(1)!;
      final textBetween  = m.group(2)!.trim();
      final span2        = m.group(3)!;
      final trailingImg  = m.group(4)?.trim(); // null אם אין תמונה
      final input1  = _getAttr(span1, 'data-input')  ?? '';
      final answer1 = _getAttr(span1, 'data-answer');
      final input2  = _getAttr(span2, 'data-input')  ?? '';
      final answer2 = _getAttr(span2, 'data-answer');
      final buf = StringBuffer('<span data-layout="text-between"');
      buf.write(' data-input1="$input1"');
      if (answer1 != null) buf.write(' data-answer1="$answer1"');
      buf.write(' data-input2="$input2"');
      if (answer2 != null) buf.write(' data-answer2="$answer2"');
      buf.write(' data-text="${textBetween.replaceAll('"', '&quot;')}"');
      buf.write('>');
      if (trailingImg != null) buf.write(trailingImg); // <img> בתוך ה-span
      buf.write('</span>');
      return buf.toString();
    });

    // ===== מקרה 1: span ואז תמונות =====
    // (?<![^\s>]) = רק כאשר ה-span מגיע אחרי רווח או '>' (תג/תחילת מחרוזת).
    // מונע pairing של span שמגיע אחרי טקסט כמו √ — כך שני spans עוקבים
    // (למשל {11}√{2}) נשארים ביחד ולא מופרדים ע"י התמונה.
    final reInputFirst = RegExp(
      r'(?<![^\s>])(<span\b[^>]*data-input="[^"]*"[^>]*>\s*</span>)'
      r'(?:\s*</?(?:strong|b|em)>\s*)*'
      // אין <br/> כאן — אסור לחצות גבול שורה!
      // {span}<br><img> = span בשורה 1, img תווית של שורה 2 — לא pair אחד
      r'((?:\s*<img\b[^>]*>\s*(?:<br\s*/?>\s*)*)+)',
      caseSensitive: false,
    );

    html = html.replaceAllMapped(reInputFirst, (m) {
      final span = m.group(1)!;
      final imgs = m.group(2)!;

      final input  = _getAttr(span, 'data-input');
      final answer = _getAttr(span, 'data-answer');

      return _buildSpan(
        input: input,
        answer: answer,
        layout: 'pair',
        order: 'input-first',
        innerHtml: imgs,
      );
    });

    // ===== מקרה 2: תמונות ואז span =====
    // (?<!</span>) = אסור ל-img להיות מיד אחרי </span> (כלומר אחרי text-between/pair)
    // מונע חיבור שגוי של תמונה "חופשית" (שנותרה מביטוי קודם) לפריט הבא.
    // התמונה והקלט חייבים להיות באותה שורה — אסור לחצות <br/>.
    // (אחרת תמונה בסוף שורה נתפסת ומזווגת לקלט של השורה הבאה — באג הזיווג ב-4.3:
    //  {656} =<img a1/><br>{1309}... → a1 נחטפה ל-1309 ו-656/s9 נותרו יתומים.)
    // קבוצת התמונות מאפשרת רק רווחים/strong|b|em ביניהן, ללא <br/>.
    final reImgFirst = RegExp(
      r'(?<!</span>)((?:\s*<img\b[^>]*>\s*)+)'
      r'(?:\s*</?(?:strong|b|em)>\s*)*'
      r'(<span\b[^>]*data-input="[^"]*"[^>]*>\s*</span>)',
      caseSensitive: false,
    );

    html = html.replaceAllMapped(reImgFirst, (m) {
      final imgs = m.group(1)!;
      final span = m.group(2)!;

      final input  = _getAttr(span, 'data-input');
      final answer = _getAttr(span, 'data-answer');

      return _buildSpan(
        input: input,
        answer: answer,
        layout: 'pair',
        order: 'img-first',
        innerHtml: imgs,
      );
    });

    return html;
  }

  //for fixing 31692 questionare ,second question 31707 , second line
  //in אלגברה בסיסית ב 34797
  String normalizeNumberedEquationLine(String html) {
    final re = RegExp(
      r'(<p\b[^>]*>)\s*'
      r'<strong>\s*(<span\b[^>]*data-input="([^"]+)"[^>]*>\s*</span>)\s*</strong>\s*'
      r'=\s*'
      r'(<img\b[^>]*>)\s*'
      r'<strong>\s*(?:&nbsp;|\s)*\.?(\d+)\s*</strong>\s*'
      r'(</p>)',
      caseSensitive: false,
    );

    return html.replaceAllMapped(re, (m) {
      final pOpen = m.group(1)!;        // <p ...>
      final inputSpan = m.group(2)!;    // <span data-input="..."></span>
      final img = m.group(4)!;          // <img ...>
      final num = m.group(5)!;          // 2
      final pClose = m.group(6)!;       // </p>

      // מוסיפים dir=ltr רק אם אין כבר (כדי לא לשבור אחרים)
      final hasDir = RegExp('\bdir\s*=\s*["\']ltr["\']', caseSensitive: false).hasMatch(pOpen) ||
          RegExp(r'direction\s*:\s*ltr', caseSensitive: false).hasMatch(pOpen);

      final newPOpen = hasDir
          ? pOpen
          : pOpen.replaceFirst(RegExp(r'<p\b', caseSensitive: false), '<p dir="ltr"');

      // סדר חד-משמעי: 2.  img = input
      return '$newPOpen<strong>$num.</strong> $img = $inputSpan$pClose';
    });
  }

  List<String> buildLatexFileNameOptions(String input) {
    String base = input.replaceFirst('gif.latex', '').trim();

    base = base.replaceAll(r'\large', 'large');

    base = base.replaceAll(' ', '&amp;amp_space__');

    base = base.replaceAllMapped(
      RegExp(r'\\tfrac\{(\d+)\}\{(\d+)\}'),
          (m) => 'tfrac_${m[1]}__${m[2]}_',
    );

    base = base.replaceAll(r'\', '');

    final withPng = 'gif.latex_$base.png';

    return {
      withPng,

      // תיקון נפוץ: להוסיף _ בין מספר לבין tfrac
      withPng.replaceAllMapped(
        RegExp(r'(\d)(tfrac_)'),
            (m) => '${m[1]}_${m[2]}',
      ),

      // תיקון הפוך: להסיר _ לפני tfrac
      withPng.replaceAllMapped(
        RegExp(r'(\d)_(tfrac_)'),
            (m) => '${m[1]}${m[2]}',
      ),
    }.toList();
  }


  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

enum WidgetType { image, audio, video, pdf }

