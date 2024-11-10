import 'dart:async';
import 'package:final_app_flutter/model/account_model.dart';
import 'package:final_app_flutter/page/home_page.dart';
import 'package:final_app_flutter/page/login_page.dart';
import 'package:final_app_flutter/page/main_tab_page.dart';
import 'package:final_app_flutter/page/onboarding.dart';
import 'package:final_app_flutter/services/shared_prefs.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SharedPrefs _prefs = SharedPrefs();

  @override
  void initState() {
    super.initState();
    _getSignup();
    _getAccount();

    Timer(const Duration(seconds: 2), () {
      if (accountList.isEmpty) {
        Route route = MaterialPageRoute(builder: (context) => Onboarding());
        Navigator.push(context, route);
      } else {
        for (var account in accountList) {
          print(account.emailAddress);
          print(account.password);
        }
        if (accountList1.isEmpty) {
          Route route = MaterialPageRoute(builder: (context) => LoginPage());
          Navigator.push(context, route);
        } else {
          Route route = MaterialPageRoute(builder: (context) => MainTabPage());
          Navigator.push(context, route);
        }
      }
    });
  }

  _getAccount() {
    _prefs.getAccount().then((value) => accountList1 = value ?? []);
  }

  _getSignup() {
    _prefs.getSignup().then((value) => accountList = value ?? []);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            width: size.width,
            height: size.height,
            fit: BoxFit.fill,
          ),
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 180.0,
            ),
          ),
        ],
      ),
    );
  }
}
