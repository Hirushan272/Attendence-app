import 'package:attendance_app/constant/constant.dart';
import 'package:attendance_app/pages/Home/clock.dart';
import 'package:attendance_app/widgets/alerts.dart';
import 'package:attendance_app/widgets/cancel_leave_card.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'apply_leaves.dart';
import 'overview.dart';
import 'profile.dart';

class CancelLeave extends StatefulWidget {
  static const routeName = "/cancel-leaves";
  const CancelLeave({Key? key}) : super(key: key);

  @override
  State<CancelLeave> createState() => _CancelLeaveState();
}

class _CancelLeaveState extends State<CancelLeave> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                hoverColor: Colors.white,
                trailing: const Icon(Icons.menu),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text("Home"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(ClockPage.routeName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle_outlined),
                title: const Text("Profile"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Profile.routeName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.list_alt_rounded),
                title: const Text("Overview"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Overview.routeName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.event_available_outlined),
                title: const Text("Apply leaves"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(ApplyLeaves.routeName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.event_busy_outlined),
                title: const Text("Cancel leaves"),
                onTap: () {
                  Navigator.of(context).pop();
                  // Navigator.of(context).pushNamed(CancelLeave.routeName);
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Cancel Leaves",
                style: giantTextStyle,
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  height: 30,
                  width: size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("Leave type", style: smallTextStyle),
                      Text("Paid/Not paid", style: smallTextStyle),
                      Text("Leave balance", style: smallTextStyle),
                      Text("Used leaves", style: smallTextStyle),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  cancelLeaveCard(size),
                  GestureDetector(
                    child: Card(
                      color: const Color(0xffFF001F),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: SizedBox(
                        height: 25,
                        width: size.width * 0.2,
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      cancelLeaveAlert(
                          context, "Do you want to cancel the leave?", size);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
