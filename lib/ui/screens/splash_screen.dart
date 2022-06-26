import 'dart:async';

import 'package:analytics_app/ui/screens/home_screen.dart';
import 'package:analytics_app/ui/screens/login_screen.dart';
import 'package:analytics_app/utils/app_constants.dart';
import 'package:analytics_app/utils/app_firebase_helper.dart';
import 'package:analytics_app/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() async {
    Timer(const Duration(seconds: 3), () {
      startScreen();
    });
  }

  void startScreen() {
    if (AppFirebaseHelper.isAuthenticated()) {
      UIHelper.gotoScreen(context, HomeScreen(), removePreviousStack: true);
    } else {
      UIHelper.gotoScreen(context, LoginScreen(), removePreviousStack: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Image.asset(
              'images/logo.png',
              height: 150,
            )),
            Text(
              AppConstants.APP_NAME,
              style: TextStyle(fontSize: 30, letterSpacing: 5),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
