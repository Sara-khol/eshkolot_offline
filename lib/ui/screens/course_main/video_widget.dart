import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eshkolot_offline/utils/constants.dart' as Constants;

import 'main_page_child.dart';

class VideoWidget extends StatefulWidget {
  final String? vimoeId;

  const VideoWidget({super.key, required this.vimoeId});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget>
    with AutomaticKeepAliveClientMixin {
  bool? videoExists = true;
  Player? player;

  bool intendedRebuild = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero, () async {
    //   // Sentry.captureMessage('initState VideoWidget');
    //   await videoInit();
    //   //todo this causes for a jump on the video when going through lessons
    //   //todo if there can not be videos that are not loaded like now that there are block links
    //   //todo so remove...
    //   setState(() {});
    // });
    videoInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return videoExists != null && player != null
        ? videoExists!
            ? Video(
                player: player,
                height: 515.h,
                width: 914.w,
                scale: 1.0,
                // default
                showControls: true,
              )
            : Container(
                height: 515.h,
                width: 914.w,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black38)),
                child: Center(
                  child: Text('הוידאו לא קיים\nעקב בעיה של חסימה',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 25.sp)),
                ),
              )
        : const CircularProgressIndicator();
  }

  videoInit() async {
    if (widget.vimoeId != null) {
      var dir =
          await getApplicationSupportDirectory(); //C:\Users\USER\AppData\Roaming\com.example\eshkolot_offline
      File file = File(
          '${dir.path}/${Constants.lessonPath}/${MainPageChild.of(context)?.widget.course.id}/${widget.vimoeId}.mp4');
      videoExists = await file.exists();

      player = Player(
          id: int.parse(widget.vimoeId!),
          videoDimensions: const VideoDimensions(640, 360));
      debugPrint(' videoInit vimoeId ${widget.vimoeId}');

      if (videoExists!) {
        final myFile = Media.file(file);
        player!.open(myFile, autoStart: false);
      }
      debugPrint('videoExists  ${videoExists}');
      setState(() {});
    } else {
      videoExists = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    if (player != null) {
      player!.dispose();
      player!.stop();
    }
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
