import 'package:ampower_buzzit_mobile/util/constants/images.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    this.onRefresh,
    this.height,
  });
  final Future<void> Function()? onRefresh;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        if (onRefresh != null) {
          await onRefresh!();
        }
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: SizedBox(
            height: height ??
                displayHeight(context) - AppBar().preferredSize.height,
            child: Image.asset(
              Images.noDataIcon,
              width: Sizes.illustrationImageWidget(context),
              height: Sizes.illustrationImageWidget(context),
            ),
          ),
        ),
      ),
    );
  }
}
