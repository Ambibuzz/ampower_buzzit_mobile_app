class AccountBalance {
  List<Message>? message;

  AccountBalance({this.message});

  AccountBalance.fromJson(Map<String, dynamic> json) {
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
  String? companyCurrency;
  double? balance;

  Message(
      {this.value,
      this.expandable,
      this.rootType,
      this.reportType,
      this.accountCurrency,
      this.companyCurrency,
      this.balance});

  Message.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    expandable = json['expandable'];
    rootType = json['root_type'];
    reportType = json['report_type'];
    accountCurrency = json['account_currency'];
    companyCurrency = json['company_currency'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['expandable'] = expandable;
    data['root_type'] = rootType;
    data['report_type'] = reportType;
    data['account_currency'] = accountCurrency;
    data['company_currency'] = companyCurrency;
    data['balance'] = balance;
    return data;
  }
}
