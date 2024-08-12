import 'package:flutter/material.dart';
import 'package:countdown/src/core/constants/images.dart';
import 'package:countdown/src/core/l10n/generated/l10n.dart';
import 'package:countdown/src/core/styles/colors.dart';
import 'package:tekflat_design/tekflat_design.dart';

class NoDataWidget extends StatelessWidget {
  final double? imageSize;
  final double? fontSize;
  final Color? titleColor;
  final String? title;
  final EdgeInsets? padding;
  final Decoration? decoration;
  final Widget? child;

  final bool? showTitle;

  const NoDataWidget({
    super.key,
    this.title,
    this.fontSize,
    this.imageSize = 100,
    this.titleColor,
    this.showTitle = true,
    this.padding,
    this.decoration,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TekVSpace.p20,
          TekAssetImage(
            path: AppAssetImages.kingdom,
            width: imageSize,
            height: imageSize,
            borderWidth: 0,
            borderColor: Colors.transparent,
          ),
          TekVSpace.mainSpace,
          if (child != null)
            child!
          else
            TekTypography(
              text: title ?? S.current.noData,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),
          TekVSpace.mainSpace,
        ],
      ),
    );
  }
}
