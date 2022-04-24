import 'package:attendance_app/constant/constant.dart';
import 'package:attendance_app/models/report.dart';
import 'package:attendance_app/pages/Home/report_data.dart';
import 'package:attendance_app/service/report.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:multiselect/multiselect.dart';

import 'home_page.dart';

class ReportPage extends StatefulWidget {
  static const routeName = "/report";
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final formKey = GlobalKey<FormState>();
  bool? isEmployeeIdNull = false;
  bool? isEmployeeIdValidated = false;

  bool? isYearNull = false;
  bool? isYearValidated = false;

  bool? isMonthNull = false;
  bool? isMonthValidated = false;

  String? employeeId;
  String? year;
  String? month;

  bool? employeeIdValidation(String? employeeId) {
    if (employeeId == "null" || employeeId == null || employeeId == "") {
      setState(() {
        isEmployeeIdNull = true;
        isEmployeeIdValidated = false;
      });
    } else {
      setState(() {
        isEmployeeIdNull = false;
        isEmployeeIdValidated = true;
      });
    }

    return isEmployeeIdValidated;
  }

  bool? yearValidation(String? year) {
    if (year == "null" || year == null || year == '') {
      setState(() {
        isYearNull = true;
        isYearValidated = false;
      });
    } else {
      setState(() {
        isYearNull = false;
        isYearValidated = true;
      });
    }

    return isYearValidated;
  }

  bool? monthValidation(String? month) {
    if (month == "null" || month == null || month == '') {
      setState(() {
        isMonthNull = true;
        isMonthValidated = false;
      });
    } else {
      setState(() {
        isMonthNull = false;
        isMonthValidated = true;
      });
    }

    return isMonthValidated;
  }

  List<Placemark?> placemark = [];

  void getPlaceMark(List<LogModel?> logList) async {
    placemark = [];
    placemark = await placemarkFromCoordinates(52.2165357, 5.9437819);
    print(placemark[0]?.administrativeArea);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    decoration: decoratedBorder.copyWith(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.blue,
                          width: 1,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 5, top: 0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: inputDecoration.copyWith(
                            hintText: " Employee Id",
                            hintStyle: const TextStyle(color: Colors.grey)),
                        onSaved: (value) {
                          employeeId = value;
                        },
                      ),
                    ),
                  ),
                ),
                isEmployeeIdNull!
                    ? Text(
                        "Please enter Employee id",
                        style: errorTextStyle,
                      )
                    : const SizedBox(height: 15),
              ],
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                Container(
                  decoration: decoratedBorder.copyWith(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: DropdownButtonFormField2(
                    decoration: const InputDecoration(
                      enabled: false,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Select year',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 50,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: years
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select batch.';
                      }
                    },
                    onChanged: (value) {
                      year = value as String?;
                    },
                    onSaved: (value) {
                      year = value as String?;
                    },
                  ),
                ),
                isYearNull!
                    ? Text(
                        "Please select the year",
                        style: errorTextStyle,
                      )
                    : const SizedBox(height: 15),
              ],
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                Container(
                  decoration: decoratedBorder.copyWith(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: DropdownButtonFormField2(
                    decoration: const InputDecoration(
                      enabled: false,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Select month',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 50,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: months
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select batch.';
                      }
                    },
                    onChanged: (value) {
                      year = value as String?;
                    },
                    onSaved: (value) {
                      year = value as String?;
                    },
                  ),
                ),
                isYearNull!
                    ? Text(
                        "Please select the month",
                        style: errorTextStyle,
                      )
                    : const SizedBox(height: 15),
              ],
            ),
            const SizedBox(height: 5),
            // Column(
            //   // crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 5),
            //       child: Container(
            //         decoration: decoratedBorder.copyWith(
            //             color: Colors.transparent,
            //             border: Border.all(
            //               color: Colors.blue,
            //               width: 1,
            //             ),
            //             borderRadius:
            //                 const BorderRadius.all(Radius.circular(10))),
            //         child: Padding(
            //           padding:
            //               const EdgeInsets.only(left: 15, right: 5, top: 0),
            //           child: TextFormField(
            //             style: const TextStyle(color: Colors.black),
            //             decoration: inputDecoration.copyWith(
            //                 hintText: " Month",
            //                 hintStyle: const TextStyle(color: Colors.grey)),
            //             onSaved: (value) {
            //               month = value;
            //             },
            //           ),
            //         ),
            //       ),
            //     ),
            //     isMonthNull!
            //         ? Text(
            //             "Please enter the month",
            //             style: errorTextStyle,
            //           )
            //         : const SizedBox(height: 15),
            //   ],
            // ),
            const SizedBox(height: 50),
            SizedBox(
              width: 250,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xff145486)),
                  onPressed: () async {
                    // loadingOn();
                    // formKey.currentState?.validate();
                    formKey.currentState?.save();
                    employeeIdValidation(employeeId);
                    yearValidation(year);
                    monthValidation(month);
                    if (employeeIdValidation(employeeId)! &&
                        yearValidation(year)! &&
                        monthValidation(month)!) {
                      // loadingOff();
                      LogData? logData = LogData();
                      MonthlyReport? mr = MonthlyReport();
                      mr = await getReport(
                          employeeId, int.parse(month!), int.parse(year!));
                      print(mr?.statusCode);
                      logData = await getLog(employeeId!);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ReportData(monthlyReport: mr, logData: logData)));

                      // displayDialog(context, value.toString());

                      // });
                    }
                  },
                  child: const Text("Search")),
            ),
          ],
        ),
      ),
    );
  }
}
