import 'package:attendance_app/constant/constant.dart';
import 'package:flutter/material.dart';

Widget cancelLeaveCard(Size size) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: SizedBox(
      height: 30,
      width: size.width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text("General", style: normalTextStyle),
          Text("23/02/2022", style: normalTextStyle),
          Text("23/02/2022", style: normalTextStyle),
          Text("5", style: normalTextStyle),
        ],
      ),
    ),
  );
}
