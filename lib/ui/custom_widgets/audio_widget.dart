
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioWidget extends StatefulWidget {
  const AudioWidget({super.key});

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

        currentPostLabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Text(
              currentPostLabel,
              style: TextStyle(fontSize: 25.sp),
            ),
            Container(
                child: Slider(
                    value: double.parse(currentPos.toString()),
                    min: 0,
                    max: double.parse(maxDuration.toString()),
                    divisions: maxDuration,
                    label: currentPostLabel,
                    onChanged: (double value) async {
                      int seekval = value.round();
                      await player.seek(Duration(milliseconds: seekval));
                    })),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton.icon(
                    onPressed: () async {
                      if (!isPlaying && !audioPlayed) {
                        player.play(DeviceFileSource('C:/try1.mp3'));
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
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    label: Text(isPlaying ? "Pause" : "Play")),
                ElevatedButton.icon(
                    onPressed: () async {
                      /* int result =*/ await player.stop();
                      isPlaying = false;
                      audioPlayed = false;
                      currentPos = 0;
                    },
                    icon: Icon(Icons.stop),
                    label: Text("Stop")),
              ],
            )
          ],
        ));
  }
}
