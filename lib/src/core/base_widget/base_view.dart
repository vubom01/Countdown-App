import 'package:flutter/material.dart';
import 'package:tekflat_design/tekflat_design.dart';

class BaseView extends StatefulWidget {
  const BaseView({
    super.key,
    this.screenName,
    this.referrer,
    this.onInit,
    this.onDispose,
    required this.child,

    // Scaffold option
    this.keyScaffoldState,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.wrapByScaffold = true,
    this.appBar,
    this.drawer,
    this.extendBodyBehindAppBar = false,
    this.bottomNavigationBar,
  });

  final String? screenName;
  final String? referrer;
  final VoidCallback? onInit;
  final VoidCallback? onDispose;
  final Widget child;

  // Scaffold oftion
  final GlobalKey<ScaffoldState>? keyScaffoldState;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final bool wrapByScaffold;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.wrapByScaffold
      ? Scaffold(
          key: widget.keyScaffoldState,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
          backgroundColor: widget.backgroundColor ?? context.theme.colorScheme.background,
          body: widget.child,
          appBar: widget.appBar,
          drawer: widget.drawer,
          bottomNavigationBar: widget.bottomNavigationBar,
        )
      : widget.child;
}
