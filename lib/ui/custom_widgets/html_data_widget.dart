import 'dart:io';

import 'package:eshkolot_offline/ui/custom_widgets/audio_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eshkolot_offline/utils/constants.dart' as Constants;

class HtmlDataWidget extends StatefulWidget {
  HtmlDataWidget(this.text, {super.key, required this.quizId});

  final String text;
  late final int quizId;

  @override
  State<HtmlDataWidget> createState() => _HtmlDataWidgetState();
}

class _HtmlDataWidgetState extends State<HtmlDataWidget> {
  Directory? appSupportDir;

  // @override
  // void initState() {
  //   getApplicationSupportDirectory().then((directory) {
  //     setState(() {
  //       debugPrint('getApplicationSupportDirectory');
  //       appSupportDir = directory;
  //     });
  //   });
  //   super.initState();
  // }

  initDirectory() async {
    appSupportDir = await getApplicationSupportDirectory();
    return appSupportDir;
  }

  @override
  Widget build(BuildContext context) {
    // String s= convertCustomAudioTags(widget.text);
    return FutureBuilder(

      future: initDirectory(),
      builder:  (context,snapshot){
      if (snapshot.hasData) {
        return
          HtmlWidget(convertCustomAudioTags(widget.text),
              textStyle: TextStyle(fontSize: 27.sp),

              //textStyle: TextStyle(fontSize: ScreenUtil().setSp(fontSize.toDouble())),
              customWidgetBuilder: (element) {
                if (element.localName == 'img') {
                  final srcAttribute = element.attributes['src'];
                  final width = element.attributes['width'] ?? 100;
                  final height = element.attributes['height'] ?? 100;
                  debugPrint('width $width height $height');
                  if (srcAttribute != null) {
                    return FutureBuilder<File?>(
                      future: displayFile(srcAttribute),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Show a loading indicator
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot
                                  .error}'); // Show an error message
                        } else {
                          final file = snapshot.data;
                          if (file != null) {
                            return Image.file(
                              file,
                              fit: BoxFit.contain,
                              height: int.parse(width.toString()) * 2.w,
                              width: int.parse(height.toString()) * 2.h,
                            ); // Display the image from the file
                          } else {
                            return Text(
                                'No image'); // If the file doesn't exist
                          }
                        }
                      },
                    );
                  }
                }
                if (element.localName == 'audio') {
                  final srcAttribute = element.attributes['src'];
                  final width = element.attributes['width'] ?? 100;
                  final height = element.attributes['height'] ?? 100;
                  debugPrint('width $width height $height');
                  if (srcAttribute != null) {
                    return FutureBuilder<File?>(
                      future: displayFile(srcAttribute),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Show a loading indicator
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot
                                  .error}'); // Show an error message
                        } else {
                          final file = snapshot.data;
                          if (file != null) {
                            return AudioWidget(
                              path: file.path,
                              /* file,
                        fit: BoxFit.contain,
                        height: int.parse(width.toString()).w,
                        width: int.parse(height.toString()).h,*/
                            ); // Display the image from the file
                          } else {
                            return const Text(
                                'No Audio'); // If the file doesn't exist
                          }
                        }
                      },
                    );
                  }
                  // else if (element.localName == 'br') {
                  //   return SizedBox(height: 0); // Hide the line break
                  // }
                  return null;
                }
                // todo change to movie
                if (element.localName == 'iframe') {
                  final srcAttribute = element.attributes['src'];
                  final width = element.attributes['width'] ?? 100;
                  final height = element.attributes['height'] ?? 100;
                  debugPrint('width $width height $height');
                  if (srcAttribute != null) {
                    return FutureBuilder<File?>(
                      future: displayFile(srcAttribute),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Show a loading indicator
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot
                                  .error}'); // Show an error message
                        } else {
                          final file = snapshot.data;
                          if (file != null) {
                            return Image.file(
                              file,
                              fit: BoxFit.contain,
                              height: int.parse(width.toString()) * 2.w,
                              width: int.parse(height.toString()) * 2.h,
                            ); // Display the image from the file
                          } else {
                            return Text(
                                'No image'); // If the file doesn't exist
                          }
                        }
                      },
                    );
                  }
                }
                return null;
              });
      }
      return const CircularProgressIndicator();
    });
  }

  Future<File?> displayFile(String srcAttribute) async {
    if (appSupportDir == null) {
      return null;
    }
    //todo remove
    //srcAttribute = '420-ג.jpg';
    String path =
        '${appSupportDir!.path}/${Constants.quizPath}/${widget.quizId}/$srcAttribute';
    File file = File(path);
    //todo remove
    //File  file= File('${dir.path}/${Constants.quizPath}/118990/$srcAttribute');

   // debugPrint('path $path');
    if (await file.exists()) {
      debugPrint('truuuuuuuuuu path $path');
      return file;
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
}
