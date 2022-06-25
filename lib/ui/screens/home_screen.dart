import 'dart:async';

import 'package:analytics_app/styles/app_colors.dart';
import 'package:analytics_app/ui/screens/bird_flying_screen.dart';
import 'package:analytics_app/ui/screens/screen_1_screen.dart';
import 'package:analytics_app/ui/screens/screen_2_screen.dart';
import 'package:analytics_app/utils/app_constants.dart';
import 'package:analytics_app/utils/app_firebase_helper.dart';
import 'package:analytics_app/utils/base_screen_tracker.dart';
import 'package:analytics_app/utils/app_utils.dart';
import 'package:analytics_app/utils/ui_helper.dart';
import 'package:analytics_app/widgets/app_rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../menu/drawer_menu.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver, BaseScreenTracker {
  int count = 0;
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initScreenTracker(widget);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("HOMESCREEN : " + state.toString());
    if (state == AppLifecycleState.resumed) {
      super.initScreenTracker(widget);
      return;
    } /* else if (state == AppLifecycleState.inactive) {
      super.removeScreenTracker(widget);
      return;
    } */
    else if (state == AppLifecycleState.paused) {
      super.removeScreenTracker(widget);
      return;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.removeScreenTracker(widget);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      drawer: Drawer(child: DrawerMenu.drawerMenu(context, true, this, widget)),
      body: GestureDetector(
        onTap: onTapBackground,
        child: Container(
          padding: const EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: onTapEvent1,
                          child: Card(
                            child: Container(
                              color: const Color(0xff4C3A51),
                              alignment: Alignment.center,
                              child: const Text(
                                'Event 1',
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: onTapEvent2,
                          child: Card(
                            child: Container(
                              color: const Color(0xff774360),
                              alignment: Alignment.center,
                              child: const Text(
                                'Event 2',
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Container(
                  height: 200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: onTapEvent3,
                          child: Card(
                            child: Container(
                              color: const Color(0xff9B25068),
                              alignment: Alignment.center,
                              child: const Text(
                                'Event 3',
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: onTapEvent4,
                          child: Card(
                            child: Container(
                              color: const Color(0xffE7AB79),
                              alignment: Alignment.center,
                              child: const Text(
                                'Event 4',
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppRoundedButton(
                        label: 'Screen 1',
                        onPressed: onPressedScreen1,
                        fitWidth: true,
                      ),
                    ),
                    Expanded(
                      child: AppRoundedButton(
                        label: 'Screen 2',
                        onPressed: onPressedScreen2,
                        fitWidth: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      onPressed: onTapMinus,
                      heroTag: 'btn1',
                      child: const Icon(Icons.remove),
                    ),
                    Text(
                      count.toString(),
                      style: const TextStyle(fontSize: 50),
                    ),
                    FloatingActionButton(
                      onPressed: onTapPlus,
                      heroTag: 'btn2',
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Divider(),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                      onPressed: onPressedViewBird,
                      child: const Text(
                        'VIEW BIRD',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onPressedScreen1() {
    gotoScreen(context, Screen1Screen(), currentScreenTrackerWidget: widget);
  }

  void onPressedScreen2() {
    gotoScreen(context, Screen2Screen(), currentScreenTrackerWidget: widget);
  }

  void onTapBackground() {
    super.onClickTrack('HomeScreenBackground', context);
  }

  void onPressedViewBird() {
    super.onClickTrack('ViewBirdButton', context);
    gotoScreen(context, BirdFlyingScreen(), currentScreenTrackerWidget: widget);
  }

  void onTapPlus() {
    super.onClickTrack('PlusButton', context);
    setState(() {
      count++;
    });
  }

  void onTapMinus() {
    super.onClickTrack('MinusButton', context);
    setState(() {
      count--;
    });
  }

  void onTapEvent1() {
    UIHelper.showAlertDialog(context, 'Event 1 Clicked!');
    super.onClickTrack('Event1Button', context);
  }

  void onTapEvent2() {
    UIHelper.showAlertDialog(context, 'Event 2 Clicked!');

    super.onClickTrack('Event2Button', context);
  }

  void onTapEvent3() {
    UIHelper.showAlertDialog(context, 'Event 3 Clicked!');

    super.onClickTrack('Event3Button', context);
  }

  void onTapEvent4() {
    UIHelper.showAlertDialog(context, 'Event 4 Clicked!');

    super.onClickTrack('Event4Button', context);
  }
}
