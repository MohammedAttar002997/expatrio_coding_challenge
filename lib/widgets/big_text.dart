import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color color;
  final String text;
  double size;
  TextOverflow textOverflow;
  FontWeight fontWeight;

  BigText({
    super.key,
    this.color = const Color(0xFF332d2d),
    required this.text,
    this.size = 0,
    this.fontWeight=FontWeight.w400,
    this.textOverflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: textOverflow,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: fontWeight,
        fontSize: size == 0 ? Dimensions.font20 : size,
        color: color,
      ),
    );
  }
}
