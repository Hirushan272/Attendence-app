import 'package:attendance_app/service/leave.dart';
import 'package:flutter/material.dart';

Widget leaveBalanceCard(int index) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(Leave.empSummeryList[index].leaveType.toString()),
          Text(isPaid(Leave.empSummeryList[index].isPaid!).toString()),
          Text(Leave.empSummeryList[index].leaveBalance.toString()),
          Text(Leave.empSummeryList[index].usedLeaves.toString()),
          Text(Leave.empSummeryList[index].rejectedLeaves.toString()),
        ],
      ),
    ),
  );
}

String isPaid(int num) {
  String? word;
  if (num == 1) {
    word = "Paid";
  } else {
    word = "Not Paid";
  }
  return word;
}
