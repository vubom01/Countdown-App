import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'base_controller.dart';

typedef PageBuilderWrapperContent<T extends BaseController> = Widget Function(Widget);

typedef PageBuilderWrapper<T extends BaseController> = Widget Function(
  BuildContext context,
  T controller,
  PageBuilderWrapperContent pageBuilderWrapperContent,
);

enum BaseViewControllerType {
  getx,
  provider;

  bool get isGetX => this == BaseViewControllerType.getx;

  bool get isProvider => this == BaseViewControllerType.provider;
}

class BaseViewController<T extends BaseController> extends StatefulWidget {
  const BaseViewController({
    super.key,
    this.screenName,
    this.referrer,
    required this.controller,
    this.tagController,
    this.onInitState,
    this.didUpdateWidget,
    this.onDisposeState,
    this.autoDelete = true,
    this.pageBuilder,
    this.pageBuilderWrapper,

    // Scaffold option
    this.keyScaffoldState,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.wrapByScaffold = true,
    this.appBar,
    this.appBarBuilder,
    this.drawer,
    this.extendBodyBehindAppBar = false,
    this.initType = BaseViewControllerType.getx,
  });

  final String? screenName;
  final String? referrer;
  final T controller;

  /// work with GetX only
  final String? tagController;

  final Function(T)? onInitState;
  final Function(T, BaseViewController<T>, BaseViewController<T>)? didUpdateWidget;
  final VoidCallback? onDisposeState;

  /// work with GetX only
  final bool autoDelete;
  final Widget Function(BuildContext context, T controller)? pageBuilder;
  final PageBuilderWrapper<T>? pageBuilderWrapper;

  // Scaffold option
  final GlobalKey<ScaffoldState>? keyScaffoldState;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final bool wrapByScaffold;
  final PreferredSizeWidget? appBar;
  final PreferredSizeWidget Function(BuildContext context, T controller)? appBarBuilder;
  final Widget? drawer;
  final bool extendBodyBehindAppBar;
  final BaseViewControllerType initType;

  @override
  State<BaseViewController<T>> createState() => _BaseViewControllerState<T>();
}

class _BaseViewControllerState<T extends BaseController> extends State<BaseViewController<T>> {
  late final T _controller;

  @override
  void initState() {
    super.initState();
    if (widget.initType.isGetX) {
      if (!Get.isRegistered<T>()) {
        _controller = Get.put<T>(
          widget.controller,
          tag: widget.tagController,
        );
      } else {
        _controller = Get.find<T>(
          tag: widget.tagController,
        );
      }
    } else {
      _controller = widget.controller;
    }
    _controller.initState();
    widget.onInitState?.call(_controller);
  }

  @override
  void didUpdateWidget(covariant BaseViewController<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.didUpdateWidget?.call(_controller, oldWidget, widget);
  }

  @override
  void dispose() {
    _controller.disposeState();
    if (widget.initType.isGetX) {
      if (widget.autoDelete) Get.delete<T>(tag: widget.tagController);
    }
    widget.onDisposeState?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.initType.isGetX
      ? _bodyWidget()
      : MultiProvider(
          providers: [
            ListenableProvider<T>(
              create: (_) => _controller,
            ),
          ],
          child: _bodyWidget(),
        );

  Widget _bodyWidget() => widget.pageBuilderWrapper != null
      ? widget.pageBuilderWrapper?.call(
            context,
            _controller,
            (pageBuilderWrapperContent) => widget.wrapByScaffold
                ? Scaffold(
                    key: widget.keyScaffoldState,
                    resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
                    extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
                    backgroundColor: widget.backgroundColor ?? context.theme.colorScheme.background,
                    body: pageBuilderWrapperContent,
                    appBar: widget.appBarBuilder?.call(context, _controller) ?? widget.appBar,
                    drawer: widget.drawer,
                  )
                : pageBuilderWrapperContent,
          ) ??
          const SizedBox.shrink()
      : widget.wrapByScaffold
          ? Scaffold(
              key: widget.keyScaffoldState,
              resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
              extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
              backgroundColor: widget.backgroundColor ?? context.theme.colorScheme.background,
              body: widget.pageBuilder?.call(context, _controller) ?? const SizedBox.shrink(),
              appBar: widget.appBarBuilder?.call(context, _controller) ?? widget.appBar,
              drawer: widget.drawer,
            )
          : widget.pageBuilder?.call(context, _controller) ?? const SizedBox.shrink();
}
