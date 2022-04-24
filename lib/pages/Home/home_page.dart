import 'package:analog_clock/analog_clock.dart';
import 'package:attendance_app/models/attendance.dart';
import 'package:attendance_app/models/finger_print.dart';
import 'package:attendance_app/models/location_data.dart';
import 'package:attendance_app/service/attendence.dart';
import 'package:attendance_app/service/auth_service.dart';
import 'package:attendance_app/service/location_servise.dart';
import 'package:attendance_app/widgets/alerts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationData? locationData = LocationData();
  LocationData2? locationData2 = LocationData2();
  Attendance? attendance = Attendance();
  FingerPrint? fPrint = FingerPrint();
  final AttendanceService attendanceService = AttendanceService();

  String getTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hms().format(now);
    return formattedTime;
  }

  String getDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Container(
        width: size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () async {
                    locationData2 = await determinePosition();
                    if (locationData2?.isGetData == false) {
                      warnDialog(context, "Please enable location access");
                    } else {
                      locationData?.lat = locationData2?.lat;
                      locationData?.long = locationData2?.long;
                      fPrint?.direction = "in";
                      fPrint?.location = locationData;
                      fPrint?.time = getTime();
                      attendance?.date = getDate();
                      attendance?.empNo = "emp1";
                      attendance?.fPrint = fPrint;

                      attendanceService
                          .attendance(attendance!, "token")
                          .then((value) {
                        if (value?.statusCode == "200") {}
                        // warnDialog(context, value!);
                      });
                    }
                  },
                  child: const Text(
                    "In",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () async {
                    locationData2 = await determinePosition();
                    if (locationData2?.isGetData == false) {
                      warnDialog(context, "Please enable location access");
                    } else {
                      locationData?.lat = locationData2?.lat;
                      locationData?.long = locationData2?.long;
                      fPrint?.direction = "out";
                      fPrint?.location = locationData;
                      fPrint?.time = getTime();
                      attendance?.date = getDate();
                      attendance?.empNo = userData?.empNo;
                      attendance?.fPrint = fPrint;
                    }
                  },
                  child: const Text(
                    "Out",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
