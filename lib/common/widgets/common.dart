import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_alert_dialog.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_buttons.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_snackbar.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_textformfield.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_toast.dart';
import 'package:ampower_buzzit_mobile/common/widgets/empty_widget.dart';
import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/comment.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/images.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:json_table/json_table.dart';
import 'package:timeago/timeago.dart' as timeago;

class Common {
  static Widget addCommentTextField(
      TextEditingController? controller, String? label, BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: Common.inputDecoration().copyWith(
        label: Text(
          label ?? '',
          style: Sizes.textAndLabelStyle(context)?.copyWith(
            color: CustomTheme.iconColor,
          ),
        ),
      ),
      maxLines: 4,
    );
  }

  static Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await CustomAlertDialog().alertDialog(
          'Are you sure you want to exit?',
          '',
          'Stay',
          'Exit',
          () => Navigator.of(context, rootNavigator: true).pop(false),
          () => Navigator.of(context, rootNavigator: true).pop(true),
          context,
          headingTextColor: CustomTheme.secondaryColorLight,
          okBtnBgColor: CustomTheme.secondaryColorLight,
          cancelColor: CustomTheme.secondaryColorLight,
        ) ??
        false;
  }

  static Widget mentionsField(
      GlobalKey<FlutterMentionsState> globalKey, BuildContext context) {
    var homeViewModel = locator.get<HomeViewModel>();
    return FlutterMentions(
      key: globalKey,
      suggestionPosition: SuggestionPosition.Top,
      maxLines: 4,
      decoration: Common.inputDecoration().copyWith(
          hintText: 'Add a comment',
          hintStyle: Sizes.textAndLabelStyle(context)),
      style: Sizes.textAndLabelStyle(context),
      mentions: [
        Mention(
            trigger: '@',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            data: homeViewModel.userFullNameList
                .map<Map<String, dynamic>>(
                  (e) => {
                    'id': homeViewModel.userFullNameList.indexOf(e).toString(),
                    'display': e,
                    'full_name': e,
                  },
                )
                .toList(),
            matchAll: false,
            suggestionBuilder: (data) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(data['full_name']),
                      ],
                    )
                  ],
                ),
              );
            }),
      ],
    );
  }

  static Widget commentsList(List<Comment> comments, BuildContext context) {
    return comments.isNotEmpty == true
        ? Column(
            children: [
              comments.isNotEmpty == true
                  ? Row(
                      children: [
                        Text('Previous Comments -',
                            style: TextStyle(
                              color: CustomTheme.borderColor,
                            )),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    var comment = comments[index];
                    return Row(
                      children: [
                        Image.asset(Images.commentIcon, width: 18, height: 18),
                        Expanded(child: Html(data: comment.content ?? '')),
                        const Text('- '),
                        Text(timeago.format(DateTime.parse(comment.creation!)),
                            style: TextStyle(
                              color: CustomTheme.borderColor,
                            )),
                      ],
                    );
                  },
                ),
              ),
            ],
          )
        : const SizedBox();
  }

  static Widget rowHtmlWidget(
      String? key, String? value, BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: Text(
            '$key : ',
            style: TextStyle(
              fontSize: 14,
              color: CustomTheme.borderColor,
            ),
          ),
        ),
        const Text(' : '),
        SizedBox(width: Sizes.smallPaddingWidget(context)),
        Expanded(
          flex: 65,
          child: value != null ? Html(data: value) : const SizedBox(),
        ),
      ],
    );
  }

  static Widget rowWidget(String? key, String? value, BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: Text(
            '$key : ',
            style: TextStyle(
              fontSize: 14,
              color: CustomTheme.borderColor,
            ),
          ),
        ),
        const Text(' : '),
        SizedBox(width: Sizes.smallPaddingWidget(context)),
        Expanded(
          flex: 65,
          child: Text(
            value ?? '',
            maxLines: 6,
            style: const TextStyle(
              fontSize: 14,
              // color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  static Widget sliverRowWidget(
      String? key, String? value, BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Text(
            '$key : ',
            style: TextStyle(
              fontSize: 14,
              color: CustomTheme.borderColor,
            ),
          ),
          SizedBox(
            width: Sizes.smallPaddingWidget(context),
          ),
          Expanded(
            child: Text(
              value ?? '',
              maxLines: 6,
              style: const TextStyle(
                fontSize: 14,
                // color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget statusWidget(String? status, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: CustomTheme.borderColor,
          ),
          borderRadius: Corners.xxlBorder),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.smallPaddingWidget(context), vertical: 2),
        child: Text(
          status ?? '',
          style: TextStyle(color: CustomTheme.borderColor, fontSize: 12),
        ),
      ),
    );
  }

  static Widget doctypeListViewCardUi(String? doctype, String? title,
      String? subtitle, String icon, String? status, BuildContext context) {
    // TextEditingController controller = TextEditingController();
    var globalKey = GlobalKey<FlutterMentionsState>(debugLabel: 'global_key');
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.smallPaddingWidget(context) * 1.5,
        vertical: Sizes.extraSmallPaddingWidget(context),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: Corners.xxlBorder),
        elevation: 4,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.smallPaddingWidget(context),
              vertical: Sizes.smallPaddingWidget(context)),
          child: Row(
            children: [
              Expanded(
                flex: 10,
                child: Image.asset(icon, width: 25, height: 25),
              ),
              SizedBox(width: Sizes.smallPaddingWidget(context)),
              Expanded(
                flex: 58,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: Sizes.smallPaddingWidget(context),
                          ),
                          Text(
                            subtitle ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                              height: Sizes.smallPaddingWidget(context) * 1.5),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: CustomTheme.borderColor,
                                ),
                                borderRadius: Corners.xxlBorder),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.smallPaddingWidget(context),
                                  vertical: 2),
                              child: Text(
                                status ?? '',
                                style: TextStyle(
                                    color: CustomTheme.borderColor,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Sizes.smallPaddingWidget(context)),
                  ],
                ),
              ),
              Expanded(
                flex: 30,
                child: CustomButtons.textButton(
                    'Comment', Theme.of(context).colorScheme.secondary,
                    () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => AlertDialog(
                      insetPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: Sizes.paddingWidget(context),
                        vertical: Sizes.smallPaddingWidget(context),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Please type to add your comments',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: Sizes.smallPaddingWidget(context)),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              child: const Icon(Icons.clear))
                        ],
                      ),
                      content:
                          // Common.addCommentTextField(
                          //     controller, 'Add a comment', context)
                          Common.mentionsField(globalKey, context),
                      actions: <Widget>[
                        CustomButtons.textButton(
                            'Comment', Theme.of(context).colorScheme.secondary,
                            () async {
                          var user = locator.get<HomeViewModel>().user;
                          var result =
                              await locator.get<ApiService>().addComment(
                                    doctype: doctype,
                                    name: subtitle,
                                    content: globalKey
                                        .currentState!.controller!.text,
                                    email: user.email,
                                    commentBy: user.fullName,
                                  );
                          if (result) {
                            // controller.clear();
                          }
                          flutterStyledToast(
                              context,
                              'Your comment is added successfully',
                              CustomTheme.toastSuccessColor,
                              textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ));
                          Navigator.of(context, rootNavigator: true).pop();
                        })
                      ],
                    ),
                  );
                }, buttonTextStyle: TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static AppBar commonAppBar(
      String? title, List<Widget>? actions, BuildContext context) {
    return AppBar(
      title: Text(
        title ?? '',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      leadingWidth: 45,
      leading: Navigator.of(context).canPop()
          ? Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Image.asset(
                      Images.backButtonIcon,
                      width: 35,
                      height: 35,
                    ),
                  ),
                ),
                /*
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).scaffoldBackgroundColor),
                  child: Icon(
                    defaultTargetPlatform == TargetPlatform.android
                        ? Icons.arrow_back
                        : Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                */
              ],
            )
          : null,
      titleSpacing: Sizes.smallPaddingWidget(context) * 1.5,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Corners.xlRadius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFF006CB5), // Starting color
              Color(0xFF002D4C) // ending color
            ],
          ),
        ),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      actions: actions,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Corners.xlRadius,
        ),
      ),
    );
  }

  static Widget addressWidget(String? text, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.padding,
        vertical: Sizes.padding,
      ),
      decoration: BoxDecoration(
          borderRadius: Corners.xxlBorder,
          border: Border.all(
            color: CustomTheme.borderColor,
          ),
          color: Theme.of(context).colorScheme.background),
      child: Html(
        data: text ?? '',
      ),
    );
  }

  static Widget bottomSheetHeader(BuildContext context) {
    return Container(
      width: 89,
      height: 3,
      decoration: BoxDecoration(
        color: CustomTheme.iconColor,
        borderRadius: Corners.xxlBorder,
      ),
    );
  }

  static Widget downloadDoctypeWidget(
      String doctype, String docname, String? defaultPrintFormat) {
    return GestureDetector(
      onTap: () async {
        await locator.get<ApiService>().downloadPdf(doctype, docname);
      },
      child: Image.asset(
        Images.downloadIcon,
        width: 25,
        height: 25,
      ),
    );
  }

  static Widget customIcon(BuildContext context, double containerDimension,
      double iconDimension, IconData icon) {
    return Container(
      width: containerDimension,
      height: containerDimension,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Icon(
        icon,
        size: iconDimension,
        color: const Color(0xFF002D4C),
      ),
    );
  }

  static Widget customImageIcon(BuildContext context, double containerDimension,
      double iconDimension, String image) {
    return Container(
      width: containerDimension,
      height: containerDimension,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Padding(
        padding: EdgeInsets.all(Sizes.extraSmallPaddingWidget(context)),
        child: Image.asset(
          image,
          width: iconDimension,
          height: iconDimension,
        ),
      ),
    );
  }

  static Widget filterIconWidget(BuildContext context, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).scaffoldBackgroundColor),
        child: Image.asset(
          Images.filterIcon,
          width: 30,
          height: 30,
        ),
      ),
    );
  }

  static Widget legendForBarChart(
      Color? color, String text, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: displayWidth(context) < 600 ? 15 : 25,
          height: 25,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(text,
            style: TextStyle(
              fontSize: Sizes.fontSizeWidget(context),
            )),
      ],
    );
  }

  static Widget widgetSpacingVerticalSm() {
    return const SizedBox(height: Spacing.widgetSpacingSm);
  }

  static Widget widgetSpacingVerticalSmSliver() {
    return const SliverToBoxAdapter(
        child: SizedBox(height: Spacing.widgetSpacingSm));
  }

  static Widget widgetSpacingVerticalMd() {
    return const SizedBox(height: Spacing.widgetSpacingMd);
  }

  static Widget widgetSpacingVerticalMdSliver() {
    return const SliverToBoxAdapter(
        child: SizedBox(height: Spacing.widgetSpacingMd));
  }

  static Widget widgetSpacingVerticalLg() {
    return const SizedBox(height: Spacing.widgetSpacingLg);
  }

  static Widget widgetSpacingVerticalLgSliver() {
    return const SliverToBoxAdapter(
        child: SizedBox(height: Spacing.widgetSpacingLg));
  }

  static Widget widgetSpacingVerticalXl() {
    return const SizedBox(height: Spacing.widgetSpacingXl);
  }

  static Widget widgetSpacingVerticalXlSliver() {
    return const SliverToBoxAdapter(
        child: SizedBox(height: Spacing.widgetSpacingXl));
  }

  static Widget customDetailWidget(
      BuildContext context, String label, String? value,
      {String? hintText, int maxLines = 1, TextStyle? style}) {
    return CustomTextFormField(
      labelStyle: Sizes.textAndLabelStyle(context),
      decoration: Common.inputDecoration().copyWith(
        fillColor: Theme.of(context).colorScheme.background,
        hintText: hintText,
      ),
      label: label,
      readOnly: true,
      initialValue: value,
      maxLines: maxLines,
      style: style ??
          Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black,
                fontSize: Sizes.fontSizeWidget(context),
              ),
    );
  }

  static Widget customPressableIcon(
      String? icon, void Function()? onPressed, BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(
        icon ?? '',
        color: Theme.of(context).primaryColor,
        width: displayWidth(context) < 600 ? 28 : 48,
        height: displayWidth(context) < 600 ? 28 : 48,
      ),
    );
  }

  static Widget dividerHeader(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Sizes.paddingWidget(context)),
        Container(
          width: 70,
          height: 3,
          decoration: BoxDecoration(
              color: Colors.grey[800], borderRadius: Corners.smBorder),
        ),
        SizedBox(height: Sizes.paddingWidget(context)),
      ],
    );
  }

  static Widget textFieldName(BuildContext context, String name) {
    return SizedBox(
      height: 40,
      child: Text(
        name,
        style: Theme.of(context).textTheme.bodyLarge,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  static Widget colon(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Text(
        ':',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  static Widget scrollToViewTableBelow(BuildContext context) {
    return Row(
      children: [
        Text(
          'Scroll ',
          style: displayWidth(context) < 600
              ? TextStyle(
                  fontSize: Sizes.fontSizeSubTitleWidget(context),
                )
              : Theme.of(context).textTheme.titleLarge,
        ),
        Icon(Icons.arrow_back, size: displayWidth(context) < 600 ? 18 : 32),
        Text(
          ' or ',
          style: displayWidth(context) < 600
              ? TextStyle(
                  fontSize: Sizes.fontSizeSubTitleWidget(context),
                )
              : Theme.of(context).textTheme.titleLarge,
        ),
        Icon(Icons.arrow_forward, size: displayWidth(context) < 600 ? 18 : 32),
        Text(
          ' to view table below',
          style: displayWidth(context) < 600
              ? TextStyle(
                  fontSize: Sizes.fontSizeSubTitleWidget(context),
                )
              : Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }

  static DataColumn tableColumnText(BuildContext context, String text) {
    return DataColumn(
      label: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  static DataCell dataCellText(BuildContext context, String text, double width,
      {int? maxlines = 2, TextOverflow? overflow = TextOverflow.ellipsis}) {
    return DataCell(SizedBox(
      width: width,
      child: Text(
        text,
        maxLines: maxlines,
        overflow: overflow,
      ),
    ));
  }

  static Widget reusableTextWidget(
      String? text, double textSize, BuildContext context,
      {Color? color, FontWeight? fontWeight}) {
    return SizedBox(
      child: Text(
        text ?? '',
        style: TextStyle(
          fontSize: displayWidth(context) < 600 ? textSize : textSize * 1.5,
          fontWeight: fontWeight ?? FontWeight.w700,
          color: color ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  static Widget screenNameWidget(String? name, BuildContext context,
      {double? horizontalPadding}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Sizes.smallPaddingWidget(context),
        horizontal: horizontalPadding ?? Sizes.smallPaddingWidget(context),
      ),
      child: Row(
        children: [
          Text(
            name ?? '',
            textAlign: TextAlign.left,
            maxLines: 2,
            style: TextStyle(
              fontSize: Sizes.fontSizeWidget(context),
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static InputDecoration inputDecoration({
    Widget? suffixIcon,
    Widget? prefixIcon,
    Widget? suffix,
  }) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      suffix: suffix,
    );
  }

  static Widget reportTable(
      dynamic reportMeta, List<String> showFields, BuildContext context) {
    if (reportMeta != null || reportMeta != '') {
      var columns = reportMeta['message']['columns'] as List<dynamic>;
      var result = reportMeta['message']['result'] as List<dynamic>;
      var filteredColumns = [];
      columns.forEach(
        (e) {
          if (showFields.contains(e['fieldname'])) {
            filteredColumns.add(e);
          }
        },
      );

      return JsonTable(result,
          showColumnToggle: true,
          paginationRowCount: 50,
          tableCellBuilder: (value) => Sizes.tableCellBuilder(value, context),
          tableHeaderBuilder: (header) =>
              Sizes.tableHeaderBuilder(header, context),
          columns: filteredColumns
              .map((e) => JsonTableColumn(e['fieldname'], label: e['label']))
              .toList());
    } else {
      return const EmptyWidget();
    }
  }

  static Widget reportTableWithHiddenColumns(
      dynamic reportMeta, List<String> hiddenFields, BuildContext context) {
    if (reportMeta != null || reportMeta != '') {
      var columns = reportMeta['message']['columns'] as List<dynamic>;
      var result = reportMeta['message']['result'] as List<dynamic>;
      var filteredColumns = [];
      columns.forEach(
        (e) {
          if (!hiddenFields.contains(e['fieldname'])) {
            filteredColumns.add(e);
          }
        },
      );

      return JsonTable(result,
          showColumnToggle: true,
          paginationRowCount: 50,
          tableCellBuilder: (value) => Sizes.tableCellBuilder(value, context),
          tableHeaderBuilder: (header) =>
              Sizes.tableHeaderBuilder(header, context),
          columns: filteredColumns
              .map((e) => JsonTableColumn(e['fieldname'], label: e['label']))
              .toList());
    } else {
      return const EmptyWidget();
    }
  }
}

class ErrorResponse {
  late String? statusMessage;
  late String? userMessage;
  late int? statusCode;
  late String? stackTrace;
  ErrorResponse({
    this.statusMessage = 'Something went wrong',
    this.userMessage,
    this.stackTrace,
    this.statusCode,
  });
}

class FFile {
  bool isPrivate;
  PlatformFile file;

  FFile({
    this.isPrivate = true,
    required this.file,
  });
}
