import 'package:flutter/material.dart';

Widget smallButton(Size size, String title, Color color,
    {required void Function() onClick}) {
  return GestureDetector(
    child: Card(
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: SizedBox(
        height: 25,
        width: size.width * 0.2,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
    onTap: onClick,
  );
}
// Color(0xffFF001F)
