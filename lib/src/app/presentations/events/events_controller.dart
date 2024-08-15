import 'package:countdown/src/app/data/data_sources/locals/event_local.dart';
import 'package:countdown/src/app/presentations/events/events_state.dart';
import 'package:countdown/src/core/constants/datetimes.dart';
import 'package:countdown/src/core/data_sources/locals/isar_db.dart';
import 'package:get/get.dart';
import 'package:countdown/src/core/base_widget/base_controller.dart';
import 'package:intl/intl.dart';

class EventsController extends BaseController {
  static EventsController get to => Get.find<EventsController>();

  final EventsControllerState state = EventsControllerState();

  @override
  void initState() {
    initEvents();
  }

  @override
  void disposeState() {}

  Future initEvents() async {
    final result = await IsarDB.to.getAll<EventLocal>();
    result.sort((a, b) {
      DateFormat dateFormat = DateFormat(DateTimeFormatters.dateFormat);
      int compare = dateFormat.parse(a.date).compareTo(dateFormat.parse(b.date));
      if (compare == 0) {
        if (a.time == null) {
          compare = "".compareTo(b.time ?? '');
        }
        if (a.time != null) {
          compare = a.time!.compareTo(b.time ?? '');
        }
      }
      return compare;
    });
    state.setEvents(result);
  }

  Future reFresh() async {
    initEvents();
  }

  Future<bool> upsertEvent(EventLocal event) async {
    final result = await IsarDB.to.upsert<EventLocal>(event).then((_) {
      reFresh();
    });
    return result?.id != null;
  }

  Future<bool> deleteEvent(EventLocal event) async {
    await IsarDB.to.delete<EventLocal>(event.id).then((_) {
      reFresh();
    });
    return true;
  }
}
