import 'package:attendance_app/constant/constant.dart';
import 'package:attendance_app/models/leave.dart';
import 'package:attendance_app/pages/Home/cancel_leave.dart';
import 'package:attendance_app/service/leave.dart';
import 'package:attendance_app/service/location_servise.dart';
import 'package:attendance_app/widgets/small_button.dart';
import 'package:flutter/material.dart';

displayDialog(BuildContext context, String message) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 240,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('WARNING',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.orange, size: 60),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    child: const Text('CLOSE'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      });
}

warnDialog(BuildContext context, String message) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 240,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('WARNING',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.orange, size: 60),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('CLOSE'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      });
}

successDialog(BuildContext context, String? message) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (newContext) {
        return AlertDialog(
          content: SizedBox(
            height: 240,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('SUCCESS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 10),
                Icon(Icons.check_circle_outline_rounded,
                    color: Colors.green[800], size: 60),
                const SizedBox(height: 10),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    child: const Text('CLOSE'),
                    onPressed: () {
                      Navigator.of(newContext).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      });
}

cancelLeaveAlert(BuildContext context, String message, Size size, Leave leave,
    int index, Function updateL) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: size.height * 0.24,
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Text('WARNING',
                //     style:
                //         TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Icon(Icons.cancel_outlined, color: Colors.red, size: 60),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    smallButton(size, "Yes", blueColor, onClick: () async {
                      String? val =
                          await leave.cancelLeaves(Leave.empLeaveList[index]);
                      updateL(Leave.empLeaveList[index]);
                      if (val == "ok") {
                        successDialog(context, "Cancelled");
                        Navigator.of(context).pop();
                      }

                      Navigator.of(context).pop();
                    }),
                    smallButton(size, "No", redColor, onClick: () {
                      Navigator.of(context).pop();
                    }),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
