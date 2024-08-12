import 'package:countdown/src/app/data/data_sources/locals/event_local.dart';
import 'package:countdown/src/app/presentations/events/events_controller.dart';
import 'package:countdown/src/app/presentations/events/index.dart';
import 'package:countdown/src/app/presentations/widgets/no_data.dart';
import 'package:countdown/src/core/constants/datetimes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:intl/intl.dart';
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
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () async {
        await _controller.reFresh();
        _refreshController.refreshCompleted();
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
                    return _eventCard(_controller.state.events[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventCard(EventLocal event) {
    return TekButtonInkwell(
      onPressed: () => _onSelectEvent(event),
      child: TekCard(
        backgroundColor: TekColors().greyOpacity02,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TekTypography(
                  text: event.name,
                  type: TekTypographyType.bodyMedium,
                  fontSize: TekFontSizes().s12,
                ),
                TekTypography(
                  text: '${event.date} ${event.time ?? ''}',
                  fontSize: TekFontSizes().s12,
                ),
              ],
            ),
            TimerCountdown(
              format: CountDownTimerFormat.daysHoursMinutesSeconds,
              endTime: _getEndTime(event.date, event.time),
              spacerWidth: 4,
              descriptionTextStyle: TextStyle(
                fontSize: TekFontSizes().s10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
