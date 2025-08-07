import 'package:ampower_buzzit_mobile/common/service/logout_api_service.dart';
import 'package:ampower_buzzit_mobile/common/service/navigation_service.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/route/routing_constants.dart';
import 'package:ampower_buzzit_mobile/util/constants/images.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

Drawer drawer(BuildContext context, DrawerMenu appSelected) {
  var model = locator.get<HomeViewModel>();
  var imageIconDimension = displayWidth(context) < 600 ? 28.0 : 32.0;

  return Drawer(
    child: SizedBox(
      height: displayHeight(context),
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: DrawerHeader(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 30,
                        child: Common.userImage(context, imgDimension: 80),
                      ),
                      SizedBox(width: Sizes.paddingWidget(context)),
                      Expanded(
                        flex: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.user.fullName ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Sizes.titleTextStyle(context)?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              model.user.email ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Sizes.subTitleTextStyle(context),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: Sizes.paddingWidget(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getAppSelected(appSelected),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                          ),
                          SizedBox(
                              height: Sizes.extraSmallPaddingWidget(context)),
                          Text(
                            'Track Visits and Target vs Achievement',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Sizes.subTitleTextStyle(context)?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: CustomTheme.borderColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Sizes.smallPaddingWidget(context)),
                ],
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              // ListTile(
              //   leading: listTileImageWidget(
              //       Images.customerSelectionIcon, imageIconDimension),
              //   title: listTileTitleWidget('Customer Selection', context),
              //   onTap: () async {
              //     Navigator.pop(context);
              //     await locator
              //         .get<NavigationService>()
              //         .pushReplacementNamed(enterCustomerRoute);
              //   },
              // ),
              ListTile(
                leading: listTileImageWidget(
                    Images.mainMenuIcon, imageIconDimension),
                title: listTileTitleWidget('Main Menu (Apps)', context),
                onTap: () async {
                  Navigator.pop(context);
                  await locator
                      .get<NavigationService>()
                      .pushReplacementNamed(homeViewRoute);
                },
              ),
              const Divider(),
              ListTile(
                leading:
                    listTileImageWidget(Images.profileIcon, imageIconDimension),
                title: listTileTitleWidget('Profile', context),
                onTap: () async {
                  Navigator.pop(context);
                  await locator
                      .get<NavigationService>()
                      .pushReplacementNamed(profileViewRoute);
                },
              ),
            ],
          ),
          const Spacer(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.paddingWidget(context),
              ),
              width: displayWidth(context),
              height: Sizes.buttonHeightWidget(context),
              child: TextButton.icon(
                onPressed: () async {
                  await locator.get<LogoutService>().logOut(context);
                },
                label: Text(
                  'Logout',
                  style: Sizes.titleTextStyle(context)?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
                icon: const Icon(Icons.logout),
              ),
            ),
          ),
          SizedBox(height: Sizes.paddingWidget(context)),
        ],
      ),
    ),
  );
}

Widget listTileImageWidget(String image, double? imageIconDimension) {
  return Image.asset(
    image,
    width: imageIconDimension,
  );
}

Widget listTileTitleWidget(String? text, BuildContext context) {
  return Text(
    text ?? '',
    style: Sizes.titleTextStyle(context)?.copyWith(fontWeight: FontWeight.bold),
  );
}

String getAppSelected(DrawerMenu appSelected) {
  return 'AmPower® BuzzIT';
}
