import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/viewmodel/pdf_download_viewmodel.dart';
import 'package:ampower_buzzit_mobile/util/constants/images.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:flutter/material.dart';

class PdfDownloadWidget extends StatelessWidget {
  const PdfDownloadWidget({
    super.key,
    required this.doctype,
    required this.docname,
  });
  final String doctype;
  final String docname;

  @override
  Widget build(BuildContext context) {
    return BaseView<PdfDownloadViewModel>(
        onModelReady: (model) async {},
        builder: (context, model, child) {
          return GestureDetector(
            onTap: model.state == ViewState.busy
                ? null
                : () async {
                    await model.downloadPdf(doctype, docname);
                  },
            child: model.state == ViewState.busy
                ? Icon(
                    Icons.downloading_outlined,
                    color: Theme.of(context).primaryColor,
                  )
                : Image.asset(
                    Images.downloadIcon,
                    width: 25,
                    height: 25,
                  ),
          );
        });
  }
}
