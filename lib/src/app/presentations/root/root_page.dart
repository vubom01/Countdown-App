import 'package:flutter/material.dart';
import 'package:countdown/src/core/base_widget/base_widget.dart';
import 'package:tekflat_design/tekflat_design.dart';

import 'layouts/layouts.dart';
import 'root_controller.dart';
import 'root_keys.dart';

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => BaseViewController<RootController>(
        resizeToAvoidBottomInset: false,
        controller: RootController(),
        pageBuilder: (baseContext, controller) {
          return TekResponsive.appResBuilder(
            TekResponsive.resBuilder(
              key: RootPageKeys.rootPageResBuilderKey.valueKey,
              children: RootLayoutMobile(
                controller: controller,
                child: child,
              ),
            ),
            key: RootPageKeys.rootPageKey.valueKey,
          );
        },
        //   onInitState: (_) {
        //     SchedulerBinding.instance.addPostFrameCallback(
        //       (_) {
        //         $requestNotificationRequest();
        //       },
        //     );
        //
        //     final NotificationController notificationController =
        //         Get.put<NotificationController>(NotificationController());
        //     notificationController.initState();
        //   },
        //   onDisposeState: () {
        //     if (Get.isRegistered<NotificationController>()) Get.delete<NotificationController>();
        //     if (Get.isRegistered<EventsController>()) Get.delete<EventsController>();
        //   },
        // ),
      );
}
