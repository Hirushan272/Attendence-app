import 'package:attendance_app/constant/constant.dart';
import 'package:attendance_app/pages/authentication/log_in.dart';
import 'package:attendance_app/service/key_service.dart';
import 'package:attendance_app/widgets/alerts.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class BaseUrl extends StatefulWidget {
  static const routeName = "/base-url";
  const BaseUrl({Key? key}) : super(key: key);

  @override
  State<BaseUrl> createState() => _BaseUrlState();
}

class _BaseUrlState extends State<BaseUrl> {
  String? shortCode;
  final formKey = GlobalKey<FormState>();
  final KeyService keyService = KeyService();
  final validator1 = ValidationBuilder().required().minLength(1).build();
  bool isLoading = false;
  String? validate11;

  void setError1(Function(String?) validator, String? value) {
    setState(() {
      validate11 = validator(value);
    });
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

  SnackBar snackBar = SnackBar(
    content: Row(
      children: const [
        Icon(Icons.check_circle_outline, color: Colors.green),
        Text('Base URL saved!'),
      ],
    ),
  );

  // ScaffoldMessenger.of(context).showSnackBar(snackBar);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff145486),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(LogIn.routeName);
              },
              child: const Icon(
                Icons.cancel_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        color: const Color(0xff145486),
        child: Form(
          key: formKey,
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Enter company code",
                      style: TextStyle(fontSize: 22),
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 5, top: 0),
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: inputDecoration.copyWith(
                                    hintText: "Short code",
                                    hintStyle:
                                        const TextStyle(color: Colors.white)),
                                onSaved: (value) {
                                  shortCode = value;
                                  // print(password);
                                },
                              ),
                            ),
                          ),
                        ),
                        validate11 == null
                            ? const SizedBox(height: 15)
                            : Text(
                                validate11!,
                                style: errorTextStyle.copyWith(
                                    color: Colors.red[900]),
                              )
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff10BADF)),
                        onPressed: () async {
                          formKey.currentState?.save();
                          setError1(validator1, shortCode);

                          if (validate11 == null) {
                            loadingOn();
                            String? value =
                                await keyService.getBaseUrl(shortCode!);
                            if (value == "ok") {
                              loadingOff();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.of(context)
                                  .pushReplacementNamed(LogIn.routeName);
                            } else {
                              loadingOff();
                              warnDialog(context, value!);
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(snackBar);
                              // Navigator.of(context)
                              //     .pushReplacementNamed(LogIn.routeName);
                            }
                          }
                        },
                        child: const Text("Submit"),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
