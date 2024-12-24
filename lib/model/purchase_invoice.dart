class PurchaseInvoiceList {
  List<PurchaseInvoice>? purchaseInvoiceList;

  PurchaseInvoiceList({this.purchaseInvoiceList});

  PurchaseInvoiceList.fromJson(Map<String, dynamic> json) {
    purchaseInvoiceList = List.from(json['purchase_invoice_list'])
        .map((e) => PurchaseInvoice.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (PurchaseInvoiceList != null) {
      data['purchase_invoice_list'] =
          purchaseInvoiceList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchaseInvoice {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? title;
  String? namingSeries;
  String? supplier;
  String? supplierName;
  String? company;
  String? postingDate;
  String? postingTime;
  
  int? setPostingTime;
  String? dueDate;
  int? isPaid;
  int? isReturn;
  int? applyTds;
  int? isReverseCharge;
  String? currency;
  double? conversionRate;
  String? buyingPriceList;
  String? priceListCurrency;
  double? plcConversionRate;
  int? ignorePricingRule;
  int? updateStock;
  int? isSubcontracted;
  double? totalQty;
  double? totalNetWeight;
  double? baseTotal;
  double? baseNetTotal;
  double? total;
  double? netTotal;
  double? taxWithholdingNetTotal;
  double? baseTaxWithholdingNetTotal;
  
  String? taxCategory;
  String? taxesAndCharges;
  double? baseTaxesAndChargesAdded;
  double? baseTaxesAndChargesDeducted;
  double? baseTotalTaxesAndCharges;
  double? taxesAndChargesAdded;
  double? taxesAndChargesDeducted;
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
  double? additionalDiscountPercentage;
  double? discountAmount;
  double? basePaidAmount;
  double? paidAmount;
  int? allocateAdvancesAutomatically;
  int? onlyIncludeAllocatedPayments;
  double? writeOffAmount;
  double? baseWriteOffAmount;
  
  String? gstCategory;
  String? shippingAddress;
  String? shippingAddressDisplay;
  String? billingAddress;
  String? billingAddressDisplay;
  int? ignoreDefaultPaymentTermsTemplate;
  String? status;
  double? perReceived;
  String? creditTo;
  String? partyAccountCurrency;
  String? isOpening;
  String? againstExpenseAccount;
  int? groupSameItems;
  String? language;
  String? eligibilityForItc;
  double? itcIntegratedTax;
  double? itcCentralTax;
  double? itcStateTax;
  double? itcCessAmount;
  int? onHold;
  int? isInternalSupplier;
  String? representsCompany;
  int? isOldSubcontractingFlow;
  String? remarks;
  String? doctype;
  // List<Null>? taxes;
  List<PaymentSchedule>? paymentSchedule;
  // List<Null>? suppliedItems;
  // List<Null>? taxWithheldVouchers;
  // List<Null>? advances;
  List<Items>? items;
  // List<Null>? pricingRules;
  // List<Null>? advanceTax;
  

  PurchaseInvoice({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.title,
    this.namingSeries,
    this.supplier,
    this.supplierName,
    this.company,
    this.postingDate,
    this.postingTime,
    
    this.setPostingTime,
    this.dueDate,
    this.isPaid,
    this.isReturn,
    this.applyTds,
    this.isReverseCharge,
    this.currency,
    this.conversionRate,
    this.buyingPriceList,
    this.priceListCurrency,
    this.plcConversionRate,
    this.ignorePricingRule,
    this.updateStock,
    this.isSubcontracted,
    this.totalQty,
    this.totalNetWeight,
    this.baseTotal,
    this.baseNetTotal,
    this.total,
    this.netTotal,
    this.taxWithholdingNetTotal,
    this.baseTaxWithholdingNetTotal,
    
    this.taxCategory,
    this.taxesAndCharges,
    this.baseTaxesAndChargesAdded,
    this.baseTaxesAndChargesDeducted,
    this.baseTotalTaxesAndCharges,
    this.taxesAndChargesAdded,
    this.taxesAndChargesDeducted,
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
    this.additionalDiscountPercentage,
    this.discountAmount,
    this.basePaidAmount,
    this.paidAmount,
    this.allocateAdvancesAutomatically,
    this.onlyIncludeAllocatedPayments,
    this.writeOffAmount,
    this.baseWriteOffAmount,
    this.gstCategory,
    this.shippingAddress,
    this.shippingAddressDisplay,
    this.billingAddress,
    this.billingAddressDisplay,
    this.ignoreDefaultPaymentTermsTemplate,
    this.status,
    this.perReceived,
    this.creditTo,
    this.partyAccountCurrency,
    this.isOpening,
    this.againstExpenseAccount,
    this.groupSameItems,
    this.language,
    this.eligibilityForItc,
    this.itcIntegratedTax,
    this.itcCentralTax,
    this.itcStateTax,
    this.itcCessAmount,
    this.onHold,
    this.isInternalSupplier,
    this.representsCompany,
    this.isOldSubcontractingFlow,
    this.remarks,
    this.doctype,
    // this.taxes,
    this.paymentSchedule,
    // this.suppliedItems,
    // this.taxWithheldVouchers,
    // this.advances,
    this.items,
    // this.pricingRules,
    // this.advanceTax,
  });

  PurchaseInvoice.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    title = json['title'];
    namingSeries = json['naming_series'];
    supplier = json['supplier'];
    supplierName = json['supplier_name'];
    company = json['company'];
    postingDate = json['posting_date'];
    postingTime = json['posting_time'];
    
    setPostingTime = json['set_posting_time'];
    dueDate = json['due_date'];
    isPaid = json['is_paid'];
    isReturn = json['is_return'];
    applyTds = json['apply_tds'];
    isReverseCharge = json['is_reverse_charge'];
    currency = json['currency'];
    conversionRate = json['conversion_rate'];
    buyingPriceList = json['buying_price_list'];
    priceListCurrency = json['price_list_currency'];
    plcConversionRate = json['plc_conversion_rate'];
    ignorePricingRule = json['ignore_pricing_rule'];
    updateStock = json['update_stock'];
    isSubcontracted = json['is_subcontracted'];
    totalQty = json['total_qty'];
    totalNetWeight = json['total_net_weight'];
    baseTotal = json['base_total'];
    baseNetTotal = json['base_net_total'];
    total = json['total'];
    netTotal = json['net_total'];
    taxWithholdingNetTotal = json['tax_withholding_net_total'];
    baseTaxWithholdingNetTotal = json['base_tax_withholding_net_total'];
    
    taxCategory = json['tax_category'];
    taxesAndCharges = json['taxes_and_charges'];
    baseTaxesAndChargesAdded = json['base_taxes_and_charges_added'];
    baseTaxesAndChargesDeducted = json['base_taxes_and_charges_deducted'];
    baseTotalTaxesAndCharges = json['base_total_taxes_and_charges'];
    taxesAndChargesAdded = json['taxes_and_charges_added'];
    taxesAndChargesDeducted = json['taxes_and_charges_deducted'];
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
    additionalDiscountPercentage = json['additional_discount_percentage'];
    discountAmount = json['discount_amount'];
    basePaidAmount = json['base_paid_amount'];
    paidAmount = json['paid_amount'];
    allocateAdvancesAutomatically = json['allocate_advances_automatically'];
    onlyIncludeAllocatedPayments = json['only_include_allocated_payments'];
    writeOffAmount = json['write_off_amount'];
    baseWriteOffAmount = json['base_write_off_amount'];
    gstCategory = json['gst_category'];
    shippingAddress = json['shipping_address'];
    shippingAddressDisplay = json['shipping_address_display'];
    billingAddress = json['billing_address'];
    billingAddressDisplay = json['billing_address_display'];
    ignoreDefaultPaymentTermsTemplate =
        json['ignore_default_payment_terms_template'];
    status = json['status'];
    perReceived = json['per_received'];
    creditTo = json['credit_to'];
    partyAccountCurrency = json['party_account_currency'];
    isOpening = json['is_opening'];
    againstExpenseAccount = json['against_expense_account'];
    groupSameItems = json['group_same_items'];
    language = json['language'];
    eligibilityForItc = json['eligibility_for_itc'];
    itcIntegratedTax = json['itc_integrated_tax'];
    itcCentralTax = json['itc_central_tax'];
    itcStateTax = json['itc_state_tax'];
    itcCessAmount = json['itc_cess_amount'];
    onHold = json['on_hold'];
    isInternalSupplier = json['is_internal_supplier'];
    representsCompany = json['represents_company'];
    isOldSubcontractingFlow = json['is_old_subcontracting_flow'];
    remarks = json['remarks'];
    doctype = json['doctype'];
    // if (json['taxes'] != null) {
    //   taxes = <Null>[];
    //   json['taxes'].forEach((v) {
    //     taxes!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['payment_schedule'] != null) {
      paymentSchedule = <PaymentSchedule>[];
      json['payment_schedule'].forEach((v) {
        paymentSchedule!.add(PaymentSchedule.fromJson(v));
      });
    }
    // if (json['supplied_items'] != null) {
    //   suppliedItems = <Null>[];
    //   json['supplied_items'].forEach((v) {
    //     suppliedItems!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['tax_withheld_vouchers'] != null) {
    //   taxWithheldVouchers = <Null>[];
    //   json['tax_withheld_vouchers'].forEach((v) {
    //     taxWithheldVouchers!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['advances'] != null) {
    //   advances = <Null>[];
    //   json['advances'].forEach((v) {
    //     advances!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    // if (json['pricing_rules'] != null) {
    //   pricingRules = <Null>[];
    //   json['pricing_rules'].forEach((v) {
    //     pricingRules!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['advance_tax'] != null) {
    //   advanceTax = <Null>[];
    //   json['advance_tax'].forEach((v) {
    //     advanceTax!.add(new Null.fromJson(v));
    //   });
    // }
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
    data['supplier'] = supplier;
    data['supplier_name'] = supplierName;
    data['company'] = company;
    data['posting_date'] = postingDate;
    data['posting_time'] = postingTime;
    data['set_posting_time'] = setPostingTime;
    data['due_date'] = dueDate;
    data['is_paid'] = isPaid;
    data['is_return'] = isReturn;
    data['apply_tds'] = applyTds;
    data['is_reverse_charge'] = isReverseCharge;
    data['currency'] = currency;
    data['conversion_rate'] = conversionRate;
    data['buying_price_list'] = buyingPriceList;
    data['price_list_currency'] = priceListCurrency;
    data['plc_conversion_rate'] = plcConversionRate;
    data['ignore_pricing_rule'] = ignorePricingRule;
    data['update_stock'] = updateStock;
    data['is_subcontracted'] = isSubcontracted;
    data['total_qty'] = totalQty;
    data['total_net_weight'] = totalNetWeight;
    data['base_total'] = baseTotal;
    data['base_net_total'] = baseNetTotal;
    data['total'] = total;
    data['net_total'] = netTotal;
    data['tax_withholding_net_total'] = taxWithholdingNetTotal;
    data['base_tax_withholding_net_total'] = baseTaxWithholdingNetTotal;
    data['tax_category'] = taxCategory;
    data['taxes_and_charges'] = taxesAndCharges;
    data['base_taxes_and_charges_added'] = baseTaxesAndChargesAdded;
    data['base_taxes_and_charges_deducted'] = baseTaxesAndChargesDeducted;
    data['base_total_taxes_and_charges'] = baseTotalTaxesAndCharges;
    data['taxes_and_charges_added'] = taxesAndChargesAdded;
    data['taxes_and_charges_deducted'] = taxesAndChargesDeducted;
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
    data['additional_discount_percentage'] = additionalDiscountPercentage;
    data['discount_amount'] = discountAmount;
    data['base_paid_amount'] = basePaidAmount;
    data['paid_amount'] = paidAmount;
    data['allocate_advances_automatically'] = allocateAdvancesAutomatically;
    data['only_include_allocated_payments'] = onlyIncludeAllocatedPayments;
    data['write_off_amount'] = writeOffAmount;
    data['base_write_off_amount'] = baseWriteOffAmount;
    data['gst_category'] = gstCategory;
    data['shipping_address'] = shippingAddress;
    data['shipping_address_display'] = shippingAddressDisplay;
    data['billing_address'] = billingAddress;
    data['billing_address_display'] = billingAddressDisplay;
    data['ignore_default_payment_terms_template'] =
        ignoreDefaultPaymentTermsTemplate;
    data['status'] = status;
    data['per_received'] = perReceived;
    data['credit_to'] = creditTo;
    data['party_account_currency'] = partyAccountCurrency;
    data['is_opening'] = isOpening;
    data['against_expense_account'] = againstExpenseAccount;
    data['group_same_items'] = groupSameItems;
    data['language'] = language;
    data['eligibility_for_itc'] = eligibilityForItc;
    data['itc_integrated_tax'] = itcIntegratedTax;
    data['itc_central_tax'] = itcCentralTax;
    data['itc_state_tax'] = itcStateTax;
    data['itc_cess_amount'] = itcCessAmount;
    data['on_hold'] = onHold;
    data['is_internal_supplier'] = isInternalSupplier;
    data['represents_company'] = representsCompany;
    data['is_old_subcontracting_flow'] = isOldSubcontractingFlow;
    data['remarks'] = remarks;
    data['doctype'] = doctype;
    // if (taxes != null) {
    //   data['taxes'] = taxes!.map((v) => v.toJson()).toList();
    // }
    if (paymentSchedule != null) {
      data['payment_schedule'] =
          paymentSchedule!.map((v) => v.toJson()).toList();
    }
    // if (suppliedItems != null) {
    //   data['supplied_items'] =
    //       suppliedItems!.map((v) => v.toJson()).toList();
    // }
    // if (taxWithheldVouchers != null) {
    //   data['tax_withheld_vouchers'] =
    //       taxWithheldVouchers!.map((v) => v.toJson()).toList();
    // }
    // if (advances != null) {
    //   data['advances'] = advances!.map((v) => v.toJson()).toList();
    // }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    // if (pricingRules != null) {
    //   data['pricing_rules'] =
    //       pricingRules!.map((v) => v.toJson()).toList();
    // }
    // if (advanceTax != null) {
    //   data['advance_tax'] = advanceTax!.map((v) => v.toJson()).toList();
    // }
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
  String? dueDate;
  double? invoicePortion;
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
      this.dueDate,
      this.invoicePortion,
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
    dueDate = json['due_date'];
    invoicePortion = json['invoice_portion'];
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
    data['due_date'] = dueDate;
    data['invoice_portion'] = invoicePortion;
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
  String? itemCode;
  String? itemName;
  String? description;
  int? isNilExempt;
  int? isNonGst;
  String? itemGroup;
  String? image;
  double? receivedQty;
  double? qty;
  double? rejectedQty;
  String? uom;
  double? conversionFactor;
  String? stockUom;
  double? stockQty;
  double? priceListRate;
  double? basePriceListRate;
  String? marginType;
  double? marginRateOrAmount;
  double? rateWithMargin;
  double? discountPercentage;
  double? discountAmount;
  double? baseRateWithMargin;
  double? rate;
  double? amount;
  double? baseRate;
  double? baseAmount;
  String? pricingRules;
  double? stockUomRate;
  int? isFreeItem;
  int? applyTds;
  double? netRate;
  double? netAmount;
  double? baseNetRate;
  double? baseNetAmount;
  double? taxableValue;
  double? valuationRate;
  double? itemTaxAmount;
  double? landedCostVoucherAmount;
  double? rmSuppCost;
  String? warehouse;
  String? expenseAccount;
  int? isFixedAsset;
  int? enableDeferredExpense;
  int? allowZeroValuationRate;
  String? itemTaxRate;
  int? includeExplodedItems;
  double? weightPerUnit;
  double? totalWeight;
  String? costCenter;
  int? pageBreak;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  Items(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.itemCode,
      this.itemName,
      this.description,
      this.isNilExempt,
      this.isNonGst,
      this.itemGroup,
      this.image,
      this.receivedQty,
      this.qty,
      this.rejectedQty,
      this.uom,
      this.conversionFactor,
      this.stockUom,
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
      this.baseRate,
      this.baseAmount,
      this.pricingRules,
      this.stockUomRate,
      this.isFreeItem,
      this.applyTds,
      this.netRate,
      this.netAmount,
      this.baseNetRate,
      this.baseNetAmount,
      this.taxableValue,
      this.valuationRate,
      this.itemTaxAmount,
      this.landedCostVoucherAmount,
      this.rmSuppCost,
      this.warehouse,
      this.expenseAccount,
      this.isFixedAsset,
      this.enableDeferredExpense,
      this.allowZeroValuationRate,
      this.itemTaxRate,
      this.includeExplodedItems,
      this.weightPerUnit,
      this.totalWeight,
      this.costCenter,
      this.pageBreak,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    description = json['description'];
    isNilExempt = json['is_nil_exempt'];
    isNonGst = json['is_non_gst'];
    itemGroup = json['item_group'];
    image = json['image'];
    receivedQty = json['received_qty'];
    qty = json['qty'];
    rejectedQty = json['rejected_qty'];
    uom = json['uom'];
    conversionFactor = json['conversion_factor'];
    stockUom = json['stock_uom'];
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
    baseRate = json['base_rate'];
    baseAmount = json['base_amount'];
    pricingRules = json['pricing_rules'];
    stockUomRate = json['stock_uom_rate'];
    isFreeItem = json['is_free_item'];
    applyTds = json['apply_tds'];
    netRate = json['net_rate'];
    netAmount = json['net_amount'];
    baseNetRate = json['base_net_rate'];
    baseNetAmount = json['base_net_amount'];
    taxableValue = json['taxable_value'];
    valuationRate = json['valuation_rate'];
    itemTaxAmount = json['item_tax_amount'];
    landedCostVoucherAmount = json['landed_cost_voucher_amount'];
    rmSuppCost = json['rm_supp_cost'];
    warehouse = json['warehouse'];
    expenseAccount = json['expense_account'];
    isFixedAsset = json['is_fixed_asset'];
    enableDeferredExpense = json['enable_deferred_expense'];
    allowZeroValuationRate = json['allow_zero_valuation_rate'];
    itemTaxRate = json['item_tax_rate'];
    includeExplodedItems = json['include_exploded_items'];
    weightPerUnit = json['weight_per_unit'];
    totalWeight = json['total_weight'];
    costCenter = json['cost_center'];
    pageBreak = json['page_break'];
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
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['description'] = description;
    data['is_nil_exempt'] = isNilExempt;
    data['is_non_gst'] = isNonGst;
    data['item_group'] = itemGroup;
    data['image'] = image;
    data['received_qty'] = receivedQty;
    data['qty'] = qty;
    data['rejected_qty'] = rejectedQty;
    data['uom'] = uom;
    data['conversion_factor'] = conversionFactor;
    data['stock_uom'] = stockUom;
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
    data['base_rate'] = baseRate;
    data['base_amount'] = baseAmount;
    data['pricing_rules'] = pricingRules;
    data['stock_uom_rate'] = stockUomRate;
    data['is_free_item'] = isFreeItem;
    data['apply_tds'] = applyTds;
    data['net_rate'] = netRate;
    data['net_amount'] = netAmount;
    data['base_net_rate'] = baseNetRate;
    data['base_net_amount'] = baseNetAmount;
    data['taxable_value'] = taxableValue;
    data['valuation_rate'] = valuationRate;
    data['item_tax_amount'] = itemTaxAmount;
    data['landed_cost_voucher_amount'] = landedCostVoucherAmount;
    data['rm_supp_cost'] = rmSuppCost;
    data['warehouse'] = warehouse;
    data['expense_account'] = expenseAccount;
    data['is_fixed_asset'] = isFixedAsset;
    data['enable_deferred_expense'] = enableDeferredExpense;
    data['allow_zero_valuation_rate'] = allowZeroValuationRate;
    data['item_tax_rate'] = itemTaxRate;
    data['include_exploded_items'] = includeExplodedItems;
    data['weight_per_unit'] = weightPerUnit;
    data['total_weight'] = totalWeight;
    data['cost_center'] = costCenter;
    data['page_break'] = pageBreak;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}
