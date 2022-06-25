import 'package:analytics_app/styles/app_colors.dart';
import 'package:analytics_app/ui/screens/base/base_screen_tracker.dart';
import 'package:flutter/material.dart';

class BirdFlyingScreen extends StatefulWidget {
  BirdFlyingScreen({Key? key}) : super(key: key);

  @override
  State<BirdFlyingScreen> createState() => _BirdFlyingScreenState();
}

class _BirdFlyingScreenState extends State<BirdFlyingScreen>
    with WidgetsBindingObserver, BaseScreenTracker {
  int count = 0;
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initScreenTracker(widget, context);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("BirdFlyingScreen : " + state.toString());
    if (state == AppLifecycleState.resumed) {
      super.initScreenTracker(widget, context);
      return;
    } /* else if (state == AppLifecycleState.inactive) {
      super.removeScreenTracker(widget);
      return;
    } */
    else if (state == AppLifecycleState.paused) {
      super.removeScreenTracker(widget, context);
      return;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.removeScreenTracker(widget, context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Bird Flying"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
          color: Colors.black,
          child: Center(child: Image.asset('images/bird3.gif'))),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onTapEvent1() {}
  void onTapEvent2() {}
  void onTapEvent3() {}
  void onTapEvent4() {}
}
