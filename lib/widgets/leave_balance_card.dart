import 'package:flutter/material.dart';

Widget leaveBalanceCard() {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("General"),
          Text("Paid"),
          Text("1"),
          Text("5"),
          Text("3"),
        ],
      ),
    ),
  );
}
