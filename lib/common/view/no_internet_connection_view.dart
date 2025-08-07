import 'dart:io';

import 'package:ampower_buzzit_mobile/common/service/navigation_service.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/util/apiurls.dart';
import 'package:ampower_buzzit_mobile/util/constants/images.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:flutter/material.dart';

class NoInternetConnectionView extends StatelessWidget {
  const NoInternetConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFF006CB5), // Starting color
              Color(0xFF002D4C) // ending color
            ],
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.noInternetIcon,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: Sizes.paddingWidget(context)),
                Text(
                  'Oops!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: Sizes.paddingWidget(context)),
                Text(
                  'We apologize for the hiccup!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Sizes.paddingWidget(context)),
                Text(
                  'Something is wrong with the Internet',
                  style: Sizes.subTitleTextStyle(context)?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Sizes.paddingWidget(context) * 2),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.paddingWidget(context),
                  ),
                  height: Sizes.buttonHeightWidget(context),
                  width: displayWidth(context),
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onPressed: () async {
                        await retry();
                      },
                      child: const Text('Retry')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> retry() async {
    try {
      final url = usernameUrl();
      final response = await DioHelper.dio?.get(url);
      locator.get<NavigationService>().pop();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
