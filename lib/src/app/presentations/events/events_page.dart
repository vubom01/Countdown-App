import 'package:countdown/src/app/presentations/events/widgets/index.dart';
import 'package:countdown/src/app/presentations/widgets/app_bar.dart';
import 'package:countdown/src/core/app_states/states/theme_state.dart';
import 'package:countdown/src/core/base_widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:tekflat_design/tekflat_design.dart';

import 'events_controller.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  bool _isDarkMode = ThemeState.to.currentTheme == TekThemes.dark;

  @override
  Widget build(BuildContext context) {
    return BaseViewController(
      controller: EventsController(),
      autoDelete: false,
      appBar: AppBarWidget(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: TekSpacings().p12),
            child: AdvancedSwitch(
              width: 44,
              height: 22,
              initialValue: _isDarkMode,
              activeColor: TekColors().primary,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
                ThemeState.to.setCurrentTheme(_isDarkMode ? ThemeMode.dark : ThemeMode.light);
              },
            ),
          ),
        ],
      ),
      pageBuilder: (_, controller) => Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: const EventsPageContentWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
