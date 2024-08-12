import 'package:countdown/src/app/data/data_sources/locals/event_local.dart';
import 'package:get/get.dart';

class EventsControllerState {
  final RxList<EventLocal> _events = <EventLocal>[].obs;

  List<EventLocal> get events => _events;

  void setEvents(List<EventLocal> events) => _events.value = events;
}