class CountryEventModel {
  String? country;
  String? eventName;

  CountryEventModel({this.country, this.eventName});

  CountryEventModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    eventName = json['event_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = this.country;
    data['event_name'] = this.eventName;
    return data;
  }
}
