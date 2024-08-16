import 'package:countdown/src/app/data/data_sources/locals/event_local.dart';
import 'package:countdown/src/app/presentations/events/events_controller.dart';
import 'package:countdown/src/app/presentations/events/widgets/event_card_widget.dart';
import 'package:countdown/src/app/presentations/widgets/no_data.dart';
import 'package:countdown/src/core/constants/widget_groups.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tekflat_design/tekflat_design.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class EventsPageContentWidget extends StatefulWidget {
  const EventsPageContentWidget({Key? key}) : super(key: key);

  @override
  State<EventsPageContentWidget> createState() => _EventsPageContentWidgetState();
}

class _EventsPageContentWidgetState extends State<EventsPageContentWidget> {
  final RefreshController _refreshController = RefreshController();

  EventsController get _controller => EventsController.to;

  void _updateWidgetData() {
    final events = _controller.state.events;
    EventDataTransfer.sendEventData(events);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () async {
        await _controller.reFresh();
        _refreshController.refreshCompleted();
        _updateWidgetData();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () {
                if (_controller.state.events.isEmpty) {
                  return NoDataWidget(
                    padding: EdgeInsets.all(TekSpacings().mainSpacing),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.all(TekSpacings().mainSpacing),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (_, __) => TekVSpace.mainSpace,
                  itemCount: _controller.state.events.length,
                  itemBuilder: (context, index) {
                    return EventCardWidget(
                      event: _controller.state.events[index],
                      controller: _controller,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EventDataTransfer {
  static const MethodChannel _channel = MethodChannel(WidgetGroups.methodChannel);

  static Future<void> sendEventData(List<EventLocal> events) async {
    try {
      final List<Map<String, dynamic>> eventList = events
          .map((event) => {
                'id': event.id.toString(),
                'name': event.name,
                'date': event.date,
                'time': event.time ?? "00:00",
              })
          .toList();

      await _channel.invokeMethod(WidgetGroups.sendDataMethod, {WidgetGroups.eventsKey: eventList});
      WidgetKit.reloadAllTimelines();
    } on PlatformException catch (e) {
      print("Failed to send event data: '${e.message}'.");
    }
  }
}
