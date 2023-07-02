import 'package:flutter/material.dart';

class MyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        height: 90,
        decoration: const BoxDecoration(
          color: Color(0xFFC72C41),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Oh snap!",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const Text(
              'That Email Address is already in use! Please try with a different one.',
              style: const TextStyle(
                color: Colors.white,
              fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
          maxLines: 2,)
        ]));
  }
}
