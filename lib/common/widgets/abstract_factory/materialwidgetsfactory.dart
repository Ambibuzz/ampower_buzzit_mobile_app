import 'package:ampower_buzzit_mobile/common/service/navigation_service.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class MaterialWidgetsFactory implements IWidgetsFactory {
  @override
  IActivityIndicator createActivityIndicator() {
    return AndroidActivityIndicator();
  }

  @override
  String getTitle() {
    return 'Android Widgets';
  }

  @override
  IBackButton createBackButtonIcon() {
    return AndroidBackButton();
  }
}

class AndroidActivityIndicator implements IActivityIndicator {
  @override
  Widget render() {
    return const CircularProgressIndicator(
      color: CustomTheme.primarycolor,
    );
  }
}

class AndroidBackButton implements IBackButton {
  @override
  Widget render() {
    return Padding(
      padding: const EdgeInsets.only(
        left: Sizes.smallPadding,
      ),
      child: GestureDetector(
        onTap: () => locator.get<NavigationService>().pop(),
        child: const Icon(Icons.arrow_back),
      ),
    )
        //  GestureDetector(
        //   onTap: () => locator.get<NavigationService>().pop(),
        //   child: const Icon(
        //     Icons.arrow_back,
        //     key: Key(
        //       Strings.backButton,
        //     ),
        //   ),
        // )
        ;
  }
}
