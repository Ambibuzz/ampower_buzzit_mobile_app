import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';

class PdfDownloadViewModel extends BaseViewModel {
  Future downloadPdf(
      String doctype, String docname) async {
    setState(ViewState.busy);
    await locator
        .get<ApiService>()
        .downloadPdf(doctype, docname);
    setState(ViewState.idle);
    notifyListeners();
  }
}
