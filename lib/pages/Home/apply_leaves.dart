import 'package:attendance_app/constant/constant.dart';
import 'package:attendance_app/models/leave.dart';
import 'package:attendance_app/models/responce_model.dart';
import 'package:attendance_app/service/auth_service.dart';
import 'package:attendance_app/service/leave.dart';
import 'package:attendance_app/widgets/alerts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'cancel_leave.dart';
import 'clock.dart';
import 'overview.dart';
import 'profile.dart';

class ApplyLeaves extends StatefulWidget {
  static const routeName = "/apply-leaves";
  const ApplyLeaves({Key? key}) : super(key: key);

  @override
  State<ApplyLeaves> createState() => _ApplyLeavesState();
}

class _ApplyLeavesState extends State<ApplyLeaves> {
  final formKey = GlobalKey<FormState>();
  final LeaveModel leaveModel = LeaveModel();
  final Leave leaveService = Leave();

  bool? isLoading = false;
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

  final validator1 = ValidationBuilder().required().minLength(1).build();
  final validator2 = ValidationBuilder().required().minLength(1).build();
  final validator3 = ValidationBuilder().required().minLength(1).build();
  final validator4 = ValidationBuilder().required().minLength(1).build();
  final validator5 = ValidationBuilder().required().minLength(1).build();

  String? applyDate;
  String? leaveType;
  String? leaveDate;
  String? dayType;
  String? remark;
  String? leaveQty;

  String? validate11;
  String? validate22;
  String? validate33;
  String? validate44;
  String? validate55;

  void setError1(Function(String?) validator, String? value) {
    setState(() {
      validate11 = validator(value);
    });
  }

  void setError2(Function(String?) validator, String? value) {
    setState(() {
      validate22 = validator(value);
    });
  }

  void setError3(Function(String?) validator, String? value) {
    setState(() {
      validate33 = validator(value);
    });
  }

  void setError4(Function(String?) validator, String? value) {
    setState(() {
      validate44 = validator(value);
    });
  }

  void setError5(Function(String?) validator, String? value) {
    setState(() {
      validate55 = validator(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  // Navigator.of(context).pushNamed(ApplyLeaves.routeName);
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
        child: SizedBox(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Apply Leaves",
                    style: giantTextStyle,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Leave type", style: textFiledTitleStyle),
                      const SizedBox(height: 5),
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
                            'Select leave type',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 50,
                          buttonPadding:
                              const EdgeInsets.only(left: 20, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          items: leaveTypes
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
                          onChanged: (value) {
                            leaveType = value.toString();
                            leaveModel.leaveTypeId = leaveType;
                          },
                          onSaved: (String? value) {
                            leaveType = value;
                            leaveModel.leaveTypeId = leaveType;
                          },
                        ),
                      ),
                      validate11 == "null" ||
                              validate11 == "" ||
                              validate11 == null
                          ? const SizedBox(height: 15)
                          : Text(
                              validate11!,
                              style: errorTextStyle,
                            )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Apply Date", style: textFiledTitleStyle),
                      const SizedBox(height: 5),
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
                            padding: const EdgeInsets.only(
                                left: 15, right: 5, top: 0),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: inputDecoration.copyWith(
                                  hintText: "DD/MM/YYYY (today date)",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                              onSaved: (value) {
                                applyDate = value;
                                leaveModel.applyDate = applyDate;
                              },
                            ),
                          ),
                        ),
                      ),
                      validate22 == null
                          ? const SizedBox(height: 15)
                          : Text(
                              validate22!,
                              style: errorTextStyle,
                            )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Leave Date", style: textFiledTitleStyle),
                      const SizedBox(height: 5),
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
                            padding: const EdgeInsets.only(
                                left: 15, right: 5, top: 0),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: inputDecoration.copyWith(
                                  hintText: "DD/MM/YYYY",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                              onSaved: (value) {
                                leaveDate = value;
                                leaveModel.leaveDate = leaveDate;
                              },
                            ),
                          ),
                        ),
                      ),
                      validate33 == null
                          ? const SizedBox(height: 15)
                          : Text(
                              validate33!,
                              style: errorTextStyle,
                            )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Remark", style: textFiledTitleStyle),
                      const SizedBox(height: 5),
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
                            padding: const EdgeInsets.only(
                                left: 15, right: 5, top: 0),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: inputDecoration.copyWith(
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                              onSaved: (value) {
                                remark = value;
                                leaveModel.remark = remark;
                              },
                            ),
                          ),
                        ),
                      ),
                      validate44 == null
                          ? const SizedBox(height: 15)
                          : Text(
                              validate44!,
                              style: errorTextStyle,
                            )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Leave Qty", style: textFiledTitleStyle),
                      const SizedBox(height: 5),
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
                            padding: const EdgeInsets.only(
                                left: 15, right: 5, top: 0),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: inputDecoration.copyWith(
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                              onSaved: (value) {
                                leaveQty = value;
                                leaveModel.leaveQty = value;
                              },
                            ),
                          ),
                        ),
                      ),
                      validate55 == null
                          ? const SizedBox(height: 15)
                          : Text(
                              validate55!,
                              style: errorTextStyle,
                            )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: 50,
        child: Center(
          child: SizedBox(
            width: 200,
            height: 40,
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xff145486)),
                onPressed: () async {
                  formKey.currentState?.save();
                  setError1(validator1, leaveType);
                  setError2(validator2, applyDate);
                  setError3(validator3, leaveDate);
                  setError4(validator4, remark);
                  setError5(validator5, leaveQty);
                  leaveModel.empNo = userData?.empNo;
                  if (validate11 == null &&
                      validate22 == null &&
                      validate33 == null &&
                      validate44 == null &&
                      validate55 == null) {
                    loadingOn();
                    ResponseModel responseModel =
                        await leaveService.submitLeave(leaveModel);
                    if (responseModel.statusCode == 200) {
                      successDialog(context, responseModel.message);
                      loadingOff();
                    } else {
                      successDialog(context, responseModel.message);
                      loadingOff();
                    }
                  }
                },
                child: const Text("Apply leave")),
          ),
        ),
      ),
    );
  }
}
