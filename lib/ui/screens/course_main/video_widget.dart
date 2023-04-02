import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';


class VideoWidget extends StatelessWidget
{
  late var player;
  final int vimoeId;

   VideoWidget({super.key, required this.vimoeId});
  @override
  Widget build(BuildContext context) {
    videoInit();
    return  Video(
      player: player,
      height: 515.h,
      width: 914.w,
      scale: 1.0, // default
      showControls: true, // default
    );
  }

  videoInit() async
  {
    DartVLC.initialize();
     player = Player(id: 69420/*,  videoDimensions: const VideoDimensions(640, 360)*/);
    var dir =await getApplicationSupportDirectory();//C:\Users\USER\AppData\Roaming\com.example\eshkolot_offline
    final myFile = Media.file(File('${dir.path}/${vimoeId}.mp4'));
    player.open(
      myFile,
      autoStart: false, // default
    );
  }
}