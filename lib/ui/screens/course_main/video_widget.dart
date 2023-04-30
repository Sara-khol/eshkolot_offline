import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';


class VideoWidget extends StatelessWidget
{
  final Player player;
  final int vimoeId;

  const VideoWidget({super.key, required this.vimoeId,required this.player});

  @override
  Widget build(BuildContext context) {
    videoInit();
    return  Video(
      player: player,
      height: 515.h,
      width: 914.w,
      scale: 1.0, // default
      showControls: true,

    );
  }

  videoInit() async
  {
    var dir =await getApplicationSupportDirectory();//C:\Users\USER\AppData\Roaming\com.example\eshkolot_offline
    final myFile = Media.file(File('${dir.path}/$vimoeId.mp4'));
    player.open(
      myFile,
      autoStart: false// default
    );
  }
}