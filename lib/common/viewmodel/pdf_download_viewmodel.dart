import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:open_filex/open_filex.dart';

class PdfDownloadViewModel extends BaseViewModel {
  Future downloadPdf(String doctype, String docname) async {
    setState(ViewState.busy);
    var path = await locator.get<ApiService>().downloadPdf(doctype, docname);
    if (path.isNotEmpty) {
      OpenFilex.open(path);
    }
    setState(ViewState.idle);
    notifyListeners();
  }
}
