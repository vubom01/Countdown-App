import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tekflat_design/tekflat_design.dart';

extension ContextExtension on BuildContext {
  GoRouter get goRouter => GoRouter.of(this);

  double get bottomPadding => viewPadding.bottom > TekSpacings().mainSpacing
      ? viewPadding.bottom
      : TekSpacings().mainSpacing;
}
