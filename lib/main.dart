import 'package:attendance_app/pages/Home/clock.dart';
import 'package:attendance_app/pages/Home/employee.dart';
import 'package:attendance_app/pages/Home/home_page.dart';
import 'package:attendance_app/pages/Home/report_data.dart';
import 'package:attendance_app/pages/authentication/log_in.dart';
import 'package:flutter/material.dart';

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
      initialRoute: ClockPage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        LogIn.routeName: (context) => const LogIn(),
        ClockPage.routeName: (context) => const ClockPage(),
        EmployeePage.routeName: (context) => const EmployeePage(),
        ReportData.routeName: (context) => const ReportData(),
      },
    );
  }
}
