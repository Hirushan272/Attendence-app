import 'dart:convert';

import 'package:attendance_app/models/report.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class LogModel {
  String? date;
  String? time;
  String? status;
  int? index;
  double? long;
  double? lat;
  String? place;
  LogModel({
    this.date,
    this.time,
    this.status,
    this.index,
    this.long,
    this.lat,
    this.place,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'time': time,
      'status': status,
      'index': index,
      'long': long,
      'lat': lat,
      'place': place,
    };
  }

  factory LogModel.fromMap(Map<String, dynamic> map) {
    return LogModel(
      date: map['date'],
      time: map['time'],
      status: map['status'],
      index: map['index']?.toInt(),
      long: map['long']?.toDouble(),
      lat: map['lat']?.toDouble(),
      place: map['place'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LogModel.fromJson(String source) =>
      LogModel.fromMap(json.decode(source));
}

class LogData {
  String? date;
  List<LogModel?>? logList;
  LogData({
    this.date,
    this.logList,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'logList': logList?.map((x) => x?.toMap()).toList(),
    };
  }

  factory LogData.fromMap(Map<String, dynamic> map) {
    return LogData(
      date: map['date'],
      logList: map['logList'] != null
          ? List<LogModel?>.from(
              map['logList']?.map((x) => LogModel?.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogData.fromJson(String source) =>
      LogData.fromMap(json.decode(source));
}

class ReportData extends StatefulWidget {
  static const routeName = "/report-page";
  final MonthlyReport? monthlyReport;
  final LogData? logData;
  const ReportData({Key? key, this.monthlyReport, this.logData})
      : super(key: key);

  @override
  State<ReportData> createState() => _ReportDataState();
}

class _ReportDataState extends State<ReportData> {
  List<LogModel?>? logList = [];

  static Future<void> openMap(double? latitude, double? longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // ignore: deprecated_member_use
    if (await canLaunch(googleUrl) != null) {
      // ignore: deprecated_member_use
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  List<Placemark?> placemark = [];
  void getPlaceMark(String? lat, String? long) async {
    placemark = [];
    placemark = await placemarkFromCoordinates(52.2165357, 5.9437819);
    print(placemark[0]?.administrativeArea);
  }

  @override
  void initState() {
    super.initState();
    logList = widget.logData?.logList;
    print(logList?.length);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.cancel_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
        child: Column(
          children: [
            Container(
              height: 80,
              width: size.width,
              // color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: const [
                          SizedBox(width: 20),
                          Text(
                            "Work minutes",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xff145486)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "${widget.monthlyReport?.workMinutesMonth}",
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Leave minutes",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xff145486)),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "${widget.monthlyReport?.leaveMinutesMonth}",
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Date Time",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "In/Out",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Location",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: size.height * 0.6,
              child: ListView.builder(
                  itemCount: logList?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                                "${widget.logData?.date} ${logList![index]?.time}"),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text("${logList![index]?.status}")),
                          Expanded(
                              flex: 3,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    openMap(logList![index]?.lat,
                                        logList![index]?.long);
                                  },
                                  child: Text(
                                    logList![index]!.place.toString(),
                                    style: TextStyle(color: Colors.blue[700]),
                                  ),
                                ),
                              )
                              // Row(
                              //   children: [
                              //     Text(
                              //         "(${logList![index]?.lat},${logList![index]?.long})"),
                              //   ],
                              // ),
                              ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
