import 'package:countdown/src/app/data/data_sources/locals/event_local.dart';
import 'package:countdown/src/app/presentations/events/events_controller.dart';
import 'package:countdown/src/app/presentations/events/index.dart';
import 'package:countdown/src/core/constants/datetimes.dart';
import 'package:countdown/src/core/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:intl/intl.dart';
import 'package:tekflat_design/tekflat_design.dart';

class EventCardWidget extends StatefulWidget {
  final EventLocal event;
  final EventsController controller;

  const EventCardWidget({super.key, required this.event, required this.controller});

  @override
  State<EventCardWidget> createState() => _EventCardWidgetState();
}

class _EventCardWidgetState extends State<EventCardWidget> with SingleTickerProviderStateMixin {
  DateTime _getEndTime(String date, String? time) {
    final eventDate = DateFormat(DateTimeFormatters.dateFormat).parse(date);
    final eventTime = time != null ? DateFormat(DateTimeFormatters.timeFormat).parse(time) : null;
    return eventTime != null
        ? DateTime(eventDate.year, eventDate.month, eventDate.day, eventTime.hour, eventTime.minute)
        : DateTime(eventDate.year, eventDate.month, eventDate.day, 0, 0);
  }

  void _onSelectEvent(EventLocal event) {
    context.pushNavigator(page: UpsertEventPage(event: event));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        TekBottomSheet.customizeBottomSheet(
          context,
          title: widget.event.name,
          isScrollControlled: true,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          useRootNavigator: false,
          mainAxisSize: MainAxisSize.min,
          builder: (bContext) {
            return Padding(
              padding: EdgeInsets.all(TekSpacings().mainSpacing).copyWith(bottom: 40.scaleSpacing),
              child: Column(
                children: [
                  TekButtonInkwell(
                    text: S.current.delete,
                    textColor: TekColors().red,
                    onPressed: () {
                      widget.controller.deleteEvent(widget.event);
                      context.popNavigator();
                    },
                  )
                ],
              ),
            );
          },
        );
      },
      child: TekButtonInkwell(
        onPressed: () => _onSelectEvent(widget.event),
        child: TekCard(
          backgroundColor: TekColors().greyOpacity02,
          borderRadius: BorderRadius.all(Radius.circular(15.scaleSpacing)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TekTypography(
                    text: widget.event.name,
                    type: TekTypographyType.bodyMedium,
                    fontSize: TekFontSizes().s12,
                  ),
                  TekTypography(
                    text: '${widget.event.date} ${widget.event.time ?? ''}',
                    fontSize: TekFontSizes().s12,
                  ),
                ],
              ),
              _getEndTime(widget.event.date, widget.event.time)
                          .difference(DateTime.now())
                          .inMinutes <
                      0
                  ? TekTypography(
                      text: S.current.pastEvent,
                      fontSize: TekFontSizes().s12,
                    )
                  : TimerCountdown(
                      format: CountDownTimerFormat.daysHoursMinutesSeconds,
                      endTime: _getEndTime(widget.event.date, widget.event.time),
                      spacerWidth: 4,
                      descriptionTextStyle: TextStyle(
                        fontSize: TekFontSizes().s10,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
