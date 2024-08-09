import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:countdown/src/core/base_widget/base_widget.dart';

import 'root_state.dart';

class RootController extends BaseController {
  static RootController get to => Get.find<RootController>();
  final GlobalKey globalKeyRootPage = GlobalKey<ScaffoldState>();

  final RootState state = RootState();

  @override
  void initState() async {
    try {
      state.setIsLoadingInitApp(true);
      await syncData();
      state.setIsLoadingInitApp(false);
    } catch (e) {
      state.setIsLoadingInitApp(false);
    }
  }

  @override
  void disposeState() {
    state.setIsLoadingInitApp(false);
  }

  Future syncData() async {}
}
