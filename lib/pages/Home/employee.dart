import 'package:analog_clock/analog_clock.dart';
import 'package:attendance_app/models/attendance.dart';
import 'package:attendance_app/models/finger_print.dart';
import 'package:attendance_app/models/location_data.dart';
import 'package:attendance_app/pages/Home/report.dart';
import 'package:attendance_app/pages/authentication/log_in.dart';
import 'package:attendance_app/service/attendence.dart';
import 'package:attendance_app/service/auth_service.dart';
import 'package:attendance_app/service/location_servise.dart';
import 'package:attendance_app/widgets/alerts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EmployeePage extends StatefulWidget {
  static const routeName = "/employee";
  final String? status;
  const EmployeePage({Key? key, this.status}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  int? index = 0;
  String? inColor = "0xffFF001F";
  String? outColor = "0xff145486";
  int? slideIndex = 0;
  DateTime date = DateTime.now();

  final AttendanceService attendanceService = AttendanceService();

  Future<bool?> getLocation(LocationData2? locationData2) async {
    locationData2 = await determinePosition();
    bool? isLocationGet;
    print("${locationData2?.lat}");
    if (locationData2?.isGetData == false) {
      warnDialog(context, "Please enable location access");
      isLocationGet = false;
    } else {
      isLocationGet = true;
    }
    return isLocationGet;
  }

  void setIndex(int? indexNumber) {
    setState(() {
      index = indexNumber;
    });
  }

  void setSlideIndex(int? index) {
    setState(() {
      slideIndex = index;
    });
  }

  String getTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hms().format(now);
    return formattedTime;
  }

  String getDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd").format(now);
    String finalDate = formattedDate;
    return finalDate;
  }

  String? dateTime = DateFormat("EEE, MMM d").format(DateTime.now());

  // Attendance? updateData(){}
  @override
  void initState() {
    determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hi!, ${userData?.username}",
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xff145486)),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    SizedBox(
                      height: size.width * 0.6,
                      width: size.width * 0.6,
                      child: AnalogClock(
                        tickColor: Colors.grey,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5.0,
                                  offset: Offset(10, 10))
                            ],
                            // border: Border.all(width: 2.0, color: Colors.black),
                            color: Color(0xffF0F5F8),
                            shape: BoxShape.circle),
                        width: 150.0,
                        isLive: true,
                        hourHandColor: Colors.black,
                        minuteHandColor: Colors.pink,
                        showSecondHand: false,
                        numberColor: Colors.black87,
                        showNumbers: true,
                        textScaleFactor: 1.4,
                        showTicks: true,
                        showDigitalClock: false,
                        datetime: DateTime.now(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "$dateTime",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff145486)),
                    ),
                    const SizedBox(height: 10),
                    DigitalClock(
                      areaDecoration: const BoxDecoration(color: Colors.white),
                      areaWidth: 100,
                      showSecondsDigit: false,
                      hourMinuteDigitTextStyle: const TextStyle(
                        color: Color(0xff145486),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Mark Your Attendance",
                          style: TextStyle(fontSize: 17, color: Colors.grey[700]
                              // Color(0xff9A9D9F)
                              ),
                        ),
                        const SizedBox(width: 20),
                        SlidableButton(
                          width: MediaQuery.of(context).size.width / 4,
                          buttonWidth: 35.0,
                          color: const Color(0xffF0F5F8),
                          buttonColor: slideIndex == 1
                              ? const Color(0xff145486)
                              : const Color(0xffFF001F),
                          dismissible: false,
                          label: const Center(child: Text('')),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(' Out',
                                    style: TextStyle(color: Colors.red)),
                                Text('In  ',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                          onChanged: (position) async {
                            LocationData2? locationData2 = LocationData2();
                            bool? val = await getLocation(locationData2);
                            setState(() {
                              if (position == SlidableButtonPosition.right) {
                                setSlideIndex(1);
                                if (val == true) {
                                  LocationData? locationData = LocationData();

                                  Attendance? attendance = Attendance();
                                  FingerPrint? fPrint = FingerPrint();
                                  locationData.lat = locationData2.lat;
                                  locationData.long = locationData2.long;
                                  fPrint.direction = "in";
                                  fPrint.location = locationData;
                                  fPrint.time = getTime();
                                  attendance.date = getDate();
                                  attendance.empNo = userData?.empNo;
                                  attendance.fPrint = fPrint;

                                  attendanceService
                                      .attendance(attendance, userToken)
                                      .then((value) {
                                    if (value?.statusCode == "200") {
                                      successDialog(context, value?.messages);
                                    } else {
                                      warnDialog(context, value!.messages!);
                                    }
                                  });
                                }
                                // result = 'Button is on the right';
                              } else {
                                LocationData2? locationData2 = LocationData2();
                                getLocation(locationData2);
                                setSlideIndex(0);

                                if (val == true) {
                                  LocationData? locationData = LocationData();

                                  Attendance? attendance = Attendance();
                                  FingerPrint? fPrint = FingerPrint();
                                  locationData.lat = locationData2.lat;
                                  locationData.long = locationData2.long;
                                  fPrint.direction = "out";
                                  fPrint.location = locationData;
                                  fPrint.time = getTime();
                                  attendance.date = getDate();
                                  attendance.empNo = userData?.empNo;
                                  attendance.fPrint = fPrint;
                                  print(locationData.long);
                                  attendanceService
                                      .attendance(attendance, userToken)
                                      .then((value) {
                                    if (value?.statusCode == "200") {
                                      successDialog(context, value?.messages);
                                    } else {
                                      warnDialog(context, value!.messages!);
                                    }
                                  });
                                }
                                // result = 'Button is on the left';
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xff10BADF)),
                          onPressed: () async {
                            await logOut();
                            Navigator.of(context)
                                .pushReplacementNamed(LogIn.routeName);
                            // loadingOn();
                            // _formKey.currentState?.save();
                            // usernameValidation(username);
                            // passwordValidation(password);
                            // if (usernameValidation(username)! &&
                            //     passwordValidation(password)!) {
                            //   await logIn(username!, password!).then((value) {
                            //     loadingOff();
                            //     if (value == "ok") {
                            //       Navigator.of(context).pushNamed(HomePage.routeName);
                            //     } else {
                            //       displayDialog(context, value.toString());
                            //     }
                            //   });
                            // }
                          },
                          child: const Text("Log Out")),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
