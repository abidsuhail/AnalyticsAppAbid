import 'package:analytics_app/repository/my_activity_repo.dart';
import 'package:analytics_app/repository/tracker_repo.dart';
import 'package:flutter/cupertino.dart';

import '../../models/screen_tracker_info.dart';
import '../../utils/app_firebase_helper.dart';

class TrackerCubit {
  static TrackerCubit? _instance;
  TrackerRepo trackerRepo = TrackerRepo.getInstance();
  static TrackerCubit getInstance() {
    _instance ??= TrackerCubit();
    return _instance!;
  }

  void onClickTrack(String clickName, BuildContext context) async {
    trackerRepo.onClickTrack(clickName, context);
  }

  void incTimeScreenOpened(Widget widget) {
    if (!AppFirebaseHelper.isAuthenticated()) {
      return;
    }
    trackerRepo.incTimeScreenOpened(widget);
  }

  void durationScreenOpened(Widget widget, double duration) {
    if (!AppFirebaseHelper.isAuthenticated()) {
      return;
    }
    trackerRepo.durationScreenOpened(widget, duration);
  }

  void removeScreenTracker(Widget widget) {
    trackerRepo.removeScreenTracker(widget);
  }

  void initScreenTracker(Widget widget, {bool? incrementTimesOpened}) {
    trackerRepo.initScreenTracker(widget);
  }
}
