import 'package:analytics_app/models/country_event_model.dart';
import 'package:analytics_app/styles/app_colors.dart';
import 'package:analytics_app/ui/screens/base/base_screen_tracker.dart';
import 'package:analytics_app/utils/ui_helper.dart';
import 'package:analytics_app/widgets/app_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../blocs/geo/geo_cubit.dart';
import '../../blocs/geo/geo_state.dart';

class CountryEventsAnalyticsFragment extends StatefulWidget {
  final Function() refreshHostScreenTrackingDetails;

  const CountryEventsAnalyticsFragment(this.refreshHostScreenTrackingDetails,
      {Key? key})
      : super(key: key);

  @override
  State<CountryEventsAnalyticsFragment> createState() =>
      _CountryEventsAnalyticsFragmentState();
}

class _CountryEventsAnalyticsFragmentState
    extends State<CountryEventsAnalyticsFragment>
    with WidgetsBindingObserver, BaseScreenTracker {
  int count = 0;
  late GeoCubit geoCubit;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);

    geoCubit = BlocProvider.of<GeoCubit>(context);
    fetchData(isInitState: true);
    //myActivityCubit.getScreensOpenedAnalytics();

    super.initState();
  }

  void fetchData({required bool isInitState}) {
    if (!isInitState) {
      removeScreenTracker(widget, context);
      initScreenTracker(widget, context);
    } else {
      initScreenTracker(widget, context);
    }
    widget.refreshHostScreenTrackingDetails();
    geoCubit.getMyLocationEvents(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("EVENTS clicked : " + state.toString());
    if (state == AppLifecycleState.resumed) {
      initScreenTracker(widget, context);
      return;
    }
    /* else if (state == AppLifecycleState.inactive) {
      super.removeScreenTracker(widget);
      return;
    } */

    else if (state == AppLifecycleState.paused) {
      removeScreenTracker(widget, context);
      return;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    removeScreenTracker(widget, context);
    super.dispose();
  }

  void onPressedRefresh() {
    onClickTrack('RefreshCountryEventsButton', context);
    fetchData(isInitState: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 15, bottom: 40),
        child: Column(
          children: [
            AppRoundedButton(label: 'REFRESH', onPressed: onPressedRefresh),
            const SizedBox(
              height: 30,
            ),
            BlocConsumer<GeoCubit, GeoState>(
              listener: (context, state) {
                if (state is GetMyLocationEventErrorState) {
                  UIHelper.showAlertDialog(context, state.msg);
                }
              },
              builder: (context, state) {
                if (state is GetMyLocationEventLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetMyLocationEventSuccessState) {
                  return Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            'EVENTS BY COUNTRY',
                            style: TextStyle(fontSize: 24, letterSpacing: 1.5),
                          ),
                          Container(
                            width: 170,
                            color: AppColors.primaryColor,
                            height: 3,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      GroupedListView<CountryEventModel, String>(
                        shrinkWrap: true,
                        elements: state.countryEventsList,
                        groupBy: (element) => element.country!,
                        groupSeparatorBuilder: (String groupByValue) => Column(
                          children: [
                            Text(
                              groupByValue,
                              style:
                                  TextStyle(fontSize: 24, letterSpacing: 1.5),
                            ),
                            Container(
                              width: 40,
                              color: AppColors.primaryColor,
                              height: 3,
                            )
                          ],
                        ),
                        itemBuilder: (context, CountryEventModel element) {
                          return Card(
                            child: ListTile(
                              leading: const Icon(
                                Icons.location_on_rounded,
                                size: 36,
                              ),
                              title: Text(element.country ?? ''),
                              subtitle: Text(element.eventName ?? ''),
                            ),
                          );
                        },
                        itemComparator: (item1, item2) => item1.country!
                            .compareTo(item2.country!), // optional
                        useStickyGroupSeparators: true, // optional
                        floatingHeader: true, // optional

                        order: GroupedListOrder.ASC, // optional
                      ),
                      /*   ListView.builder(
                          itemCount: state.countryEventsList.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            CountryEventModel countryEventModel =
                                state.countryEventsList[index];
                            return Card(
                              child: ListTile(
                                leading: const Icon(
                                  Icons.location_on_rounded,
                                  size: 36,
                                ),
                                title: Text(countryEventModel.country ?? ''),
                                subtitle:
                                    Text(countryEventModel.eventName ?? ''),
                              ),
                            );
                          }),*/
                    ],
                  );
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
