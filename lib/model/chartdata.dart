// x indicates name shown on x axis of graph, y indicates values of data shown on y axis
// text indicates text name and color of text
import 'package:flutter/material.dart';

class ChartDataModel {
  ChartDataModel(this.x, this.y, this.text, this.color);

  final String x;
  final double y;
  final String text;
  final Color color;

  factory ChartDataModel.fromJson(Map<String, dynamic> json) {
    return ChartDataModel(
        json['x'] ?? '', json['y'], json['text'], json['color']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
    data['text'] = text;
    data['color'] = color;

    return data;
  }
}

class ChartData {
  ChartData(this.x, this.y, this.label, {this.color});
  final String x;
  final double y;
  final Color? color;
  final String label;
}
