
String doctypeDetailUrl(String doctype, String name) {
  return '/api/resource/$doctype/$name';
}

String pdfUrl() {
  return '/api/method/frappe.utils.print_format.download_pdf';
}

String usernameUrl() {
  return '/api/method/frappe.auth.get_logged_user';
}
