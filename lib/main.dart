import 'package:attendance_app/pages/Home/apply_leaves.dart';
import 'package:attendance_app/pages/Home/cancel_leave.dart';
import 'package:attendance_app/pages/Home/clock.dart';
import 'package:attendance_app/pages/Home/employee.dart';
import 'package:attendance_app/pages/Home/home_page.dart';
import 'package:attendance_app/pages/Home/overview.dart';
import 'package:attendance_app/pages/Home/profile.dart';
import 'package:attendance_app/pages/Home/report_data.dart';
import 'package:attendance_app/pages/authentication/log_in.dart';
import 'package:attendance_app/pages/base/base_url.dart';
import 'package:flutter/material.dart';

import 'pages/authentication/initialize.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialRoute: Initializer.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        LogIn.routeName: (context) => const LogIn(),
        ClockPage.routeName: (context) => const ClockPage(),
        EmployeePage.routeName: (context) => const EmployeePage(),
        ReportData.routeName: (context) => const ReportData(),
        Profile.routeName: (context) => const Profile(),
        Overview.routeName: (context) => const Overview(),
        CancelLeave.routeName: (context) => const CancelLeave(),
        ApplyLeaves.routeName: (context) => const ApplyLeaves(),
        BaseUrl.routeName: (context) => const BaseUrl(),
        Initializer.routeName: (context) => const Initializer(),
      },
    );
  }
}
