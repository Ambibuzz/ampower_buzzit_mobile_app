// x indicates name shown on x axis of graph, y1 and y2 indicates values of data shown on y axis
class BarChartModel {
  // Title or Label
  String x;
  // Target
  double? y;


  BarChartModel(this.x, this.y);

  factory BarChartModel.fromJson(Map<String, dynamic> json) {
    return BarChartModel(json['x'] ?? '', json['y']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
    return data;
  }
}