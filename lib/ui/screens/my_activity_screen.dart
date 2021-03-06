import 'package:analytics_app/styles/app_colors.dart';
import 'package:analytics_app/ui/fragments/country_events_analytics_fragment.dart';
import 'package:analytics_app/ui/fragments/event_clicks_analytics_fragment.dart';
import 'package:analytics_app/ui/fragments/screen_analytics_fragment.dart';
import 'package:analytics_app/ui/screens/base/base_screen_tracker.dart';
import 'package:flutter/material.dart';

class MyActivityScreen extends StatefulWidget {
  MyActivityScreen({Key? key}) : super(key: key);

  @override
  State<MyActivityScreen> createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen>
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

  void refreshHostScreenByFragmentOnRefresh() {
    removeScreenTracker(widget, context);
    initScreenTracker(widget, context, incrementTimesOpened: false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.removeScreenTracker(widget, context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("My Activity"),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.mobile_screen_share),
              ),
              Tab(
                icon: Icon(Icons.ads_click),
              ),
              Tab(
                icon: Icon(Icons.location_on_rounded),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ScreenAnalyticsFragment(refreshHostScreenByFragmentOnRefresh),
            EventClicksAnalyticsFragment(refreshHostScreenByFragmentOnRefresh),
            CountryEventsAnalyticsFragment(refreshHostScreenByFragmentOnRefresh)
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
