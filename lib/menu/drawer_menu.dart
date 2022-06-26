import 'package:analytics_app/ui/screens/home_screen.dart';
import 'package:analytics_app/ui/screens/my_activity_screen.dart';
import 'package:analytics_app/utils/app_firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../ui/screens/login_screen.dart';
import '../ui/screens/base/base_screen_tracker.dart';
import '../utils/ui_helper.dart';

class DrawerMenu {
  static ListView drawerMenu(BuildContext context, bool isAdmin,
          BaseScreenTracker homeScreen, HomeScreen widget) =>
      ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Container(
            color: AppColors.primaryColor,
            height: 200,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Image.asset(
                    'images/logo.png',
                    height: 100,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Expanded(
                    child: Text(
                      'Welcome',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white, fontSize: 23, letterSpacing: 5),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () async {
              Navigator.pop(context);
              homeScreen.onClickTrack('DashboardDrawerButton', context);
            },
            leading: const Icon(
              Icons.home,
              color: AppColors.accentColor,
            ),
            title: const Text("Dashboard"),
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              homeScreen.onClickTrack('MyActivityDrawerButton', context);
              homeScreen.gotoScreen(context, MyActivityScreen(),
                  currentScreenTrackerWidget: widget);
            },
            leading: const Icon(
              Icons.access_time,
              color: AppColors.accentColor,
            ),
            title: const Text("My Activity"),
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            onTap: () async {
              showLoaderDialog(context);
              await homeScreen.onClickTrack('LogoutDrawerButton', context);
              await AppFirebaseHelper.logout();
              Navigator.pop(context);

              UIHelper.gotoScreen(context, LoginScreen(),
                  removePreviousStack: true);
            },
            leading: const Icon(
              Icons.logout,
              color: AppColors.accentColor,
            ),
            title: const Text("Logout"),
          ),
        ],
      );
  static void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Logging out...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
