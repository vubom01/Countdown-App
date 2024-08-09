import 'package:countdown/src/app/presentations/events/events_state.dart';
import 'package:get/get.dart';
import 'package:countdown/src/core/base_widget/base_controller.dart';

class EventsController extends BaseController {
  static EventsController get to => Get.find<EventsController>();

  final EventsControllerState state = EventsControllerState();

  @override
  void initState() {}

  @override
  void disposeState() {}
}
