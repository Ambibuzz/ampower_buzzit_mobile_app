class SalesInvoiceList {
  List<SalesInvoice>? salesInvoiceList;

  SalesInvoiceList({this.salesInvoiceList});

  SalesInvoiceList.fromJson(Map<String, dynamic> json) {
    salesInvoiceList = List.from(json['sales_invoice_list'])
        .map((e) => SalesInvoice.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (SalesInvoiceList != null) {
      data['sales_invoice_list'] =
          salesInvoiceList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesInvoice {
  String? name;
  String? customer;
  String? customerAddress;
  String? addressDisplay;
  String? postingDate;
  String? dueDate;
  double? totalAdvance;
  double? baseGrandTotal;
  String? company;
  String? companyAddress;
  String? companyAddressDisplay;
  String? status;

  SalesInvoice({
    this.name,
    this.customer,
    this.company,
    this.postingDate,
    this.dueDate,
    this.baseGrandTotal,
    this.totalAdvance,
    this.companyAddress,
    this.companyAddressDisplay,
    this.customerAddress,
    this.addressDisplay,
  });

  SalesInvoice.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customer = json['customer'];
    company = json['company'];
    postingDate = json['posting_date'];
    dueDate = json['due_date'];
    baseGrandTotal = json['base_grand_total'];
    customerAddress = json['customer_address'];
    addressDisplay = json['address_display'];
    totalAdvance = json['total_advance'];
    companyAddress = json['company_address'];
    companyAddressDisplay = json['company_address_display'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['customer'] = customer;
    data['company'] = company;
    data['posting_date'] = postingDate;
    data['due_date'] = dueDate;
    data['base_grand_total'] = baseGrandTotal;
    data['company_address'] = companyAddress;
    data['company_address_display'] = companyAddressDisplay;
    data['customer_address'] = customerAddress;
    data['address_display'] = addressDisplay;
    data['total_advance'] = totalAdvance;
    data['status'] = status;
    return data;
  }
}

class Items {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  int? hasItemScanned;
  String? itemCode;
  String? itemName;
  String? description;
  String? gstHsnCode;
  int? isNilExempt;
  int? isNonGst;
  String? itemGroup;
  String? image;
  int? qty;
  String? stockUom;
  String? uom;
  int? conversionFactor;
  int? stockQty;
  double? priceListRate;
  double? basePriceListRate;
  String? marginType;
  double? marginRateOrAmount;
  double? rateWithMargin;
  int? discountPercentage;
  double? discountAmount;
  double? baseRateWithMargin;
  double? rate;
  double? amount;
  int? taxIncludedPrice;
  double? baseRate;
  double? baseAmount;
  double? stockUomRate;
  int? isFreeItem;
  int? grantCommission;
  double? netRate;
  int? taxableAmount;
  double? netAmount;
  int? totalAmount;
  int? cgst;
  int? sgst;
  int? igst;
  int? gstPercentage;
  double? baseNetRate;
  double? baseNetAmount;
  int? taxableValue;
  int? deliveredBySupplier;
  String? incomeAccount;
  int? isFixedAsset;
  String? expenseAccount;
  int? enableDeferredRevenue;
  int? weightPerUnit;
  int? totalWeight;
  String? warehouse;
  int? incomingRate;
  int? allowZeroValuationRate;
  String? itemTaxRate;
  int? actualBatchQty;
  int? actualQty;
  int? deliveredQty;
  String? costCenter;
  int? pageBreak;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;
  String? pricingRules;

  Items(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.hasItemScanned,
      this.itemCode,
      this.itemName,
      this.description,
      this.gstHsnCode,
      this.isNilExempt,
      this.isNonGst,
      this.itemGroup,
      this.image,
      this.qty,
      this.stockUom,
      this.uom,
      this.conversionFactor,
      this.stockQty,
      this.priceListRate,
      this.basePriceListRate,
      this.marginType,
      this.marginRateOrAmount,
      this.rateWithMargin,
      this.discountPercentage,
      this.discountAmount,
      this.baseRateWithMargin,
      this.rate,
      this.amount,
      this.taxIncludedPrice,
      this.baseRate,
      this.baseAmount,
      this.stockUomRate,
      this.isFreeItem,
      this.grantCommission,
      this.netRate,
      this.taxableAmount,
      this.netAmount,
      this.totalAmount,
      this.cgst,
      this.sgst,
      this.igst,
      this.gstPercentage,
      this.baseNetRate,
      this.baseNetAmount,
      this.taxableValue,
      this.deliveredBySupplier,
      this.incomeAccount,
      this.isFixedAsset,
      this.expenseAccount,
      this.enableDeferredRevenue,
      this.weightPerUnit,
      this.totalWeight,
      this.warehouse,
      this.incomingRate,
      this.allowZeroValuationRate,
      this.itemTaxRate,
      this.actualBatchQty,
      this.actualQty,
      this.deliveredQty,
      this.costCenter,
      this.pageBreak,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype,
      this.pricingRules});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    hasItemScanned = json['has_item_scanned'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    description = json['description'];
    gstHsnCode = json['gst_hsn_code'];
    isNilExempt = json['is_nil_exempt'];
    isNonGst = json['is_non_gst'];
    itemGroup = json['item_group'];
    image = json['image'];
    qty = json['qty'];
    stockUom = json['stock_uom'];
    uom = json['uom'];
    conversionFactor = json['conversion_factor'];
    stockQty = json['stock_qty'];
    priceListRate = json['price_list_rate'];
    basePriceListRate = json['base_price_list_rate'];
    marginType = json['margin_type'];
    marginRateOrAmount = json['margin_rate_or_amount'];
    rateWithMargin = json['rate_with_margin'];
    discountPercentage = json['discount_percentage'];
    discountAmount = json['discount_amount'];
    baseRateWithMargin = json['base_rate_with_margin'];
    rate = json['rate'];
    amount = json['amount'];
    taxIncludedPrice = json['tax_included_price'];
    baseRate = json['base_rate'];
    baseAmount = json['base_amount'];
    stockUomRate = json['stock_uom_rate'];
    isFreeItem = json['is_free_item'];
    grantCommission = json['grant_commission'];
    netRate = json['net_rate'];
    taxableAmount = json['taxable_amount'];
    netAmount = json['net_amount'];
    totalAmount = json['total_amount'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];
    gstPercentage = json['gst_percentage'];
    baseNetRate = json['base_net_rate'];
    baseNetAmount = json['base_net_amount'];
    taxableValue = json['taxable_value'];
    deliveredBySupplier = json['delivered_by_supplier'];
    incomeAccount = json['income_account'];
    isFixedAsset = json['is_fixed_asset'];
    expenseAccount = json['expense_account'];
    enableDeferredRevenue = json['enable_deferred_revenue'];
    weightPerUnit = json['weight_per_unit'];
    totalWeight = json['total_weight'];
    warehouse = json['warehouse'];
    incomingRate = json['incoming_rate'];
    allowZeroValuationRate = json['allow_zero_valuation_rate'];
    itemTaxRate = json['item_tax_rate'];
    actualBatchQty = json['actual_batch_qty'];
    actualQty = json['actual_qty'];
    deliveredQty = json['delivered_qty'];
    costCenter = json['cost_center'];
    pageBreak = json['page_break'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
    pricingRules = json['pricing_rules'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['has_item_scanned'] = hasItemScanned;
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['description'] = description;
    data['gst_hsn_code'] = gstHsnCode;
    data['is_nil_exempt'] = isNilExempt;
    data['is_non_gst'] = isNonGst;
    data['item_group'] = itemGroup;
    data['image'] = image;
    data['qty'] = qty;
    data['stock_uom'] = stockUom;
    data['uom'] = uom;
    data['conversion_factor'] = conversionFactor;
    data['stock_qty'] = stockQty;
    data['price_list_rate'] = priceListRate;
    data['base_price_list_rate'] = basePriceListRate;
    data['margin_type'] = marginType;
    data['margin_rate_or_amount'] = marginRateOrAmount;
    data['rate_with_margin'] = rateWithMargin;
    data['discount_percentage'] = discountPercentage;
    data['discount_amount'] = discountAmount;
    data['base_rate_with_margin'] = baseRateWithMargin;
    data['rate'] = rate;
    data['amount'] = amount;
    data['tax_included_price'] = taxIncludedPrice;
    data['base_rate'] = baseRate;
    data['base_amount'] = baseAmount;
    data['stock_uom_rate'] = stockUomRate;
    data['is_free_item'] = isFreeItem;
    data['grant_commission'] = grantCommission;
    data['net_rate'] = netRate;
    data['taxable_amount'] = taxableAmount;
    data['net_amount'] = netAmount;
    data['total_amount'] = totalAmount;
    data['cgst'] = cgst;
    data['sgst'] = sgst;
    data['igst'] = igst;
    data['gst_percentage'] = gstPercentage;
    data['base_net_rate'] = baseNetRate;
    data['base_net_amount'] = baseNetAmount;
    data['taxable_value'] = taxableValue;
    data['delivered_by_supplier'] = deliveredBySupplier;
    data['income_account'] = incomeAccount;
    data['is_fixed_asset'] = isFixedAsset;
    data['expense_account'] = expenseAccount;
    data['enable_deferred_revenue'] = enableDeferredRevenue;
    data['weight_per_unit'] = weightPerUnit;
    data['total_weight'] = totalWeight;
    data['warehouse'] = warehouse;
    data['incoming_rate'] = incomingRate;
    data['allow_zero_valuation_rate'] = allowZeroValuationRate;
    data['item_tax_rate'] = itemTaxRate;
    data['actual_batch_qty'] = actualBatchQty;
    data['actual_qty'] = actualQty;
    data['delivered_qty'] = deliveredQty;
    data['cost_center'] = costCenter;
    data['page_break'] = pageBreak;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    data['pricing_rules'] = pricingRules;
    return data;
  }
}