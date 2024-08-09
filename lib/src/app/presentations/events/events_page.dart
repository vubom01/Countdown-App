import 'package:countdown/src/core/base_widget/base_widget.dart';
import 'package:flutter/material.dart';

import 'events_controller.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewController(
      controller: EventsController(),
      autoDelete: false,
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
            ),
          ),
        ],
      ),
    );
  }
}
