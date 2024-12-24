class FilterCustom {
  final String? doctype;
  final String? field;
  final String? operator;
  final dynamic value;

  FilterCustom(this.doctype, this.field, this.operator, this.value);

  List<dynamic> toJson() {
    return [doctype, field, operator, value];
  }
}