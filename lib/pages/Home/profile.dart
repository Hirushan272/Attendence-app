import 'package:age_calculator/age_calculator.dart';
import 'package:attendance_app/service/auth_service.dart';
import 'package:attendance_app/widgets/Item_card.dart';
import 'package:attendance_app/widgets/profile_data_item.dart';
import 'package:flutter/material.dart';

import 'apply_leaves.dart';
import 'cancel_leave.dart';
import 'clock.dart';
import 'overview.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // getEmployeeData();
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
                  // Navigator.of(context).pushNamed(Profile.routeName);
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
                leading: const Icon(Icons.event_available_sharp),
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
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 50,
                      ),
                      const SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${employeeData!.title.toString()} ${employeeData?.fullName.toString()}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Status: $statusOfUser",
                            style: const TextStyle(
                                fontSize: 18, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                if (employeeData?.nic.toString() != "null")
                  profileItem("NIC", employeeData!.nic.toString()),
                const SizedBox(height: 10),
                if (employeeData?.mobile.toString() != "null")
                  profileItem("Contact No.", employeeData!.mobile.toString()),
                const SizedBox(height: 10),
                if (employeeData?.landLine.toString() != "null")
                  profileItem("Telephone", employeeData!.landLine.toString()),
                const SizedBox(height: 10),
                if (employeeData?.email.toString() != "null")
                  profileItem("Email", employeeData!.email.toString()),
                const SizedBox(height: 10),
                if (employeeData?.addressR.toString() != "null")
                  profileItem("Address (R)", employeeData!.addressR.toString()),
                const SizedBox(height: 10),
                if (employeeData?.addressG.toString() != "null")
                  profileItem("Address (G)", employeeData!.addressG.toString()),
                const SizedBox(height: 10),
                if (employeeData?.civilStatus.toString() != "null")
                  profileItem(
                      "Civil Status", employeeData!.civilStatus.toString()),
                const SizedBox(height: 10),
                if (employeeData?.dateOfBirth.toString() != "null")
                  profileItem("Date of Birth",
                      employeeData!.dateOfBirth.toString().substring(0, 10)),
                const SizedBox(height: 10),
                // if (employeeData?.dateOfBirth.toString() != "null")
                //   profileItem("Age", AgeCalculator.age().years.toString()),
                if (employeeData?.gender.toString() != "null")
                  profileItem("Gender", employeeData!.gender.toString()),
                const SizedBox(height: 10),
                if (employeeData?.empNo.toString() != "null")
                  profileItem("Employee No.", employeeData!.empNo.toString()),
                const SizedBox(height: 10),
                if (employeeData?.ETFNo.toString() != "null")
                  profileItem("ETF No.", employeeData!.ETFNo.toString()),
                const SizedBox(height: 10),
                if (employeeData?.EPFno.toString() != "null")
                  profileItem("EPF No.", employeeData!.EPFno.toString()),
                const SizedBox(height: 10),
                if (employeeData?.enrollNo.toString() != "null")
                  profileItem("Enroll No.", employeeData!.enrollNo.toString()),
                const SizedBox(height: 10),
                if (employeeData?.branchId.toString() != "null")
                  profileItem("Branch", employeeData!.branchId.toString()),
                const SizedBox(height: 10),
                if (employeeData?.mealType.toString() != "null")
                  profileItem("Category", employeeData!.mealType.toString()),
                const SizedBox(height: 10),
                if (employeeData?.employeeType.toString() != "null")
                  profileItem(
                      "Employee Type", employeeData!.employeeType.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
