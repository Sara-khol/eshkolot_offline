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
            final withLines = normalizeLineBreaks(raw);

            final fixed = normalizeNumberedEquationLine(normalizeInputImgBlock(normalizeStrongWrappedImgInput(withLines)));
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



  Widget? displayWidgetByHtml(var element) {
    if (element is! dom.Element) return null;

    final srcAttribute = element.attributes['src'];
    final width = element.attributes['width'];
    final height = element.attributes['height'];
    final styleAttribute = element.attributes['style'];
    final fontWeightAttribute = element.attributes['font-weight'];
    final tagName = element.localName;


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
      if (order == 'img-first') {
        children.add(SizedBox(width: 20.w),);
        children.addAll(imageWidgets);
        children.add(SizedBox(width: 6.w));
        children.add(inputWidget);
      } else {
        children.add(inputWidget);
        children.add(SizedBox(width: 6.w));
        children.addAll(imageWidgets);
        children.add(SizedBox(width: 20.w),);

      }

      return InlineCustomWidget(
        child: Directionality(
          textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
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
      // debugPrint('srcAttribute $srcAttribute');
      if (srcAttribute != null) {
          return InlineCustomWidget(
            child: displayFile(srcAttribute, height, width, WidgetType.image,
                alt: element.attributes['alt']),
          );
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
    } else if (!isLesson) {
      path =
      //  '${appSupportDir!.path}/${Constants.lessonPath}/${MainPageChild.of(context)!.widget.course.id}/$srcAttribute';
      '${appSupportDir!.path}/${Constants.lessonPath}/${MainPageChild.of(context)!.widget.course.id}/${widget.quizId}';
      File file = File(path);
      if (await file.exists()) {
        debugPrint('truuuuuuuuuu path $path');
        return file;
      }
      return null;
    } else {
      return null;
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

  String removeDirectionStyle(String html) {
    // מסיר direction: ltr !important מכל style
    return html.replaceAll(
      RegExp(r'direction\s*:\s*ltr\s*!important;?', caseSensitive: false),
      '',
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

    // ===== מקרה 0: img + span + img  ==> triple =====
    final reTriple = RegExp(
      r'(<img\b[^>]*>\s*(?:<br\s*/?>\s*)*)'
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

    // ===== מקרה 1: span ואז תמונות =====
    final reInputFirst = RegExp(
      r'(<span\b[^>]*data-input="[^"]*"[^>]*>\s*</span>)'
      r'(?:\s*</?(?:strong|b|em)>\s*)*'
      r'(?:\s*<br\s*/?>\s*)*'
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
    final reImgFirst = RegExp(
      r'((?:\s*<img\b[^>]*>\s*(?:<br\s*/?>\s*)*)+)'
      r'(?:\s*</?(?:strong|b|em)>\s*)*'
      r'(?:\s*<br\s*/?>\s*)*'
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


  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

enum WidgetType { image, audio, video, pdf }

