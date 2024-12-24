class QuickLinks {
  final String? doctypeName;
  final String label;
  final String routeName;
  final String routeType;
  final dynamic args;
  final String? icon;

  QuickLinks({
    this.doctypeName,
    required this.label,
    required this.routeName,
    required this.routeType,
    this.args,
    this.icon,
  });
}
