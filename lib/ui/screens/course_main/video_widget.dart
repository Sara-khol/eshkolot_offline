import 'dart:io';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eshkolot_offline/utils/constants.dart' as constants;

import '../../../utils/common_funcs.dart';

class VideoWidget extends StatefulWidget {
  final String? videoId;
  final int fileId;
  final double width;
  final double height;
  final bool isLesson;

  const VideoWidget(
      {super.key,
      required this.videoId,
      required this.fileId,
      this.isLesson = false,
      this.width = 0,
      this.height = 0});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget>
    with AutomaticKeepAliveClientMixin {
  bool videoExists = false;

  //Player? player;

  bool intendedRebuild = false;

  // // Create a [Player] to control playback.
  // late final player = Player();
  // // Create a [VideoController] to handle video output from [Player].
  // late final controller = VideoController(player);
  late Player player;
  late VideoController controller;
  late Future myFuture;

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
    myFuture = videoInit();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant VideoWidget oldWidget) {
    if(oldWidget.videoId!=widget.videoId)
      {
        if(videoExists) {
          player.dispose();
        }
        myFuture = videoInit();
      }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: myFuture,
      builder: (context, s) {
        if (s.hasData) {
          return
               videoExists
                  ? SizedBox(
                      height: widget.height == 0 || widget.height > 515
                          ? 515.h
                          : widget.height,
                      width: widget.width == 0 || widget.width > 914
                          ? 914.w
                          : widget.width,
                      child: Video(controller: controller),
                    )
                  : Container(
                      height: widget.height == 0 ? 515.h : widget.height,
                      width: widget.width == 0 ? 914.w : widget.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38)),
                      child: Center(
                        child: Text(/*'הוידאו לא קיים\nעקב בעיה של חסימה'*/'הוידאו לא קיים',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25.sp)),
                      ),
                    );
        }
        return const CircularProgressIndicator();
      },
    );
  }

 Future<bool>  videoInit() async {
    if (widget.videoId != null) {
      //var dir = await getApplicationSupportDirectory(); //C:\Users\USER\AppData\Roaming\com.example\eshkolot_offline
      Directory dir = await CommonFuncs().getEshkolotWorkingDirectory();
      String path =
          '${dir.path}/${widget.isLesson ? constants.lessonPath : constants.quizPath}/${widget.fileId}/${widget.videoId}.mp4';
      debugPrint('path $path');
      File file = File(path);
      videoExists = await file.exists();
      debugPrint(' videoInit videoId ${widget.videoId}');

      if (videoExists) {
        player = Player();
        controller = VideoController(player);
        // final myFile = Media.file(file);
        // player.open(myFile, autoStart: false);
        player.open(Media(path), play: false);
      }
      debugPrint('videoExists  $videoExists');
      setState(() {});
    } else {
      videoExists = false;
      // setState(() {});
    }
    return videoExists;
  }

  @override
  void dispose() {
    if(videoExists) {
      player.dispose();
    }
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
