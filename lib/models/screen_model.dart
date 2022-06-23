class ScreenModel {
  String? timesOpened;
  String? screenName;

  ScreenModel({this.timesOpened, this.screenName});

  ScreenModel.fromJson(Map<String, dynamic> json) {
    timesOpened = json['times_opened'];
    screenName = json['screen_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['times_opened'] = this.timesOpened;
    data['screen_name'] = this.screenName;
    return data;
  }
}
