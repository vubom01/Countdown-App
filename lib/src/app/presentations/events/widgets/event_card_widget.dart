import 'package:countdown/src/app/data/data_sources/locals/event_local.dart';
import 'package:countdown/src/app/presentations/events/events_controller.dart';
import 'package:countdown/src/app/presentations/events/index.dart';
import 'package:countdown/src/core/constants/datetimes.dart';
import 'package:countdown/src/core/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  late final SlidableController _slideController;

  bool _isSlided = false;

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

  void _listenSlideChange() {
    setState(() {
      _isSlided = _slideController.direction.value == -1;
    });
  }

  @override
  void initState() {
    super.initState();
    _slideController = SlidableController(this);
    _slideController.direction.addListener(_listenSlideChange);
    // if (_subscription != null) {
    //   _subscription?.cancel();
    //   _subscription = null;
    // }
    // _subscription = AppStreamService.to.eventStream.whereType<SlideEventListEvent>().listen(
    //       (event) {
    //     if (event.payload != null && event.payload != widget.event.id) {
    //       _slidableController.close();
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    _slideController.direction.removeListener(_listenSlideChange);
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(widget.event.id.toString()),
      controller: _slideController,
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.16,
        children: [
          CustomSlidableAction(
            padding: EdgeInsets.zero,
            onPressed: null,
            backgroundColor: TekColors().red,
            foregroundColor: context.colorScheme.onSurface,
            // borderRadius: BorderRadius.horizontal(
            //   right: Radius.circular(15.scaleSpacing),
            // ),
            child: TekIconButton(
              onPressed: () {
                widget.controller.deleteEvent(widget.event);
              },
              icon: Icon(
                Icons.delete_outline_outlined,
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      child: TekButtonInkwell(
        onPressed: () => _onSelectEvent(widget.event),
        child: TekCard(
          backgroundColor: context.colorScheme.background,
          // borderRadius: BorderRadius.horizontal(
          //   left: Radius.circular(15.scaleSpacing),
          //   right: Radius.circular(_isSlided ? 0 : 15.scaleSpacing),
          // ),
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
