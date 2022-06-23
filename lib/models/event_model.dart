class EventModel {
  String? clickCount;
  String? eventName;

  EventModel({this.clickCount, this.eventName});

  EventModel.fromJson(Map<String, dynamic> json) {
    clickCount = json['click_count'];
    eventName = json['event_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['click_count'] = this.clickCount;
    data['event_name'] = this.eventName;
    return data;
  }
}
