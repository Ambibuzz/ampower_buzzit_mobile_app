import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Sizes {
  static const double appBarHeight = 65;
  static const double appBarFontSizeMobile = 18;
  static const double appBarFontSizeLargeDevice = 24;
  static const double buttonHeightMobile = 50;
  static const double buttonHeightLargeDevice = 55;
  static const double buttonHeightTargetitMobile = 52;
  static const double buttonHeightTargetitLargeDevice = 65;
  static const double cameraZoom = 14.4;
  static const double checkBoxTileHeight = 50;
  static const double cardPadding = 8;
  static const double cardMargin = 12;
  static var offlinePageSize = 50;
  static var pageSize = 10;
  static const double aspectRatio = 1.2;
  static const double paddingAboveGraph = 24;
  static const double paddingAboveGraphLargeDevice = 24 * 3;
  static const double paddingBelowGraph = 24;
  static const double paddingBelowGraphLargeDevice = 24 * 3;
  static const double fontSizeMobile = 16;
  static const double fontSizeLargeDevice = 24;
  static const double fontSizeMediumMobile = 24;
  static const double fontSizeMediumLargeDevice = 32;
  static const double fontSizeGraphLeftTileMobile = 10;
  static const double fontSizeGraphLeftTileLargeDevice = 16;
  static const double fontSizeGraphBottomTileMobile = 10;
  static const double fontSizeGraphBottomTileLargeDevice = 20;
  static const String radiusforCircularGraph = '90%';
  static const String innerRadiusforCircularGraph = '75%';
  static const double spacingBetweenGraphFooterContent = 15;
  static const double loginPageAmpowerLogoPadding = 40;
  static const double leadingWidth = 38;
  static const double profileIconSizeTargetitAppbar = 28;
  static const int timeoutDuration = 120;

  static const double horizontalExtraLargePadding = 40;
  static const double verticalExtraLargePadding = 40;
  static const double extraLargePadding = 40;

  static const double horizontalLargePadding = 32;
  static const double verticalLargePadding = 32;
  static const double largePadding = 32;

  static const double horizontalMediumLargePadding = 28;
  static const double verticalMediumLargePadding = 28;
  static const double mediumLargePadding = 28;

  static const double horizontalMediumPadding = 24;
  static const double verticalMediumPadding = 24;
  static const double mediumPadding = 24;

  static const double horizontalMediumPaddingLargeDevice = 24 * 1.5;
  static const double verticalMediumPaddingLargeDevice = 24 * 1.5;
  static const double mediumPaddingLargeDevice = 24 * 1.5;

  static const double horizontalPadding = 16;
  static const double verticalPadding = 16;
  static const double padding = 16;

  static const double horizontalPaddingLargeDevice = 16 * 1.5;
  static const double verticalPaddingLargeDevice = 16 * 1.5;
  static const double paddingLargeDevice = 16 * 1.5;

  static const double horizontalSmallPadding = 8;
  static const double verticalSmallPadding = 8;
  static const double smallPadding = 8;

  static const double horizontalSmallPaddingLargeDevice = 8 * 1.5;
  static const double verticalSmallPaddingLargeDevice = 8 * 1.5;
  static const double smallPaddingLargeDevice = 8 * 1.5;

  static const double extraSmallPadding = 4;
  static const double horizontalExtraSmallPadding = 4;
  static const double verticalExtraSmallPadding = 4;

  static const double extraSmallPaddingLargeDevice = 4 * 1.5;
  static const double horizontalExtraSmallPaddingLargeDevice = 4 * 1.5;
  static const double verticalExtraSmallPaddingLargeDevice = 4 * 1.5;

  static const double reservedSizeLeftTileMobile = 40;
  static const double reservedSizeLeftTileLargeDevice = 40 * 1.5;
  static const double reservedSizeBottomTileMobile = 60;
  static const double reservedSizeBottomTileLargeDevice = 60 * 1.5;

  static const int snackbarDuration = 5;

  static double elevation = defaultTargetPlatform == TargetPlatform.iOS ? 0 : 4;

  static double? subTitleFontSize(BuildContext context) {
    return displayWidth(context) < 600 ? 14 : 18;
  }

  static TextStyle? titleTextStyle(BuildContext context) {
    return displayWidth(context) < 600
        ? Theme.of(context).textTheme.titleMedium
        : Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20);
  }

  static TextStyle? titleTextStyleBold(BuildContext context) {
    return displayWidth(context) < 600
        ? Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            );
  }

  static TextStyle? subTitleSmallTextStyle(BuildContext context) {
    return displayWidth(context) < 600
        ? Theme.of(context).textTheme.labelMedium
        : Theme.of(context).textTheme.titleMedium;
  }

  static TextStyle? subTitleTextStyle(BuildContext context) {
    return displayWidth(context) < 600
        ? Theme.of(context).textTheme.titleSmall
        : Theme.of(context).textTheme.titleLarge;
  }

  static TextStyle? priceTextStyle(BuildContext context) {
    return displayWidth(context) < 600
        ? Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            )
        : Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20);
  }

  static TextStyle? textAndLabelStyle(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14);
    } else {
      return Theme.of(context).textTheme.titleLarge;
    }
  }

  static double appBarFontSizeWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Sizes.appBarFontSizeMobile;
    } else {
      return Sizes.appBarFontSizeLargeDevice;
    }
  }

  static double buttonHeightWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Sizes.buttonHeightMobile;
    } else {
      return Sizes.buttonHeightLargeDevice;
    }
  }

  static double buttonHeightTargetitWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Sizes.buttonHeightTargetitMobile;
    } else {
      return Sizes.buttonHeightTargetitLargeDevice;
    }
  }

  static double fontSizeWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Sizes.fontSizeMobile;
    } else {
      return Sizes.fontSizeLargeDevice;
    }
  }

  static double fontSizeTextButtonWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return 18;
    } else {
      return Sizes.fontSizeLargeDevice;
    }
  }

  static double fontSizeSubTitleWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return 14.0;
    } else {
      return 14 * 1.5;
    }
  }

  static double fontSizeGraphBottomTileWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Sizes.fontSizeGraphBottomTileMobile;
    } else {
      return Sizes.fontSizeGraphBottomTileLargeDevice;
    }
  }

  static double fontSizeGraphLeftTileWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Sizes.fontSizeGraphLeftTileMobile;
    } else {
      return Sizes.fontSizeGraphLeftTileLargeDevice;
    }
  }

  static double iconSizeWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return 24;
    } else {
      return 32;
    }
  }

  static double illustrationImageWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return displayWidth(context) * 0.5;
    } else {
      return displayWidth(context) * 0.3;
    }
  }

  static double bottomPaddingWidget(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return Sizes.paddingWidget(context) * 1.5;
    } else {
      return Sizes.paddingWidget(context);
    }
  }

  static double labelTextSizeWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return 14;
    } else {
      return 16;
    }
  }

  static double cardPaddingWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Sizes.cardPadding;
    } else {
      return Sizes.cardPadding * 1.5;
    }
  }

  static double paddingWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Sizes.padding;
    } else {
      return Sizes.paddingLargeDevice;
    }
  }

  static double smallPaddingWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Sizes.smallPadding;
    } else {
      return Sizes.smallPaddingLargeDevice;
    }
  }

  static double extraSmallPaddingWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Sizes.extraSmallPadding;
    } else {
      return Sizes.extraSmallPaddingLargeDevice;
    }
  }

  static double reservedSizeLeftTileWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Sizes.reservedSizeLeftTileMobile;
    } else {
      return Sizes.reservedSizeLeftTileLargeDevice;
    }
  }

  static double reservedSizeBottomTileWidget(BuildContext context) {
    if (displayWidth(context) < 600) {
      return Sizes.reservedSizeBottomTileMobile;
    } else {
      return Sizes.reservedSizeBottomTileLargeDevice;
    }
  }

  static double barChartHeightWidget(BuildContext context) {
    return displayHeight(context) * 0.5;
  }

  static double barChartAspectRatioWidget(BuildContext context) {
    return displayWidth(context) / (displayHeight(context) * 0.6);
  }

  static Widget tableHeaderBuilder(String? header, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 2.0,
      ),
      decoration: BoxDecoration(
        color: CustomTheme.tableHeaderColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          header!,
          style: TextStyle(
            fontSize: fontSizeSubTitleWidget(context),
          ),
        ),
      ),
    );
  }

  static Widget tableCellBuilder(dynamic value, BuildContext context,
      {AlignmentGeometry? alignment}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 2.0,
      ),
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value!,
          style: TextStyle(
            fontSize: fontSizeSubTitleWidget(context),
          ),
        ),
      ),
    );
  }
}
