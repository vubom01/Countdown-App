import 'package:flutter/material.dart';
import 'package:countdown/src/core/app_states/states/language_state.dart';

import '../root_controller.dart';
import '../widgets/widgets.dart';

class RootLayoutMobile extends StatelessWidget {
  const RootLayoutMobile({
    super.key,
    required this.child,
    required this.controller,
  });

  final Widget child;
  final RootController controller;

  @override
  Widget build(BuildContext context) => Column(
        key: controller.globalKeyRootPage,
        children: [
          Expanded(child: child),
          RootBottomNavigationBarWidget(
            key: Key(LanguageState.to.currentLocale.languageCode),
          ),
        ],
      );
}
