import 'package:countdown/src/app/presentations/events/index.dart';
import 'package:flutter/material.dart';
import 'package:tekflat_design/tekflat_design.dart';

class RootMenuItemModel {
  final String title;
  final Function(BuildContext context)? onTab;
  final String icon;

  const RootMenuItemModel({
    required this.title,
    this.onTab,
    required this.icon,
  });
}

class RootNavigationBarControlButton extends StatefulWidget {
  const RootNavigationBarControlButton({super.key});

  @override
  State<RootNavigationBarControlButton> createState() => _RootNavigationBarControlButtonState();
}

class _RootNavigationBarControlButtonState extends State<RootNavigationBarControlButton> {
  void _onAddCountdown() {
    context.pushNavigator(page: const UpsertEventPage());
  }

  @override
  Widget build(BuildContext context) {
    return TekButtonInkwell(
      onPressed: () => _onAddCountdown(),
      child: Container(
        width: 45.scaleSpacing,
        height: 45.scaleSpacing,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.primary,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(TekSpacings().p4),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
