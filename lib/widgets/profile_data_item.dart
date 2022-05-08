import 'package:flutter/material.dart';

Widget profileItem(String first, String second) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, right: 30),
    child: Row(
      children: [
        Expanded(
            flex: 2, child: Text(first, style: const TextStyle(fontSize: 18))),
        Expanded(
            flex: 3, child: Text(second, style: const TextStyle(fontSize: 18))),
      ],
    ),
  );
}
