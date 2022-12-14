import 'package:firebase_app/utils/diamentions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color? color; // the color of the text
  final String text; // content
  double size; // font size
  TextOverflow overFlow; // the overflown text indicator

  BigText({
    Key? key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 0, // default size is zero, pass here
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      maxLines: 1,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto',
          fontSize: size == 0 ? Diamensions.font20 : size),
    );
  }
}
