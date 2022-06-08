import 'package:attendance_app/pages/Home/clock.dart';
import 'package:attendance_app/pages/authentication/log_in.dart';
import 'package:attendance_app/pages/base/base_url.dart';
import 'package:attendance_app/service/key_service.dart';
import 'package:flutter/material.dart';

class Initializer extends StatefulWidget {
  static const routeName = "/initializer";
  const Initializer({Key? key}) : super(key: key);

  @override
  State<Initializer> createState() => _InitializerState();
}

class _InitializerState extends State<Initializer> {
  final KeyService _keyService = KeyService();
  String? baseUrl;
  bool isLoading = false;
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

  Future<void> getBaseUrl() async {
    loadingOn();
    await _keyService.getValue();
    loadingOff();
  }

  @override
  void initState() {
    getBaseUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : KeyService.baseUrl == null
            ? const BaseUrl()
            : const LogIn();
  }
}
