import 'package:flutter/material.dart';

Widget itemCard(Size size, Color color, String type, String amount) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    color: color,
    child: SizedBox(
      height: size.width * 0.35,
      width: size.width * 0.35,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: size.width * 0.06),
            Text(type,
                style: const TextStyle(fontSize: 20, color: Color(0xff145486))),
            SizedBox(height: size.width * 0.03),
            Text(amount,
                style: const TextStyle(fontSize: 50, color: Color(0xff145486))),
          ],
        ),
      ),
    ),
  );
}
