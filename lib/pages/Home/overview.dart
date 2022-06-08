import 'package:attendance_app/constant/constant.dart';
import 'package:attendance_app/pages/Home/profile.dart';
import 'package:attendance_app/service/auth_service.dart';
import 'package:attendance_app/service/leave.dart';
import 'package:attendance_app/service/report.dart';
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
  bool? isLoading = false;
  final Leave leave = Leave();
  void loadingOn() {
    setState(() {
      isLoading = true;
    });
  }

  void loadingOff() {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getLeaveData() async {
    DateTime now = DateTime.now();
    loadingOn();
    await leave.getEmpDataCurrantMonth();
    await getReport(userData?.empNo, now.month, now.year);
    print(Leave.empSummeryList.length);
    loadingOff();
  }

  @override
  void initState() {
    getLeaveData();
    super.initState();
  }

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
              // height: size.height * 0.8,
              child: isLoading == true
                  ? const Center(
                      heightFactor: 15,
                      child: CircularProgressIndicator(),
                    )
                  // : Leave.empSummeryList.isEmpty
                  //     ? Column(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           SizedBox(
                  //             width: size.width,
                  //             child: const Text(
                  //               "Attendance summery of current month",
                  //               style: TextStyle(
                  //                   fontSize: 18, color: Color(0xff145486)),
                  //             ),
                  //           ),
                  //           const Center(
                  //             heightFactor: 30,
                  //             child: Text("No Employee Data"),
                  //           ),
                  //         ],
                  //       )
                  : Column(
                      children: [
                        SizedBox(
                          width: size.width,
                          child: const Text(
                            "Attendance summery of current month",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff145486)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            itemCard(size, const Color(0xffFBFBFB), "Work Days",
                                mtr.workMinutesMonth.toString()),
                            const SizedBox(width: 20),
                            itemCard(size, const Color(0xffE9F5FF),
                                "Leave Days", mtr.leaveMinutesMonth.toString()),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            itemCard(size, const Color(0xffE9F5FF), "OT Hours",
                                mtr.singleOtMinutes.toString()),
                            const SizedBox(width: 20),
                            itemCard(size, const Color(0xffFBFBFB), "Late Days",
                                "0"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: size.width,
                          child: const Text(
                            "Leave balance",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff145486)),
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
                        SizedBox(
                            height: size.height * 0.3,
                            child: ListView.builder(
                              itemCount: Leave.empSummeryList.length,
                              itemBuilder: (context, index) =>
                                  leaveBalanceCard(index),
                            )
                            //  ,
                            )
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
