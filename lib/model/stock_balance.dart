class StockBalance {
  Message? message;

  StockBalance({this.message});

  StockBalance.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  List<Columns>? columns;
  double? executionTime;
  List<Result>? result;
  int? skipTotalRow;
  bool? preparedReport;
  Doc? doc;
  bool? addTotalRow;

  Message(
      {this.columns,
      this.executionTime,
      // this.result,
      this.skipTotalRow,
      this.preparedReport,
      this.doc,
      this.addTotalRow});

  Message.fromJson(Map<String, dynamic> json) {
    if (json['columns'] != null) {
      columns = <Columns>[];
      json['columns'].forEach((v) {
        columns!.add(new Columns.fromJson(v));
      });
    }
    executionTime = json['execution_time'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        if (v is Map<String, dynamic>) result!.add(Result.fromJson(v));
      });
    }
    skipTotalRow = json['skip_total_row'];
    preparedReport = json['prepared_report'];
    doc = json['doc'] != null ? new Doc.fromJson(json['doc']) : null;
    addTotalRow = json['add_total_row'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (columns != null) {
      data['columns'] = columns!.map((v) => v.toJson()).toList();
    }
    data['execution_time'] = executionTime;
    // if (result != null) {
    //   data['result'] = result!.map((v) => v.toJson()).toList();
    // }
    data['skip_total_row'] = skipTotalRow;
    data['prepared_report'] = preparedReport;
    if (doc != null) {
      data['doc'] = doc!.toJson();
    }
    data['add_total_row'] = addTotalRow;
    return data;
  }
}

class Columns {
  String? fieldname;
  String? fieldtype;
  String? label;
  String? options;
  int? width;
  String? convertible;

  Columns(
      {this.fieldname,
      this.fieldtype,
      this.label,
      this.options,
      this.width,
      this.convertible});

  Columns.fromJson(Map<String, dynamic> json) {
    fieldname = json['fieldname'];
    fieldtype = json['fieldtype'];
    label = json['label'];
    options = json['options'];
    width = json['width'];
    convertible = json['convertible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldname'] = fieldname;
    data['fieldtype'] = fieldtype;
    data['label'] = label;
    data['options'] = options;
    data['width'] = width;
    data['convertible'] = convertible;
    return data;
  }
}

class Result {
  double? balQty;
  double? balVal;
  String? company;
  double? currency;
  double? inQty;
  double? inVal;
  String? itemCode;
  String? itemGroup;
  String? itemName;
  double? openingQty;
  double? openingVal;
  double? outQty;
  double? outVal;
  String? stockUom;
  double? valRate;
  String? warehouse;

  Result({
    this.balQty,
    this.balVal,
    this.company,
    this.currency,
    this.inQty,
    this.inVal,
    this.itemCode,
    this.itemGroup,
    this.itemName,
    this.openingQty,
    this.openingVal,
    this.outQty,
    this.outVal,
    this.stockUom,
    this.valRate,
    this.warehouse,
  });

  Result.fromJson(Map<String, dynamic> json) {
    balQty = json['bal_qty'];
    balVal = json['bal_val'];
    company = json['company'];
    currency = json['currency'];
    inQty = json['in_qty'];
    inVal = json['in_val'];
    itemCode = json['item_code'];
    itemGroup = json['item_group'];
    itemName = json['item_name'];
    openingQty = json['opening_qty'];
    openingVal = json['opening_val'];
    outQty = json['out_qty'];
    outVal = json['out_val'];
    stockUom = json['stock_uom'];
    valRate = json['val_rate'];
    warehouse = json['warehouse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bal_qty'] = balQty;
    data['bal_val'] = balVal;
    data['company'] = company;
    data['currency'] = currency;
    data['in_qty'] = inQty;
    data['in_val'] = inVal;
    data['item_code'] = itemCode;
    data['item_group'] = itemGroup;
    data['item_name'] = itemName;
    data['opening_qty'] = openingQty;
    data['opening_val'] = openingVal;
    data['out_qty'] = outQty;
    data['out_val'] = outVal;
    data['stock_uom'] = stockUom;
    data['val_rate'] = valRate;
    data['warehouse'] = warehouse;
    return data;
  }
}

class Doc {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? status;
  String? reportName;
  String? queuedBy;
  String? jobId;
  String? queuedAt;
  String? reportEndTime;
  String? filters;
  String? doctype;

  Doc(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.status,
      this.reportName,
      this.queuedBy,
      this.jobId,
      this.queuedAt,
      this.reportEndTime,
      this.filters,
      this.doctype});

  Doc.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    status = json['status'];
    reportName = json['report_name'];
    queuedBy = json['queued_by'];
    jobId = json['job_id'];
    queuedAt = json['queued_at'];
    reportEndTime = json['report_end_time'];
    filters = json['filters'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['owner'] = owner;
    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['status'] = status;
    data['report_name'] = reportName;
    data['queued_by'] = queuedBy;
    data['job_id'] = jobId;
    data['queued_at'] = queuedAt;
    data['report_end_time'] = reportEndTime;
    data['filters'] = filters;
    data['doctype'] = doctype;
    return data;
  }
}
