import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class TitleBarWidget extends StatefulWidget
{
  @override
  State<TitleBarWidget> createState() => _TitleBarWidgetState();
}

class _TitleBarWidgetState extends State<TitleBarWidget> {

  final buttonColors = WindowButtonColors(
    iconNormal: Colors.white,
    mouseOver: Colors.grey.withOpacity(0.3),
    mouseDown: Colors.grey.withOpacity(0.6),
    // iconMouseOver: const Color(0xFF805306),
    // iconMouseDown: const Color(0xFFFFD500)
  );

  final closeButtonColors = WindowButtonColors(
      mouseOver: Colors.red,
      mouseDown: Colors.red.withOpacity(0.6),
      iconNormal: Colors.white,
      iconMouseOver: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 29.h,
      color: Color(0xff393535),
      child: WindowTitleBarBox(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: MoveWindow()),
            MinimizeWindowButton(colors: buttonColors),
            appWindow.isMaximized
                ? RestoreWindowButton(
              colors: buttonColors,
              onPressed: maximizeOrRestore,
            )
                : MaximizeWindowButton(
              colors: buttonColors,
              onPressed: maximizeOrRestore,
            ),
            CloseWindowButton(colors: closeButtonColors),
          ],
        ),
      ),
    );
  }

  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }
}