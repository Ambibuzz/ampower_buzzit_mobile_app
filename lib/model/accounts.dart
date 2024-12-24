class Accounts {
  List<Message>? message;

  Accounts({this.message});

  Accounts.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? value;
  int? expandable;
  String? rootType;
  String? reportType;
  String? accountCurrency;

  Message(
      {this.value,
      this.expandable,
      this.rootType,
      this.reportType,
      this.accountCurrency});

  Message.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    expandable = json['expandable'];
    rootType = json['root_type'];
    reportType = json['report_type'];
    accountCurrency = json['account_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['expandable'] = expandable;
    data['root_type'] = rootType;
    data['report_type'] = reportType;
    data['account_currency'] = accountCurrency;
    return data;
  }
}
