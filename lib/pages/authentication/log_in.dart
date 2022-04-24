import 'package:attendance_app/constant/constant.dart';
import 'package:attendance_app/pages/Home/clock.dart';
import 'package:attendance_app/pages/Home/employee.dart';
import 'package:attendance_app/pages/Home/home_page.dart';
import 'package:attendance_app/service/auth_service.dart';
import 'package:attendance_app/widgets/alerts.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  static const String routeName = "/log-in";
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? username;
  String? password;
  bool? setValue = false;
  bool? isLoading = false;

  bool? isUsernameNull = false;
  bool? isUsernameValidated = false;

  bool? isPasswordNull = false;
  bool? isPasswordValidated = false;

  bool? usernameValidation(String? username) {
    if (username == "null" || username == null || username == "") {
      setState(() {
        isUsernameNull = true;
        isUsernameValidated = false;
      });
    } else {
      setState(() {
        isUsernameNull = false;
        isUsernameValidated = true;
      });
    }

    return isUsernameValidated;
  }

  bool? passwordValidation(String? password) {
    if (password == "null" || password == null || password == '') {
      setState(() {
        isPasswordNull = true;
        isPasswordValidated = false;
      });
    } else {
      setState(() {
        isPasswordNull = false;
        isPasswordValidated = true;
      });
    }

    return isPasswordValidated;
  }

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color(0xff145486),
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Log in",
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Log in and start managing your attendance",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Container(
                          decoration: decoratedBorder.copyWith(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 5, top: 0),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: inputDecoration.copyWith(
                                  hintText: "User Name",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                              onSaved: (value) {
                                username = value;
                                print(username);
                              },
                            ),
                          ),
                        ),
                      ),
                      if (isUsernameNull!)
                        Text(
                          "Please enter username",
                          style: errorTextStyle,
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Container(
                          decoration: decoratedBorder.copyWith(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 5, top: 0),
                            child: TextFormField(
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: inputDecoration.copyWith(
                                  hintText: "Password",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                              onSaved: (value) {
                                password = value;
                                print(password);
                              },
                            ),
                          ),
                        ),
                      ),
                      if (isPasswordNull!)
                        Text(
                          "Please enter password",
                          style: errorTextStyle,
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => const BorderSide(
                                      width: 1.0, color: Colors.blue),
                                ),
                                value: setValue,
                                onChanged: (v) {
                                  setState(() {
                                    setValue = !setValue!;
                                  });
                                }),
                            const Text(
                              "Remember me",
                              style: TextStyle(color: Colors.white60),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blue[200]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff10BADF)),
                        onPressed: () async {
                          loadingOn();
                          _formKey.currentState?.save();
                          usernameValidation(username);
                          passwordValidation(password);
                          if (usernameValidation(username)! &&
                              passwordValidation(password)!) {
                            await logIn(username!, password!).then((value) {
                              loadingOff();
                              if (value == "ok") {
                                if (userData?.roleId == 2) {
                                  Navigator.of(context).pushReplacementNamed(
                                      ClockPage.routeName);
                                } else if (userData?.roleId == 3) {
                                  Navigator.of(context).pushReplacementNamed(
                                      EmployeePage.routeName);
                                }
                              } else {
                                displayDialog(context, value.toString());
                              }
                            });
                          }
                        },
                        child: const Text("Log In")),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                height: size.height * 0.2,
                width: size.width,
                child: const Image(
                  image: AssetImage("assets/login.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
