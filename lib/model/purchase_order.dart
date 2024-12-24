class PurchaseOrderList {
  List<PurchaseOrder>? purchaseOrderList;

  PurchaseOrderList({this.purchaseOrderList});

  PurchaseOrderList.fromJson(Map<String, dynamic> json) {
    purchaseOrderList = List.from(json['purchase_order_list'])
        .map((e) => PurchaseOrder.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (purchaseOrderList != null) {
      data['purchase_order_list'] =
          purchaseOrderList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchaseOrder {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  String? parent;
  String? parentfield;
  String? parenttype;
  int? idx;
  String? namingSeries;
  String? otherChargesCalculation;
  double? roundingAdjustment;
  String? customerContactDisplay;
  String? status;
  String? contactDisplay;
  int? groupSameItems;
  String? supplierName;
  String? baseInWords;
  String? contactPerson;
  String? transactionDate;

  String? terms;
  String? customer;
  double? total;
  double? discountAmount;
  double? conversionRate;
  double? taxesAndChargesDeducted;
  double? taxesAndChargesAdded;
  String? scanBarcode;
  String? selectPrintHeading;
  String? addressDisplay;
  double? totalNetWeight;
  int? disableRoundedTotal;
  String? taxesAndCharges;
  String? paymentTermsTemplate;
  String? shippingAddress;

  String? supplier;
  String? customerContactPerson;
  String? refSq;
  String? company;
  String? partyAccountCurrency;
  String? shippingRule;
  String? setWarehouse;
  String? contactMobile;
  String? customerName;
  String? fromDate;
  String? interCompanyOrderReference;
  double? baseRoundedTotal;
  String? contactEmail;
  double? grandTotal;
  String? title;

  double? baseRoundingAdjustment;
  String? supplierAddress;
  double? totalQty;
  double? baseTaxesAndChargesAdded;
  String? letterHead;
  String? customerContactMobile;
  int? ignorePricingRule;
  String? buyingPriceList;
  double? baseTotalTaxesAndCharges;
  String? orderConfirmationNo;
  double? baseNetTotal;
  double? baseDiscountAmount;
  String? supplierWarehouse;
  double? netTotal;
  double? perReceived;

  int? isSubcontracted;
  String? applyDiscountOn;
  String? tcName;
  String? autoRepeat;
  String? priceListCurrency;
  String? inWords;
  String? shippingAddressDisplay;
  String? taxCategory;
  String? customerContactEmail;
  double? advancePaid;
  double? baseTaxesAndChargesDeducted;
  double? roundedTotal;
  String? currency;
  double? perBilled;
  String? amendedFrom;
  double? baseGrandTotal;
  double? additionalDiscountPercentage;
  double? totalTaxesAndCharges;
  String? orderConfirmationDate;
  String? scheduleDate;
  double? plcConversionRate;
  double? baseTotal;
  String? toDate;
  String? language;
  String? nUserTags;
  String? nComments;
  String? nAssign;
  String? nLikedBy;
  String? supplierGstin;
  String? companyGstin;
  String? placeOfSupply;
  String? setReserveWarehouse;
  String? workflowState;
  List<PurchaseOrderItems>? purchaseOrderItems;

  PurchaseOrder(
      {this.name,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.owner,
      this.docstatus,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.idx,
      this.namingSeries,
      this.otherChargesCalculation,
      this.roundingAdjustment,
      this.customerContactDisplay,
      this.status,
      this.contactDisplay,
      this.groupSameItems,
      this.supplierName,
      this.baseInWords,
      this.contactPerson,
      this.transactionDate,
      this.terms,
      this.customer,
      this.total,
      this.discountAmount,
      this.conversionRate,
      this.taxesAndChargesDeducted,
      this.taxesAndChargesAdded,
      this.scanBarcode,
      this.selectPrintHeading,
      this.addressDisplay,
      this.totalNetWeight,
      this.disableRoundedTotal,
      this.taxesAndCharges,
      this.paymentTermsTemplate,
      this.shippingAddress,
      this.supplier,
      this.customerContactPerson,
      this.refSq,
      this.company,
      this.partyAccountCurrency,
      this.shippingRule,
      this.setWarehouse,
      this.contactMobile,
      this.customerName,
      this.fromDate,
      this.interCompanyOrderReference,
      this.baseRoundedTotal,
      this.contactEmail,
      this.grandTotal,
      this.title,
      this.baseRoundingAdjustment,
      this.supplierAddress,
      this.totalQty,
      this.baseTaxesAndChargesAdded,
      this.letterHead,
      this.customerContactMobile,
      this.ignorePricingRule,
      this.buyingPriceList,
      this.baseTotalTaxesAndCharges,
      this.orderConfirmationNo,
      this.baseNetTotal,
      this.baseDiscountAmount,
      this.supplierWarehouse,
      this.netTotal,
      this.perReceived,
      this.isSubcontracted,
      this.applyDiscountOn,
      this.tcName,
      this.autoRepeat,
      this.priceListCurrency,
      this.inWords,
      this.shippingAddressDisplay,
      this.taxCategory,
      this.customerContactEmail,
      this.advancePaid,
      this.baseTaxesAndChargesDeducted,
      this.roundedTotal,
      this.currency,
      this.perBilled,
      this.amendedFrom,
      this.baseGrandTotal,
      this.additionalDiscountPercentage,
      this.totalTaxesAndCharges,
      this.orderConfirmationDate,
      this.scheduleDate,
      this.plcConversionRate,
      this.baseTotal,
      this.toDate,
      this.language,
      this.nUserTags,
      this.nComments,
      this.nAssign,
      this.nLikedBy,
      this.supplierGstin,
      this.companyGstin,
      this.placeOfSupply,
      this.setReserveWarehouse,
      this.workflowState,
      this.purchaseOrderItems});

  PurchaseOrder.fromJson(Map<String, dynamic> json) {
    var poi = <PurchaseOrderItems>[];
    if (json['items'] != null) {
      var list = json['items'] as List;
      for (var listJson in list) {
        poi.add(PurchaseOrderItems.fromJson(listJson));
      }
    }
    purchaseOrderItems = poi;
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    idx = json['idx'];
    namingSeries = json['naming_series'];
    otherChargesCalculation = json['other_charges_calculation'];

    roundingAdjustment = json['rounding_adjustment'];
    customerContactDisplay = json['customer_contact_display'];
    status = json['status'];
    contactDisplay = json['contact_display'];
    groupSameItems = json['group_same_items'];
    supplierName = json['supplier_name'];
    baseInWords = json['base_in_words'];
    contactPerson = json['contact_person'];
    transactionDate = json['transaction_date'];

    terms = json['terms'];
    customer = json['customer'];
    total = json['total'];
    discountAmount = json['discount_amount'];
    conversionRate = json['conversion_rate'];
    taxesAndChargesDeducted = json['taxes_and_charges_deducted'];
    taxesAndChargesAdded = json['taxes_and_charges_added'];
    scanBarcode = json['scan_barcode'];
    selectPrintHeading = json['select_print_heading'];
    addressDisplay = json['address_display'];
    totalNetWeight = json['total_net_weight'];
    disableRoundedTotal = json['disable_rounded_total'];
    taxesAndCharges = json['taxes_and_charges'];
    paymentTermsTemplate = json['payment_terms_template'];
    shippingAddress = json['shipping_address'];

    supplier = json['supplier'];
    customerContactPerson = json['customer_contact_person'];
    refSq = json['ref_sq'];
    company = json['company'];
    partyAccountCurrency = json['party_account_currency'];
    shippingRule = json['shipping_rule'];
    setWarehouse = json['set_warehouse'];
    contactMobile = json['contact_mobile'];
    customerName = json['customer_name'];
    fromDate = json['from_date'];
    interCompanyOrderReference = json['inter_company_order_reference'];
    baseRoundedTotal = json['base_rounded_total'];
    contactEmail = json['contact_email'];
    grandTotal = json['grand_total'];
    title = json['title'];

    baseRoundingAdjustment = json['base_rounding_adjustment'];
    supplierAddress = json['supplier_address'];
    totalQty = json['total_qty'];
    baseTaxesAndChargesAdded = json['base_taxes_and_charges_added'];
    letterHead = json['letter_head'];
    customerContactMobile = json['customer_contact_mobile'];
    ignorePricingRule = json['ignore_pricing_rule'];
    buyingPriceList = json['buying_price_list'];
    baseTotalTaxesAndCharges = json['base_total_taxes_and_charges'];
    orderConfirmationNo = json['order_confirmation_no'];
    baseNetTotal = json['base_net_total'];
    baseDiscountAmount = json['base_discount_amount'];
    supplierWarehouse = json['supplier_warehouse'];
    netTotal = json['net_total'];
    perReceived = json['per_received'];

    isSubcontracted = json['is_subcontracted'];
    applyDiscountOn = json['apply_discount_on'];
    tcName = json['tc_name'];
    autoRepeat = json['auto_repeat'];
    priceListCurrency = json['price_list_currency'];
    inWords = json['in_words'];
    shippingAddressDisplay = json['shipping_address_display'];
    taxCategory = json['tax_category'];
    customerContactEmail = json['customer_contact_email'];
    advancePaid = json['advance_paid'];
    baseTaxesAndChargesDeducted = json['base_taxes_and_charges_deducted'];
    roundedTotal = json['rounded_total'];
    currency = json['currency'];
    perBilled = json['per_billed'];

    amendedFrom = json['amended_from'];
    baseGrandTotal = json['base_grand_total'];
    additionalDiscountPercentage = json['additional_discount_percentage'];
    totalTaxesAndCharges = json['total_taxes_and_charges'];
    orderConfirmationDate = json['order_confirmation_date'];
    scheduleDate = json['schedule_date'];
    plcConversionRate = json['plc_conversion_rate'];
    baseTotal = json['base_total'];
    toDate = json['to_date'];
    language = json['language'];
    nUserTags = json['_user_tags'];
    nComments = json['_comments'];
    nAssign = json['_assign'];
    nLikedBy = json['_liked_by'];
    supplierGstin = json['supplier_gstin'];
    companyGstin = json['company_gstin'];
    placeOfSupply = json['place_of_supply'];
    setReserveWarehouse = json['set_reserve_warehouse'];
    workflowState = json['workflow_state'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;

    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['owner'] = owner;
    data['docstatus'] = docstatus;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['idx'] = idx;
    data['naming_series'] = namingSeries;
    data['other_charges_calculation'] = otherChargesCalculation;
    data['rounding_adjustment'] = roundingAdjustment;
    data['customer_contact_display'] = customerContactDisplay;
    data['status'] = status;
    data['contact_display'] = contactDisplay;
    data['group_same_items'] = groupSameItems;
    data['supplier_name'] = supplierName;
    data['base_in_words'] = baseInWords;
    data['contact_person'] = contactPerson;
    data['transaction_date'] = transactionDate;
    data['terms'] = terms;
    data['customer'] = customer;
    data['total'] = total;
    data['discount_amount'] = discountAmount;
    data['conversion_rate'] = conversionRate;
    data['taxes_and_charges_deducted'] = taxesAndChargesDeducted;
    data['taxes_and_charges_added'] = taxesAndChargesAdded;
    data['scan_barcode'] = scanBarcode;
    data['select_print_heading'] = selectPrintHeading;
    data['address_display'] = addressDisplay;
    data['total_net_weight'] = totalNetWeight;
    data['disable_rounded_total'] = disableRoundedTotal;
    data['taxes_and_charges'] = taxesAndCharges;
    data['payment_terms_template'] = paymentTermsTemplate;
    data['shipping_address'] = shippingAddress;
    data['supplier'] = supplier;
    data['customer_contact_person'] = customerContactPerson;
    data['ref_sq'] = refSq;
    data['company'] = company;
    data['party_account_currency'] = partyAccountCurrency;
    data['shipping_rule'] = shippingRule;
    data['set_warehouse'] = setWarehouse;
    data['contact_mobile'] = contactMobile;
    data['customer_name'] = customerName;
    data['from_date'] = fromDate;
    data['inter_company_order_reference'] = interCompanyOrderReference;
    data['base_rounded_total'] = baseRoundedTotal;
    data['contact_email'] = contactEmail;
    data['grand_total'] = grandTotal;
    data['title'] = title;
    data['base_rounding_adjustment'] = baseRoundingAdjustment;
    data['supplier_address'] = supplierAddress;
    data['total_qty'] = totalQty;
    data['base_taxes_and_charges_added'] = baseTaxesAndChargesAdded;
    data['letter_head'] = letterHead;
    data['customer_contact_mobile'] = customerContactMobile;
    data['ignore_pricing_rule'] = ignorePricingRule;
    data['buying_price_list'] = buyingPriceList;
    data['base_total_taxes_and_charges'] = baseTotalTaxesAndCharges;
    data['order_confirmation_no'] = orderConfirmationNo;
    data['base_net_total'] = baseNetTotal;
    data['base_discount_amount'] = baseDiscountAmount;
    data['supplier_warehouse'] = supplierWarehouse;
    data['net_total'] = netTotal;
    data['per_received'] = perReceived;
    data['is_subcontracted'] = isSubcontracted;
    data['apply_discount_on'] = applyDiscountOn;
    data['tc_name'] = tcName;
    data['auto_repeat'] = autoRepeat;
    data['price_list_currency'] = priceListCurrency;
    data['in_words'] = inWords;
    data['shipping_address_display'] = shippingAddressDisplay;
    data['tax_category'] = taxCategory;
    data['customer_contact_email'] = customerContactEmail;
    data['advance_paid'] = advancePaid;
    data['base_taxes_and_charges_deducted'] = baseTaxesAndChargesDeducted;
    data['rounded_total'] = roundedTotal;
    data['currency'] = currency;
    data['per_billed'] = perBilled;
    data['amended_from'] = amendedFrom;
    data['base_grand_total'] = baseGrandTotal;
    data['additional_discount_percentage'] = additionalDiscountPercentage;
    data['total_taxes_and_charges'] = totalTaxesAndCharges;
    data['order_confirmation_date'] = orderConfirmationDate;
    data['schedule_date'] = scheduleDate;
    data['plc_conversion_rate'] = plcConversionRate;
    data['base_total'] = baseTotal;
    data['to_date'] = toDate;
    data['language'] = language;
    data['_user_tags'] = nUserTags;
    data['_comments'] = nComments;
    data['_assign'] = nAssign;
    data['_liked_by'] = nLikedBy;
    data['supplier_gstin'] = supplierGstin;
    data['company_gstin'] = companyGstin;
    data['place_of_supply'] = placeOfSupply;
    data['set_reserve_warehouse'] = setReserveWarehouse;
    data['workflow_state'] = workflowState;

    return data;
  }
}

//ItemsModel class contains model to store data of Purchase Order api
class PurchaseOrderItems {
  String? itemCode;
  String? itemName;
  double? quantity;
  double? rate;
  double? quantityRecieved;
  double? amount;

  PurchaseOrderItems({
    this.itemCode,
    this.itemName,
    this.quantity,
    this.quantityRecieved,
    this.amount,
    this.rate,
  });

  //For fetching json data from purchase order api and storing it in items model
  PurchaseOrderItems.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'] ?? '';
    itemName = json['item_name'] ?? '';
    quantity = json['qty'] ?? 0.0;
    rate = json['rate'] ?? 0.0;
    quantityRecieved = json['received_qty'] ?? 0.0;
    amount = json['amount'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['qty'] = quantity;
    data['rate'] = rate;
    data['received_qty'] = quantityRecieved;
    data['amount'] = amount;
    return data;
  }
}
