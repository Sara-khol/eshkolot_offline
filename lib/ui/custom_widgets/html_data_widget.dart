import 'dart:io';

import 'package:eshkolot_offline/ui/custom_widgets/audio_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/video_widget.dart';
import 'package:eshkolot_offline/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eshkolot_offline/utils/constants.dart' as Constants;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../utils/common_funcs.dart';
import '../screens/course_main/main_page_child.dart';

typedef WidgetCallback = Widget Function(List<String?> s);

class HtmlDataWidget extends StatefulWidget {
  const HtmlDataWidget(this.text,
      {super.key, required this.quizId, this.onInputWidgetRequested,  this.textStyle});

  final String text;
  final int quizId;
  final TextStyle? textStyle;
  final WidgetCallback? onInputWidgetRequested;

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
    // String s= convertCustomAudioTags(widget.text);
    return isHTML(widget.text)
        ? FutureBuilder(
            future: initDirectory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SelectionArea(
                    focusNode: _focusNode,
                    child: HtmlWidget(convertCustomAudioTags(widget.text),
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
        /*child.localName == 'span' &&*/
        child.attributes['style'] != null &&
        child.attributes['style']!.contains('text-decoration: underline'));
    if (element.localName == 'h6') {
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
    }

    return null;
  }

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
                return Image.file(
                  file,
                  fit: BoxFit.contain,
                  // height: height != null
                  //     ? int.parse(height.toString()) * 2.w
                  //     : null,
                  // width:
                  //     width != null ? int.parse(width.toString()) * 2.h : null,
                );
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
          '${appSupportDir!.path}/${Constants.lessonPath}/${MainPageChild.of(context)!.widget.course.id}/$srcAttribute';
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

  String convertCustomAudioTags(String htmlContent) {
    final RegExp customAudioRegExp = RegExp(
        r'\[audio\s+mp3="([^"]+)"\]\[\/audio\]',
        caseSensitive: false,
        multiLine: false);

    return htmlContent.replaceAllMapped(customAudioRegExp, (match) {
      final audioUrl = match.group(1);
      return '<audio src="$audioUrl" <!--controls-->></audio>';
    });
  }

  bool isHTML(String str) {
    final RegExp htmlRegExp =
        RegExp('<[^>]*>', multiLine: true, caseSensitive: false);
    return htmlRegExp.hasMatch(str);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

enum WidgetType { image, audio, video, pdf }
