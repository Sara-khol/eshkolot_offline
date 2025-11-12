import 'dart:io';
import 'dart:math' as math;

import 'package:eshkolot_offline/ui/custom_widgets/audio_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/video_widget.dart';
import 'package:eshkolot_offline/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html/dom.dart' as dom;
import 'package:path_provider/path_provider.dart';
import 'package:eshkolot_offline/utils/constants.dart' as Constants;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:ui' as ui;


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
    return isHTML(s)
        ? FutureBuilder(
            future: initDirectory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SelectionArea(
                    focusNode: _focusNode,
                    child: HtmlWidget( addBreakAfterImgs(convertCustomAudioTags(widget.text)),
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
                fontSize: /*27.sp*/ 20.sp,
                fontWeight: FontWeight.w400,
                color: blackColorApp),
            textAlign: TextAlign.right,
          );
  }

  bool containsUnderlineStyle(dynamic element) {
    if (/*element.localName == 'span' &&*/
        element.attributes['style'] != null &&
            element.attributes['style']!
                .contains('text-decoration: underline')) {
      return true;
    }

    if (element.children.isEmpty) {
      return false;
    }

    return element.children.any((child) => containsUnderlineStyle(child));
  }

  Widget? displayWidgetByHtml(var element) {
    final srcAttribute = element.attributes['src'];
    final width = element.attributes['width'];
    final height = element.attributes['height'];
    final styleAttribute = element.attributes['style'];
    final fontWeightAttribute = element.attributes['font-weight'];
    final tagName = element.localName;

    if (element.localName == 'input' && widget.onInputWidgetRequested != null) {
      debugPrint('onInputWidgetRequested ${element.attributes['value']}');
      return widget.onInputWidgetRequested!(
          [element.attributes['value'], element.attributes['dirname']]);
    }
    if (element.localName == 'img') {
      debugPrint('srcAttribute $srcAttribute');
      if (srcAttribute != null) {
        final img = displayFile(srcAttribute, height, width, WidgetType.image);
        return InlineCustomWidget(
          child: displayFile(srcAttribute, height, width, WidgetType.image),
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
    if (element.localName == 'iframe') {
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
    // Check if any child element has an underline style
    bool isUnderlined = element.children.any((child) =>
        child.localName == 'span' &&
        child.attributes['style'] != null &&
        child.attributes['style']!.contains('text-decoration: underline'));
    if (element.localName == 'h6' ||
        (element.localName == 'span' && element.parent?.localName == 'h6'))
    {
     /* debugPrint('h6 text${element.text}');
      // Create a list to store the child widgets
      List<Widget> childrenWidgets = [];

      bool isUnderlined =
          element.children.any((child) => containsUnderlineStyle(child));

      for (var childElement in element.children) {
        // Check the type of child element and handle it accordingly
        childrenWidgets.add(displayWidgetByHtml(childElement) ?? Container());
      }
      childrenWidgets.add(Expanded(
        child: Text(element.text,
            style: TextStyle(
              fontSize: 27.sp,
              fontWeight: FontWeight.w800,
              decoration: isUnderlined ? TextDecoration.underline : null,
            )),
      ));
      // Return a widget that contains all the child widgets of <h6>
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: childrenWidgets,
      );
    }*/
        List<Widget> rowChildren = [];
    bool isUnderlined =
    element.children.any((child) => containsUnderlineStyle(child));

        // קודם נחפש direction ישיר ב־element עצמו
        String? directionStyle = element.attributes['style'];

        // אם אין direction, נבדוק אם להורה (h6) יש
        if ((directionStyle == null || !directionStyle.contains('direction')) &&
            element.parent != null) {
          directionStyle = element.parent!.attributes['style'];
        }

        // ברירת מחדל
        TextDirection textDirection = TextDirection.ltr;

    if (directionStyle != null && directionStyle.contains('rtl')) {
      textDirection = TextDirection.rtl;
    } else if (directionStyle != null && directionStyle.contains('ltr')) {
      textDirection = TextDirection.ltr;
    }

        for (var node in element.nodes) {
          if (node.nodeType == dom.Node.TEXT_NODE) {
            // Plain text between inputs
            rowChildren.add(Text(
              node.text?.trim() ?? '',
              textDirection: textDirection,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27.sp,
                fontWeight: FontWeight.w800,
                decoration: isUnderlined ? TextDecoration.underline : null,
              ),
            ));
          } else if (node is dom.Element) {
            final childWidget = displayWidgetByHtml(node);
            if (childWidget != null) {
              rowChildren.add(Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: childWidget,
              ));
            }
          }
        }
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5.w,
          runSpacing: 0,
          textDirection: textDirection,
          children: rowChildren,

        );
     }

    return null;
  }

 /* Widget? displayWidgetByHtml(var element) {
    final srcAttribute = element.attributes['src'];
    final width  = element.attributes['width'];
    final height = element.attributes['height'];
    final tagName = element.localName;

    if (tagName == 'input' && widget.onInputWidgetRequested != null) {
      return widget.onInputWidgetRequested!(
        [element.attributes['value'], element.attributes['dirname']],
      );
    }

    // === img: אינליין + ירידת שורה רק אחרי ===
    if (tagName == 'img') {
      if (srcAttribute != null) {
        final img = displayFile(srcAttribute, height, width, WidgetType.image);
        return InlineCustomWidget(
          child: _InlineImageThenNewline(img, */

  /*gap: 0*//*),
        );
      }
    }

    if (tagName == 'audio') {
      if (srcAttribute != null) {
        return InlineCustomWidget(
          child: displayFile(srcAttribute, height, width, WidgetType.audio),
        );
      }
      return null;
    }

    if (tagName == 'iframe') {
      if (srcAttribute != null) {
        if (srcAttribute.split('.').last == 'pdf') {
          return InlineCustomWidget(
            child: displayFile(srcAttribute, height, width, WidgetType.pdf),
          );
        }
        return InlineCustomWidget(
          child: displayFile(
            srcAttribute.split('.').last == 'mp4'
                ? srcAttribute
                : '${srcAttribute.split('?').first}.mp4',
            height,
            width,
            WidgetType.video,
            isLesson: false,
          ),
        );
      }
    }

    // h6 וכד' – כמו שהיה אצלך
    bool isUnderlined = element.children.any((child) =>
    child.attributes['style'] != null &&
        child.attributes['style']!.contains('text-decoration: underline'));

    if (tagName == 'h6') {
      final childrenWidgets = <Widget>[];
      final isUnderlinedLocal =
      element.children.any((child) => containsUnderlineStyle(child));

      for (var childElement in element.children) {
        childrenWidgets.add(displayWidgetByHtml(childElement) ?? Container());
      }
      childrenWidgets.add(
        Expanded(
          child: Text(
            element.text,
            style: TextStyle(
              fontSize: 27.sp,
              fontWeight: FontWeight.w800,
              decoration: isUnderlinedLocal ? TextDecoration.underline : null,
            ),
          ),
        ),
      );
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: childrenWidgets,
      );
    }

    return null;
  }*/

  Widget displayFile(
      String srcAttribute, var height, var width, WidgetType type,
      {isLesson = false}) {
    return FutureBuilder<File?>(
      // future: getCurrentFile(srcAttribute),
      future: getCurrentFile(srcAttribute.split('/').last, isLesson),
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
                return FutureBuilder<ui.Image>(
                  future: decodeImageFromFile(file),
                  builder: (context, imageSnapshot) {
                    if (imageSnapshot.connectionState == ConnectionState.done &&
                        imageSnapshot.hasData) {
                      final image = imageSnapshot.data!;
                      if(widget.isImageMatrix) {
                        final aspect = image.width / image.height;

                        final w = math.min(300.w, image.width.toDouble());
                        final h = w / aspect;
                        debugPrint('w: $w h: $h');
                        return SizedBox(
                          width: w,
                          height: h,
                          child: Image.file(
                            file,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                          ),
                        );
                      }

                      return SizedBox(
                        width:widget.isImageMatrix?140.w: image.width.toDouble(),
                        height:widget.isImageMatrix?140.w: image.height.toDouble(),
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
                'No ${type.name} $srcAttribute'); // If the file doesn't exist
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
      debugPrint('truuuuuuuuuu path $path');
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
    debugPrint('widthhhh  ${frame.image.width.toDouble()}');
    debugPrint('heightttt  ${frame.image.height.toDouble()}');
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
    final re = RegExp(r'(<img\b[^>]*>)', caseSensitive: false);
   return html.replaceAllMapped(re, (m) => '${m[1]}<br/>');
   // return html;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

enum WidgetType { image, audio, video, pdf }
