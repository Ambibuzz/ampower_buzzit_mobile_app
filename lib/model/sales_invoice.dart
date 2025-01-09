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
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? title;
  String? namingSeries;
  String? customer;
  
  int? irnCancelled;
  int? ewayBillCancelled;
  String? customerName;
  String? company;
  String? postingDate;
  String? postingTime;
  int? setPostingTime;
  String? dueDate;
  int? isPos;
  int? isConsolidated;
  int? isReturn;
  int? updateBilledAmountInSalesOrder;
  int? isDebitNote;
  int? isReverseCharge;
  int? isExportWithGst;
  
  String? project;
  String? currency;
  double? conversionRate;
  String? sellingPriceList;
  String? priceListCurrency;
  double? plcConversionRate;
  int? ignorePricingRule;
  int? updateStock;
  double? totalQty;
  double? totalNetWeight;
  
  double? baseTotal;
  double? baseNetTotal;
  double? total;
  double? netTotal;
  String? taxCategory;
  double? baseTotalTaxesAndCharges;
  double? totalTaxesAndCharges;
  double? baseGrandTotal;
  double? baseRoundingAdjustment;
  double? baseRoundedTotal;
  String? baseInWords;
  double? grandTotal;
  double? roundingAdjustment;
  int? useCompanyRoundoffCostCenter;
  double? roundedTotal;
  
  String? inWords;
  double? totalAdvance;
  double? outstandingAmount;
  int? disableRoundedTotal;
  String? applyDiscountOn;
  double? baseDiscountAmount;
  int? isCashOrNonTradeDiscount;
  double? additionalDiscountPercentage;
  double? discountAmount;
  double? totalBillingHours;
  double? totalBillingAmount;
  double? basePaidAmount;
  double? paidAmount;
  double? baseChangeAmount;
  double? changeAmount;
  int? allocateAdvancesAutomatically;
  int? onlyIncludeAllocatedPayments;
  double? writeOffAmount;
  double? baseWriteOffAmount;
  int? writeOffOutstandingAmountAutomatically;
  int? redeemLoyaltyPoints;
  int? loyaltyPoints;
  double? loyaltyAmount;
  
  String? customerAddress;
  String? addressDisplay;
  String? territory;
  String? placeOfSupply;
  String? companyAddress;
  String? companyAddressDisplay;
  int? ignoreDefaultPaymentTermsTemplate;
  String? paymentTermsTemplate;
  String? poNo;
  String? poDate;
  String? debitTo;
  String? partyAccountCurrency;
  String? isOpening;
  String? againstIncomeAccount;
  double? distance;
  String? einvoiceStatus;
  String? exportType;
  String? gstVehicleType;
  String? invoiceCopy;
  String? lrDate;
  String? modeOfTransport;
  String? reasonForIssuingDocument;
  String? reverseCharge;
  
  double? amountEligibleForCommission;
  double? commissionRate;
  double? totalCommission;
  int? groupSameItems;
  String? language;
  String? gstCategory;
  String? status;
  String? customerGroup;
  int? isInternalCustomer;
  int? isDiscounted;
  String? remarks;
  int? repostRequired;
  String? doctype;
  // List<Null>? taxes;
  // List<Null>? timesheets;
  // List<Null>? packedItems;
  List<PaymentSchedule>? paymentSchedule;
  // List<Null>? payments;
  // List<Null>? advances;
  // List<Items>? items;
  // List<Null>? salesTeam;
  List<PricingRules>? pricingRules;
  

  SalesInvoice(
      {name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.title,
      this.namingSeries,
      this.customer,
      
      this.irnCancelled,
      this.ewayBillCancelled,
      this.customerName,
      this.company,
      this.postingDate,
      this.postingTime,
      this.setPostingTime,
      this.dueDate,
      this.isPos,
      this.isConsolidated,
      this.isReturn,
      this.updateBilledAmountInSalesOrder,
      this.isDebitNote,
      this.isReverseCharge,
      this.isExportWithGst,
      
      this.project,
      this.currency,
      this.conversionRate,
      this.sellingPriceList,
      this.priceListCurrency,
      this.plcConversionRate,
      this.ignorePricingRule,
      this.updateStock,
      this.totalQty,
      this.totalNetWeight,
      
      this.baseTotal,
      this.baseNetTotal,
      this.total,
      this.netTotal,
      this.taxCategory,
      this.baseTotalTaxesAndCharges,
      this.totalTaxesAndCharges,
      this.baseGrandTotal,
      this.baseRoundingAdjustment,
      this.baseRoundedTotal,
      this.baseInWords,
      this.grandTotal,
      this.roundingAdjustment,
      this.useCompanyRoundoffCostCenter,
      this.roundedTotal,
      
      this.inWords,
      this.totalAdvance,
      this.outstandingAmount,
      this.disableRoundedTotal,
      this.applyDiscountOn,
      this.baseDiscountAmount,
      this.isCashOrNonTradeDiscount,
      this.additionalDiscountPercentage,
      this.discountAmount,
      this.totalBillingHours,
      this.totalBillingAmount,
      this.basePaidAmount,
      this.paidAmount,
      this.baseChangeAmount,
      this.changeAmount,
      this.allocateAdvancesAutomatically,
      this.onlyIncludeAllocatedPayments,
      this.writeOffAmount,
      this.baseWriteOffAmount,
      this.writeOffOutstandingAmountAutomatically,
      this.redeemLoyaltyPoints,
      this.loyaltyPoints,
      this.loyaltyAmount,
      
      this.customerAddress,
      this.addressDisplay,
      this.territory,
      this.placeOfSupply,
      this.companyAddress,
      this.companyAddressDisplay,
      this.ignoreDefaultPaymentTermsTemplate,
      this.paymentTermsTemplate,
      this.poNo,
      this.poDate,
      this.debitTo,
      this.partyAccountCurrency,
      this.isOpening,
      this.againstIncomeAccount,
      this.distance,
      this.einvoiceStatus,
      this.exportType,
      this.gstVehicleType,
      this.invoiceCopy,
      this.lrDate,
      this.modeOfTransport,
      this.reasonForIssuingDocument,
      this.reverseCharge,
      this.amountEligibleForCommission,
      this.commissionRate,
      this.totalCommission,
      this.groupSameItems,
      this.language,
      this.gstCategory,
      this.status,
      this.customerGroup,
      this.isInternalCustomer,
      this.isDiscounted,
      this.remarks,
      this.repostRequired,
      this.doctype,
      // this.taxes,
      // this.timesheets,
      // this.packedItems,
      this.paymentSchedule,
      // this.payments,
      // this.advances,
      // this.items,
      // this.salesTeam,
      this.pricingRules,
      });

  SalesInvoice.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    title = json['title'];
    namingSeries = json['naming_series'];
    customer = json['customer'];
    
    irnCancelled = json['irn_cancelled'];
    ewayBillCancelled = json['eway_bill_cancelled'];
    customerName = json['customer_name'];
    company = json['company'];
    postingDate = json['posting_date'];
    postingTime = json['posting_time'];
    setPostingTime = json['set_posting_time'];
    dueDate = json['due_date'];
    isPos = json['is_pos'];
    isConsolidated = json['is_consolidated'];
    isReturn = json['is_return'];
    updateBilledAmountInSalesOrder =
        json['update_billed_amount_in_sales_order'];
    isDebitNote = json['is_debit_note'];
    isReverseCharge = json['is_reverse_charge'];
    isExportWithGst = json['is_export_with_gst'];
    
    project = json['project'];
    currency = json['currency'];
    conversionRate = json['conversion_rate'];
    sellingPriceList = json['selling_price_list'];
    priceListCurrency = json['price_list_currency'];
    plcConversionRate = json['plc_conversion_rate'];
    ignorePricingRule = json['ignore_pricing_rule'];
    updateStock = json['update_stock'];
    totalQty = json['total_qty'];
    totalNetWeight = json['total_net_weight'];
    
    baseTotal = json['base_total'];
    baseNetTotal = json['base_net_total'];
    total = json['total'];
    netTotal = json['net_total'];
    taxCategory = json['tax_category'];
    baseTotalTaxesAndCharges = json['base_total_taxes_and_charges'];
    totalTaxesAndCharges = json['total_taxes_and_charges'];
    baseGrandTotal = json['base_grand_total'];
    baseRoundingAdjustment = json['base_rounding_adjustment'];
    baseRoundedTotal = json['base_rounded_total'];
    baseInWords = json['base_in_words'];
    grandTotal = json['grand_total'];
    roundingAdjustment = json['rounding_adjustment'];
    useCompanyRoundoffCostCenter = json['use_company_roundoff_cost_center'];
    roundedTotal = json['rounded_total'];
    
    inWords = json['in_words'];
    totalAdvance = json['total_advance'];
    outstandingAmount = json['outstanding_amount'];
    disableRoundedTotal = json['disable_rounded_total'];
    applyDiscountOn = json['apply_discount_on'];
    baseDiscountAmount = json['base_discount_amount'];
    isCashOrNonTradeDiscount = json['is_cash_or_non_trade_discount'];
    additionalDiscountPercentage = json['additional_discount_percentage'];
    discountAmount = json['discount_amount'];
    totalBillingHours = json['total_billing_hours'];
    totalBillingAmount = json['total_billing_amount'];
    basePaidAmount = json['base_paid_amount'];
    paidAmount = json['paid_amount'];
    baseChangeAmount = json['base_change_amount'];
    changeAmount = json['change_amount'];
    allocateAdvancesAutomatically = json['allocate_advances_automatically'];
    onlyIncludeAllocatedPayments = json['only_include_allocated_payments'];
    writeOffAmount = json['write_off_amount'];
    baseWriteOffAmount = json['base_write_off_amount'];
    writeOffOutstandingAmountAutomatically =
        json['write_off_outstanding_amount_automatically'];
    redeemLoyaltyPoints = json['redeem_loyalty_points'];
    loyaltyPoints = json['loyalty_points'];
    loyaltyAmount = json['loyalty_amount'];
    
    customerAddress = json['customer_address'];
    addressDisplay = json['address_display'];
    territory = json['territory'];
    placeOfSupply = json['place_of_supply'];
    companyAddress = json['company_address'];
    companyAddressDisplay = json['company_address_display'];
    ignoreDefaultPaymentTermsTemplate =
        json['ignore_default_payment_terms_template'];
    paymentTermsTemplate = json['payment_terms_template'];
    poNo = json['po_no'];
    poDate = json['po_date'];
    debitTo = json['debit_to'];
    partyAccountCurrency = json['party_account_currency'];
    isOpening = json['is_opening'];
    againstIncomeAccount = json['against_income_account'];
    distance = json['distance'];
    einvoiceStatus = json['einvoice_status'];
    exportType = json['export_type'];
    gstVehicleType = json['gst_vehicle_type'];
    invoiceCopy = json['invoice_copy'];
    lrDate = json['lr_date'];
    modeOfTransport = json['mode_of_transport'];
    reasonForIssuingDocument = json['reason_for_issuing_document'];
    reverseCharge = json['reverse_charge'];
    amountEligibleForCommission = json['amount_eligible_for_commission'];
    commissionRate = json['commission_rate'];
    totalCommission = json['total_commission'];
    groupSameItems = json['group_same_items'];
    language = json['language'];
    gstCategory = json['gst_category'];
    status = json['status'];
    customerGroup = json['customer_group'];
    isInternalCustomer = json['is_internal_customer'];
    isDiscounted = json['is_discounted'];
    remarks = json['remarks'];
    repostRequired = json['repost_required'];
    doctype = json['doctype'];
    // if (json['taxes'] != null) {
    //   taxes = <Null>[];
    //   json['taxes'].forEach((v) {
    //     taxes!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['timesheets'] != null) {
    //   timesheets = <Null>[];
    //   json['timesheets'].forEach((v) {
    //     timesheets!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['packed_items'] != null) {
    //   packedItems = <Null>[];
    //   json['packed_items'].forEach((v) {
    //     packedItems!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['payment_schedule'] != null) {
      paymentSchedule = <PaymentSchedule>[];
      json['payment_schedule'].forEach((v) {
        paymentSchedule!.add( PaymentSchedule.fromJson(v));
      });
    }
    // if (json['payments'] != null) {
    //   payments = <Null>[];
    //   json['payments'].forEach((v) {
    //     payments!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['advances'] != null) {
    //   advances = <Null>[];
    //   json['advances'].forEach((v) {
    //     advances!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['items'] != null) {
    //   items = <Items>[];
    //   json['items'].forEach((v) {
    //     items!.add( Items.fromJson(v));
    //   });
    // }
    // if (json['sales_team'] != null) {
    //   salesTeam = <Null>[];
    //   json['sales_team'].forEach((v) {
    //     salesTeam!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['pricing_rules'] != null) {
      pricingRules = <PricingRules>[];
      json['pricing_rules'].forEach((v) {
        pricingRules!.add( PricingRules.fromJson(v));
      });
    }
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
    data['title'] = title;
    data['naming_series'] = namingSeries;
    data['customer'] = customer;
    data['irn_cancelled'] = irnCancelled;
    data['eway_bill_cancelled'] = ewayBillCancelled;
    data['customer_name'] = customerName;
    data['company'] = company;
    data['posting_date'] = postingDate;
    data['posting_time'] = postingTime;
    data['set_posting_time'] = setPostingTime;
    data['due_date'] = dueDate;
    data['is_pos'] = isPos;
    data['is_consolidated'] = isConsolidated;
    data['is_return'] = isReturn;
    data['update_billed_amount_in_sales_order'] =
        updateBilledAmountInSalesOrder;
    data['is_debit_note'] = isDebitNote;
    data['is_reverse_charge'] = isReverseCharge;
    data['is_export_with_gst'] = isExportWithGst;
    data['project'] = project;
    data['currency'] = currency;
    data['conversion_rate'] = conversionRate;
    data['selling_price_list'] = sellingPriceList;
    data['price_list_currency'] = priceListCurrency;
    data['plc_conversion_rate'] = plcConversionRate;
    data['ignore_pricing_rule'] = ignorePricingRule;
    data['update_stock'] = updateStock;
    data['total_qty'] = totalQty;
    data['total_net_weight'] = totalNetWeight;
    data['base_total'] = baseTotal;
    data['base_net_total'] = baseNetTotal;
    data['total'] = total;
    data['net_total'] = netTotal;
    data['tax_category'] = taxCategory;
    data['base_total_taxes_and_charges'] = baseTotalTaxesAndCharges;
    data['total_taxes_and_charges'] = totalTaxesAndCharges;
    data['base_grand_total'] = baseGrandTotal;
    data['base_rounding_adjustment'] = baseRoundingAdjustment;
    data['base_rounded_total'] = baseRoundedTotal;
    data['base_in_words'] = baseInWords;
    data['grand_total'] = grandTotal;
    data['rounding_adjustment'] = roundingAdjustment;
    data['use_company_roundoff_cost_center'] = useCompanyRoundoffCostCenter;
    data['rounded_total'] = roundedTotal;
    data['in_words'] = inWords;
    data['total_advance'] = totalAdvance;
    data['outstanding_amount'] = outstandingAmount;
    data['disable_rounded_total'] = disableRoundedTotal;
    data['apply_discount_on'] = applyDiscountOn;
    data['base_discount_amount'] = baseDiscountAmount;
    data['is_cash_or_non_trade_discount'] = isCashOrNonTradeDiscount;
    data['additional_discount_percentage'] = additionalDiscountPercentage;
    data['discount_amount'] = discountAmount;
    data['total_billing_hours'] = totalBillingHours;
    data['total_billing_amount'] = totalBillingAmount;
    data['base_paid_amount'] = basePaidAmount;
    data['paid_amount'] = paidAmount;
    data['base_change_amount'] = baseChangeAmount;
    data['change_amount'] = changeAmount;
    data['allocate_advances_automatically'] = allocateAdvancesAutomatically;
    data['only_include_allocated_payments'] = onlyIncludeAllocatedPayments;
    data['write_off_amount'] = writeOffAmount;
    data['base_write_off_amount'] = baseWriteOffAmount;
    data['write_off_outstanding_amount_automatically'] =
        writeOffOutstandingAmountAutomatically;
    data['redeem_loyalty_points'] = redeemLoyaltyPoints;
    data['loyalty_points'] = loyaltyPoints;
    data['loyalty_amount'] = loyaltyAmount;
    data['customer_address'] = customerAddress;
    data['address_display'] = addressDisplay;
    data['territory'] = territory;
    data['place_of_supply'] = placeOfSupply;
    data['company_address'] = companyAddress;
    data['company_address_display'] = companyAddressDisplay;
    data['ignore_default_payment_terms_template'] =
        ignoreDefaultPaymentTermsTemplate;
    data['payment_terms_template'] = paymentTermsTemplate;
    data['po_no'] = poNo;
    data['po_date'] = poDate;
    data['debit_to'] = debitTo;
    data['party_account_currency'] = partyAccountCurrency;
    data['is_opening'] = isOpening;
    data['against_income_account'] = againstIncomeAccount;
    data['distance'] = distance;
    data['einvoice_status'] = einvoiceStatus;
    data['export_type'] = exportType;
    data['gst_vehicle_type'] = gstVehicleType;
    data['invoice_copy'] = invoiceCopy;
    data['lr_date'] = lrDate;
    data['mode_of_transport'] = modeOfTransport;
    data['reason_for_issuing_document'] = reasonForIssuingDocument;
    data['reverse_charge'] = reverseCharge;
    data['amount_eligible_for_commission'] = amountEligibleForCommission;
    data['commission_rate'] = commissionRate;
    data['total_commission'] = totalCommission;
    data['group_same_items'] = groupSameItems;
    data['language'] = language;
    data['gst_category'] = gstCategory;
    data['status'] = status;
    data['customer_group'] = customerGroup;
    data['is_internal_customer'] = isInternalCustomer;
    data['is_discounted'] = isDiscounted;
    data['remarks'] = remarks;
    data['repost_required'] = repostRequired;
    data['doctype'] = doctype;
    // if (taxes != null) {
    //   data['taxes'] = taxes!.map((v) => v.toJson()).toList();
    // }
    // if (timesheets != null) {
    //   data['timesheets'] = timesheets!.map((v) => v.toJson()).toList();
    // }
    // if (packedItems != null) {
    //   data['packed_items'] = packedItems!.map((v) => v.toJson()).toList();
    // }
    if (paymentSchedule != null) {
      data['payment_schedule'] =
          paymentSchedule!.map((v) => v.toJson()).toList();
    }
    // if (payments != null) {
    //   data['payments'] = payments!.map((v) => v.toJson()).toList();
    // }
    // if (advances != null) {
    //   data['advances'] = advances!.map((v) => v.toJson()).toList();
    // }
    // if (items != null) {
    //   data['items'] = items!.map((v) => v.toJson()).toList();
    // }
    // if (salesTeam != null) {
    //   data['sales_team'] = salesTeam!.map((v) => v.toJson()).toList();
    // }
    if (pricingRules != null) {
      data['pricing_rules'] = pricingRules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentSchedule {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? paymentTerm;
  String? dueDate;
  double? invoicePortion;
  String? discountType;
  String? discountDate;
  double? discount;
  double? paymentAmount;
  double? outstanding;
  double? paidAmount;
  double? discountedAmount;
  double? basePaymentAmount;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  PaymentSchedule(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.paymentTerm,
      this.dueDate,
      this.invoicePortion,
      this.discountType,
      this.discountDate,
      this.discount,
      this.paymentAmount,
      this.outstanding,
      this.paidAmount,
      this.discountedAmount,
      this.basePaymentAmount,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  PaymentSchedule.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    paymentTerm = json['payment_term'];
    dueDate = json['due_date'];
    invoicePortion = json['invoice_portion'];
    discountType = json['discount_type'];
    discountDate = json['discount_date'];
    discount = json['discount'];
    paymentAmount = json['payment_amount'];
    outstanding = json['outstanding'];
    paidAmount = json['paid_amount'];
    discountedAmount = json['discounted_amount'];
    basePaymentAmount = json['base_payment_amount'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
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
    data['payment_term'] = paymentTerm;
    data['due_date'] = dueDate;
    data['invoice_portion'] = invoicePortion;
    data['discount_type'] = discountType;
    data['discount_date'] = discountDate;
    data['discount'] = discount;
    data['payment_amount'] = paymentAmount;
    data['outstanding'] = outstanding;
    data['paid_amount'] = paidAmount;
    data['discounted_amount'] = discountedAmount;
    data['base_payment_amount'] = basePaymentAmount;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
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

class PricingRules {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? pricingRule;
  String? itemCode;
  String? childDocname;
  int? ruleApplied;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  PricingRules(
      {this.name,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.pricingRule,
      this.itemCode,
      this.childDocname,
      this.ruleApplied,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  PricingRules.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    pricingRule = json['pricing_rule'];
    itemCode = json['item_code'];
    childDocname = json['child_docname'];
    ruleApplied = json['rule_applied'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['pricing_rule'] = pricingRule;
    data['item_code'] = itemCode;
    data['child_docname'] = childDocname;
    data['rule_applied'] = ruleApplied;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}
