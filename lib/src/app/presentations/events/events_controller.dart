import 'package:countdown/src/app/data/data_sources/locals/event_local.dart';
import 'package:countdown/src/app/presentations/events/events_state.dart';
import 'package:countdown/src/core/data_sources/locals/isar_db.dart';
import 'package:get/get.dart';
import 'package:countdown/src/core/base_widget/base_controller.dart';

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
}
