import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

class BaseViewController<T extends BaseController> extends StatefulWidget {
  const BaseViewController({
    super.key,
    required this.controller,
    this.onInit,
    this.onDispose,
    this.autoDelete = true,
    required this.pageBuilder,
  });

  final T controller;
  final VoidCallback? onInit;
  final VoidCallback? onDispose;
  final bool autoDelete;
  final Widget Function(BuildContext context, T controller) pageBuilder;

  @override
  State<BaseViewController<T>> createState() => _BaseViewControllerState<T>();
}

class _BaseViewControllerState<T extends BaseController> extends State<BaseViewController<T>> {
  late final T _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    if (!Get.isRegistered<T>()) Get.put(_controller);
    _controller.init();
    widget.onInit?.call();
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    _controller.dispose();
    if (widget.autoDelete) Get.delete<T>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.pageBuilder(context, _controller);
}
