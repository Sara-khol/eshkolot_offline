
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioWidget extends StatefulWidget {
  const AudioWidget({super.key, required this.path});
  final String path;

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  int maxDuration = 100;
  int currentPos = 0;
  String currentPostLabel = "00:00";
  bool isPlaying = false;
  bool audioPlayed = false;

  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      player.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxDuration = d.inMilliseconds;
        setState(() {});
      });

      player. onPositionChanged.listen((Duration p) {
        currentPos =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentPos).inHours;
        int sminutes = Duration(milliseconds: currentPos).inMinutes;
        int sseconds = Duration(milliseconds: currentPos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        String formattedRMinutes = rminutes.toString().padLeft(2, '0');
        String formattedRSeconds = rseconds.toString().padLeft(2, '0');

        // currentPostLabel = "$rhours:$rminutes:$rseconds";
        currentPostLabel = "$formattedRMinutes:$formattedRSeconds";
        setState(() {
          //refresh the UI
        });
      });
      player.onPlayerComplete.listen((event) {
        debugPrint('hhh');
        setState(() {
          isPlaying=false;
          audioPlayed=false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          // style: TextButton.styleFrom(
          //   alignment: Alignment.center,
          //   padding: EdgeInsets.only(left: 0, right: 0),
          //   textStyle: TextStyle(
          //       fontSize: 18.sp, fontWeight: FontWeight.w600),
          // ),
          onPressed: () async {
            if (!isPlaying && !audioPlayed) {
              player.play(DeviceFileSource(widget.path));
              isPlaying = true;
              audioPlayed = true;
            } else if (audioPlayed && !isPlaying) {
              await player.resume();
              isPlaying = true;
              audioPlayed = true;
            } else {
              await player.pause();
              isPlaying = false;
            }
          },

    child: Center(
      child: Icon(isPlaying  ? Icons.pause : Icons.play_arrow),
    ),
          /*   ElevatedButton.icon(
                onPressed: () async {
                  *//* int result =*//* await player.stop();
                  isPlaying = false;
                  audioPlayed = false;
                  currentPos = 0;
                },
                icon: Icon(Icons.stop),
                label: Text("Stop")),*/
        ),
        SizedBox(width: 10.w),
        Text(
          currentPostLabel,
          style: TextStyle(fontSize: 25.sp),
        ),
     Slider(
         value: currentPos.clamp(0, maxDuration).toDouble(),
         min: 0,
         max: double.parse(maxDuration.toString()),
         label: currentPostLabel,
         onChanged: (double value) async {
           int seekval = value.round();
           await player.seek(Duration(milliseconds: seekval));
         }
     ),

      /*  Wrap(
          spacing: 10,
          children: [*/

      //    ],
    //    )
      ],
    );
  }
}
