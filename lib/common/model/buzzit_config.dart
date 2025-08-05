class BuzzitConfig {
  String? name;
  String? owner;
  // int? docstatus;
  // int? idx;
  int? purchaseOrder;
  int? purchaseInvoice;
  int? salesOrder;
  int? salesInvoice;
  int? stockBalanceReport;
  int? customerLedgerReport;
  int? supplierLedgerReport;
  int? balanceSheetReport;
  int? viewItems;
  int? workflow;
  String? doctype;

  BuzzitConfig(
      {this.name,
      this.owner,
      // this.docstatus,
      // this.idx,
      this.purchaseOrder,
      this.purchaseInvoice,
      this.salesOrder,
      this.salesInvoice,
      this.stockBalanceReport,
      this.customerLedgerReport,
      this.supplierLedgerReport,
      this.balanceSheetReport,
      this.viewItems,
      this.workflow,
      this.doctype});

  BuzzitConfig.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    // docstatus = json['docstatus'];
    // idx = json['idx'];
    purchaseOrder = json['purchase_order'];
    purchaseInvoice = json['purchase_invoice'];
    salesOrder = json['sales_order'];
    salesInvoice = json['sales_invoice'];
    stockBalanceReport = json['stock_balance_report'];
    customerLedgerReport = json['customer_ledger_report'];
    supplierLedgerReport = json['supplier_ledger_report'];
    balanceSheetReport = json['balance_sheet_report'];
    viewItems = json['view_items'];
    workflow = json['workflow'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    // data['docstatus'] = docstatus;
    // data['idx'] = idx;
    data['purchase_order'] = purchaseOrder;
    data['purchase_invoice'] = purchaseInvoice;
    data['sales_order'] = salesOrder;
    data['sales_invoice'] = salesInvoice;
    data['stock_balance_report'] = stockBalanceReport;
    data['customer_ledger_report'] = customerLedgerReport;
    data['supplier_ledger_report'] = supplierLedgerReport;
    data['balance_sheet_report'] = balanceSheetReport;
    data['view_items'] = viewItems;
    data['workflow'] = workflow;
    data['doctype'] = doctype;
    return data;
  }
}
