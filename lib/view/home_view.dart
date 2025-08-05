import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/service/navigation_service.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/barchart.dart';
import 'package:ampower_buzzit_mobile/model/chartdata.dart';
import 'package:ampower_buzzit_mobile/route/routing_constants.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/service/doctype_caching_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/images.dart';
import 'package:ampower_buzzit_mobile/util/constants/lists.dart';
import 'package:ampower_buzzit_mobile/util/constants/others.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  bool _isDialogOpen = false; // Flag to prevent multiple dialogs

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) async {
        model.setIsLoading(true);
        var statusCode = await locator.get<ApiService>().checkSessionExpired();
        if (statusCode == 403) {
          // logout
          locator.get<StorageService>().loggedIn = false;
          await locator
              .get<NavigationService>()
              .pushNamedAndRemoveUntil(loginViewRoute, (_) => false);
        }
        var connectivityStatus =
            Provider.of<ConnectivityStatus>(context, listen: false);
        if (locator.get<StorageService>().isLoginChanged) {
          debugPrint(
              'is login changed ${locator.get<StorageService>().isLoginChanged}');
          // set isLoginChanged to false and recache doctypes
          locator.get<StorageService>().isLoginChanged = false;
          locator
              .get<DoctypeCachingService>()
              .reCacheDoctype(connectivityStatus);
        }
        await model.getBuzzitConfig();
        model.getQuickLinksList();
        await Future.delayed(const Duration(seconds: 1));
        model.setIsLoading(false);
        await model.checkDoctypeCachedOrNot(connectivityStatus);
        await model.getGlobalDefaults();
        await model.getUser();
        await model.getAccounts();
        await model.getAccountBalance();
        model.getIncomeAndExpense();
        await model.getUserFullNameList();
      },
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            if (_isDialogOpen) return false; // Prevent opening multiple dialogs
            _isDialogOpen = true;
            var exitApp = await Common.showExitConfirmationDialog(context);
            _isDialogOpen = false;
            return exitApp;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    model.user.username ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
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
              actions: [
                GestureDetector(
                  onTap: () async {
                    // await locator.get<LogoutService>().logOut(context);
                    await locator
                        .get<NavigationService>()
                        .navigateTo(profileViewRoute);
                  },
                  child: (model.user.userImage == null ||
                          model.user.userImage?.isEmpty == true)
                      ? Common.customImageIcon(
                          context, 30, 20, Images.profileIcon)
                      : ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            imageUrl:
                                '${locator.get<StorageService>().apiUrl}${model.user.userImage}',
                            httpHeaders: {'cookie': DioHelper.cookies ?? ''},
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const Icon(Icons.error),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                ),
                SizedBox(
                  width: Sizes.paddingWidget(context),
                ),
              ],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Corners.xlRadius,
                ),
              ),
            ),
            body:
                // model.state == ViewState.busy
                //     ? WidgetsFactoryList.circularProgressIndicator()
                //     :
                RefreshIndicator(
              onRefresh: () async {
                var connectivityStatus =
                    Provider.of<ConnectivityStatus>(context, listen: false);
                locator
                    .get<DoctypeCachingService>()
                    .reCacheDoctype(connectivityStatus);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.smallPaddingWidget(context) * 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalPadding(context),
                      const Text(
                        'Profit and Loss',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: Sizes.smallPaddingWidget(context),
                      ),
                      cardUi(model, context),
                      /*
                            Card(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Sizes.smallPaddingWidget(context)),
                                child: Column(
                                  children: [
                                    verticalPadding(context),
                                    // verticalPadding(context),
                                    // Row(
                                    //   children: [
                                    //     statusDropdownField(model, context),
                                    //   ],
                                    // ),
                                    cardUi(model, context),
                                    /*
                                    model.viewTypeText == Lists.viewTypeList[0]
                                        ?
                                        //  cardUi(model, context)
                  
                                        barChartWidget(
                                            model,
                                            [
                                              BarChartGroupData(
                                                x: 0,
                                                barRods: [
                                                  BarChartRodData(
                                                    toY: model.income,
                                                    color: const Color(0xFF006CB5),
                                                    width: 10,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(Corners.lg),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 1,
                                                barRods: [
                                                  BarChartRodData(
                                                    toY: model.expense,
                                                    color: const Color(0xFFFF731D),
                                                    width: 10,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(Corners.lg),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 2,
                                                barRods: [
                                                  BarChartRodData(
                                                    toY: model.income -
                                                        model.expense,
                                                    color: const Color(0xFF189333),
                                                    width: 10,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(Corners.lg),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            [
                                              BarChartModel(
                                                'Income',
                                                model.income,
                                              ),
                                              BarChartModel(
                                                'Expense',
                                                model.expense,
                                              ),
                                              BarChartModel(
                                                'Profit',
                                                model.income - model.expense,
                                              ),
                                            ],
                                            context)
                                        : pieChart(model, context),
                                    */
                                    verticalPadding(context),
                                    /*
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFF006CB5),
                                        ),
                                        borderRadius: Corners.xxlBorder,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Sizes.smallPaddingWidget(context) *
                                                    1.5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            legend(
                                                const Color(0xFF006CB5),
                                                'Total Income',
                                                model.income,
                                                context),
                                            legend(
                                                const Color(0xFFFF731D),
                                                'Total Expense',
                                                model.expense,
                                                context),
                                            legend(
                                                const Color(0xFF189333),
                                                'Total Profit',
                                                model.income - model.expense,
                                                context),
                                          ],
                                        ),
                                      ),
                                    ),
                                    */
                                    // verticalPadding(context),
                                    // verticalPadding(context),
                                  ],
                                ),
                              ),
                            ),
                            */
                      verticalPadding(context),
                      Row(
                        children: [
                          Text(
                            'Quick Links',
                            style: TextStyle(
                              fontSize: Sizes.fontSizeWidget(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      quickLinksWidget(model, context),
                      // accountBalanceData(model, context),
                      // verticalPadding(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget cardUi(HomeViewModel model, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: cardTileUi(
                model,
                Images.incomeIcon,
                'Income',
                model.income,
                Colors.green.shade500,
                context,
              ),
            ),
            Expanded(
              child: cardTileUi(
                model,
                Images.expenseIcon,
                'Expense',
                model.expense,
                Colors.red.shade500,
                context,
              ),
            ),
          ],
        ),
        cardTileUi(
          model,
          Images.netProfitIcon,
          'Net Profit',
          model.income - model.expense,
          model.income > model.expense
              ? Colors.green.shade500
              : Colors.red.shade500,
          context,
        )
      ],
    );
  }

  Widget cardTileUi(HomeViewModel model, String icon, String title,
      double value, Color color, BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Sizes.paddingWidget(context),
            horizontal: Sizes.smallPaddingWidget(context)),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: Sizes.smallPaddingWidget(context),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: color,
                  ),
                ),
                SizedBox(
                  height: Sizes.smallPaddingWidget(context),
                ),
                Text(
                  Others.formatter.format(value),
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget accountBalanceData(HomeViewModel model, BuildContext context) {
    return model.accountBalance.message?.isNotEmpty == true
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: model.accountBalance.message?.length,
            itemBuilder: (context, index) {
              var ab = model.accountBalance.message?[index];
              return Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.smallPaddingWidget(context) * 1.5,
                    vertical: Sizes.smallPaddingWidget(context),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 70,
                        child: Text(
                          ab?.value ?? '',
                          maxLines: 2,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                          flex: 30,
                          child: Text(
                            ab?.balance?.abs().toStringAsFixed(1) ?? '',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
                  ),
                ),
              );
            },
          )
        : Container();
  }

  Widget verticalPadding(BuildContext context) {
    return SizedBox(
      height: Sizes.smallPaddingWidget(context) * 1.5,
    );
  }

  Widget statusDropdownField(HomeViewModel model, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: Sizes.extraSmallPaddingWidget(context),
        left: Sizes.smallPaddingWidget(context),
      ),
      height: displayWidth(context) < 600 ? 33 : 40,
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          borderRadius: Corners.xxlBorder),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: model.viewTypeText,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).primaryColor,
          ),
          iconSize: 20,
          onChanged: (value) async {
            model.setChart(value);
          },
          items: Lists.viewTypeList
              // .sublist(1)
              .map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget quickLinksWidget(HomeViewModel model, BuildContext context) {
    return model.isQuickLinksLoading
        ? Skeletonizer(
            enabled: true,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: Text('H'),
                  title: Text('Hello'),
                  trailing: Icon(Icons.arrow_forward_ios),
                );
              },
            ))
        : Padding(
            padding: EdgeInsets.only(
              top: Sizes.smallPaddingWidget(context),
              bottom: Sizes.bottomPaddingWidget(context),
            ),
            child: Card(
              child: Column(
                children: model.quickLinksList
                    .map((e) => Column(
                          children: [
                            quickLinkListTile(
                              title: e.label,
                              route: e.routeName,
                              routeType: e.routeType,
                              context: context,
                              args: e.args,
                              icon: e.icon,
                            ),
                            model.quickLinksList.length - 1 ==
                                    model.quickLinksList.indexOf(e)
                                ? const SizedBox()
                                : const Divider(
                                    color: Color(0xFFD6D6D6),
                                    endIndent: 0,
                                    indent: 0,
                                    height: 1,
                                  ),
                            // model.quickLinksList.indexOf(e) ==
                            //         model.quickLinksList.length - 1
                            //     ? const SizedBox()
                            //     : const Divider()
                          ],
                        ))
                    .toList(),
              ),
            ),
          );
  }

  Widget legend(Color color, String text, double price, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
            SizedBox(
              width: Sizes.extraSmallPaddingWidget(context),
            ),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 13,
              ),
            ),
          ],
        ),
        SizedBox(
          height: Sizes.extraSmallPaddingWidget(context),
        ),
        Text(
          Others.formatter.format(price),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        )
      ],
    );
  }

  // navigation drawer tile ui
  Widget quickLinkListTile({
    String? title,
    required String route,
    required String routeType,
    dynamic args,
    String? icon,
    required BuildContext context,
  }) {
    // if routetype is doctype it means it is a doctype if '' means its not a doctype and its some route name
    var routeTypeList = Lists.routeTypeList;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await locator
            .get<NavigationService>()
            .navigateTo(route, arguments: args);
      },
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            SizedBox(
              width: Sizes.smallPaddingWidget(context),
            ),
            Image.asset(
              icon ?? '',
              width: displayWidth(context) < 600 ? 32 : 48,
              height: displayWidth(context) < 600 ? 32 : 48,
            ),
            SizedBox(
              width: Sizes.smallPaddingWidget(context),
            ),
            Text(
              key: Key(title ?? ''),
              title ?? '',
              style: TextStyle(
                fontSize: displayWidth(context) < 600 ? 14 : 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.black,
            ),
            SizedBox(
              width: Sizes.smallPaddingWidget(context),
            ),
          ],
        ),
      ),
    );
  }
}
