import 'package:ampower_buzzit_mobile/common/service/navigation_service.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoWidgetsFactory implements IWidgetsFactory {
  @override
  IActivityIndicator createActivityIndicator() {
    return IosActivityIndicator();
  }

  @override
  String getTitle() {
    return 'Ios Widgets';
  }

  @override
  IBackButton createBackButtonIcon() {
    return IosBackButton();
  }
}

class IosActivityIndicator implements IActivityIndicator {
  @override
  Widget render() {
    return const CupertinoActivityIndicator();
  }
}

class IosBackButton implements IBackButton {
  @override
  Widget render() {
    return Padding(
      padding: const EdgeInsets.only(
        left: Sizes.smallPadding,
      ),
      child: GestureDetector(
        onTap: () => locator.get<NavigationService>().pop(),
        child: const Icon(Icons.arrow_back_ios),
      ),
    )
        // GestureDetector(
        //   onTap: () => locator.get<NavigationService>().pop(),
        //   child: const Icon(
        //     CupertinoIcons.back,
        //     size: 32,
        //     key: Key(Strings.backButton),
        //   ),
        // )
        ;
  }
}
