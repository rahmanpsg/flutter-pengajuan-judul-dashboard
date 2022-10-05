import 'package:flutter/material.dart';

import '../../app/themes/app_text.dart';

class CustomCircleNickname extends StatelessWidget {
  final String name;
  final Color? color;

  const CustomCircleNickname({
    super.key,
    required this.name,
    this.color,
  });

  String generateNickname() {
    final textArr = name.trim().split(' ');
    String text = textArr[0][0];

    if (textArr.length > 1) {
      text += textArr[1][0];
    }

    return text;
  }

  Color generateColor() {
    var hash = 0;
    for (var i = 0; i < name.length; i++) {
      hash = name.codeUnitAt(i) + ((hash << 5) - hash);
    }
    final finalHash = hash.abs() % (256 * 256 * 256);
    final red = ((finalHash & 0xFF0000) >> 16);
    final blue = ((finalHash & 0xFF00) >> 8);
    final green = ((finalHash & 0xFF));
    final color = Color.fromRGBO(red, green, blue, 1);
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color ?? generateColor(),
      child: Text(
        generateNickname(),
        style: regularTextStyle.copyWith(color: Colors.white),
      ),
    );
  }
}
