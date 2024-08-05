import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tekflat_design/tekflat_design.dart';

class FormItemWidget extends StatelessWidget {
  const FormItemWidget({
    super.key,
    required this.title,
    this.heightSpace,
    required this.child,
    this.isRequired = false,
    this.type,
    this.fontWeight,
    this.titleColor,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final double? heightSpace;
  final Widget child;
  final bool isRequired;
  final TekTypographyType? type;
  final FontWeight? fontWeight;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
              bottom: heightSpace ?? TekSpacings().p4,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: title,
                        style: TextStyle(
                          color: TekColors().black,
                          fontWeight: fontWeight ?? FontWeight.w500,
                        ),
                      ),
                      if (isRequired) ...[
                        TextSpan(
                          text: ' * ',
                          style: TextStyle(
                            color: TekColors().red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (subtitle != null) ...[
                  TekHSpace.p4,
                  TekTypography(
                    text: subtitle!,
                    type: TekTypographyType.bodyMedium,
                    fontWeight: FontWeight.w400,
                    fontSize: TekFontSizes().s14,
                    color: TekColors().textSecondary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ],
            ),
          ),
        child,
      ],
    );
  }
}

