class Category {
  String? name;
  int? stationCount;

  Category({this.name, this.stationCount});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    stationCount = json['stationcount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['stationcount'] = stationCount;
    return data;
  }
}
