import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:countdown/src/core/styles/colors.dart';
import 'package:countdown/src/core/styles/svg_icons.dart';
import 'package:tekflat_design/tekflat_design.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.child,
    this.title,
    this.textColor,
    this.iconColor,
    this.actions,
    this.isBackButtonVisible = false,
    this.backgroundColor,
    this.fontSize = 16,
    this.backIcon,
    this.customizeBackButton,
    this.onPressedBackButton,
    this.centerTitle = true,
    this.titleSpacing,
    this.systemOverlayStyle,
    this.leading,
    this.shadowColor,
  });

  final Widget? child;
  final String? title;
  final Color? textColor;
  final Color? iconColor;
  final List<Widget>? actions;
  final bool isBackButtonVisible;
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? fontSize;
  final IconData? backIcon;
  final Widget? customizeBackButton;
  final VoidCallback? onPressedBackButton;
  final bool centerTitle;
  final double? titleSpacing;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      scrolledUnderElevation: 0,
      titleSpacing: titleSpacing,
      centerTitle: centerTitle,
      shadowColor: shadowColor,
      leading: isBackButtonVisible ? _backButton(context) : leading,
      actions: actions,
      title: child ??
          Text(
            title ?? '',
            style: TekTextStyles().titleMedium.copyWith(
                  color:
                      textColor ?? context.theme.textTheme.titleMedium?.color,
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize,
                ),
            textAlign: TextAlign.center,
          ),
      automaticallyImplyLeading: false,
      systemOverlayStyle: systemOverlayStyle,
    );
  }

  Widget _backButton(BuildContext context) => TekIconButton(
        icon: customizeBackButton ??
            TekSvgIcon(
              path: AppSvgIcons.arrowLeftOutlined,
              size: TekFontSizes().s22,
              color: iconColor ?? AppColors.textSecondary,
            ),
        iconData: backIcon,
        iconSize: 20.scaleIconSize,
        onPressed: onPressedBackButton ?? context.pop,
        padding: EdgeInsets.all(TekSpacings().p8).copyWith(left: 0),
        color: iconColor ?? AppColors.textSecondary,
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
