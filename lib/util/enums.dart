enum AttachmentsFilter { all, files, links }

enum Order {
  asc,
  desc,
}

enum ViewType {
  filter,
  list,
  form,
  newForm,
}

enum ButtonType {
  primary,
  secondary,
}

enum ConnectivityStatus {
  wifi,
  cellular,
  offline,
}

enum ViewState {
  idle,
  busy,
}

enum SortBy {
  itemNameAsc,
  itemNameDesc,
  itemCodeDesc,
  itemCodeAsc,
}

enum ImageShape {
  roundedRectangle,
  circle,
}

enum Menu {
  lead,
  salesOrder,
  quotation,
  salesInvoice,

  //Multiple Drafts
  saveToDraft,
  openDrafts,
  logout,
}

enum ExportType {
  csv,
}

enum DrawerMenu {
  buzzit,
}
