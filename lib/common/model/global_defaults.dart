class GlobalDefaults {
  String? name;
  String? owner;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  String? idx;
  String? defaultCompany;
  String? currentFiscalYear;
  String? country;
  String? defaultCurrency;
  String? hideCurrencySymbol;
  int? disableRoundedTotal;
  int? disableInWords;
  String? doctype;

  GlobalDefaults(
      {this.name,
      this.owner,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.defaultCompany,
      this.currentFiscalYear,
      this.country,
      this.defaultCurrency,
      this.hideCurrencySymbol,
      this.disableRoundedTotal,
      this.disableInWords,
      this.doctype});

  GlobalDefaults.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    defaultCompany = json['default_company'];
    currentFiscalYear = json['current_fiscal_year'];
    country = json['country'];
    defaultCurrency = json['default_currency'];
    hideCurrencySymbol = json['hide_currency_symbol'];
    disableRoundedTotal = json['disable_rounded_total'];
    disableInWords = json['disable_in_words'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['default_company'] = defaultCompany;
    data['current_fiscal_year'] = currentFiscalYear;
    data['country'] = country;
    data['default_currency'] = defaultCurrency;
    data['hide_currency_symbol'] = hideCurrencySymbol;
    data['disable_rounded_total'] = disableRoundedTotal;
    data['disable_in_words'] = disableInWords;
    data['doctype'] = doctype;
    return data;
  }
}
