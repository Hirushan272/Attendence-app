import 'package:attendance_app/constant/constant.dart';
import 'package:attendance_app/pages/Home/profile.dart';
import 'package:attendance_app/widgets/Item_card.dart';
import 'package:attendance_app/widgets/leave_balance_card.dart';
import 'package:flutter/material.dart';

import 'apply_leaves.dart';
import 'cancel_leave.dart';
import 'clock.dart';

class Overview extends StatefulWidget {
  static const routeName = "/overview";
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
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
                  // Navigator.of(context).pushNamed(Overview.routeName);
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
                  Navigator.of(context).pushNamed(CancelLeave.routeName);
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: size.width,
              child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    child: const Text(
                      "Attendance summery of current month",
                      style: TextStyle(fontSize: 18, color: Color(0xff145486)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      itemCard(
                          size, const Color(0xffE9F5FF), "Leave minute", "10"),
                      const SizedBox(width: 20),
                      itemCard(
                          size, const Color(0xffE9F5FF), "Leave minute", "10"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      itemCard(
                          size, const Color(0xffE9F5FF), "Leave minute", "10"),
                      const SizedBox(width: 20),
                      itemCard(
                          size, const Color(0xffE9F5FF), "Leave minute", "10"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width,
                    child: const Text(
                      "Leave balance",
                      style: TextStyle(fontSize: 18, color: Color(0xff145486)),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text("Leave type", style: smallTextStyle),
                          Text("Paid/Not paid", style: smallTextStyle),
                          Text("Leave balance", style: smallTextStyle),
                          Text("Used leaves", style: smallTextStyle),
                          Text("Rejected leaves", style: smallTextStyle),
                        ],
                      ),
                    ),
                  ),
                  leaveBalanceCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
