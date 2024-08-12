import 'package:isar/isar.dart';

part 'event_local.g.dart';

@collection
class EventLocal {
  Id id = Isar.autoIncrement;
  late String name;
  String? note;
  late String date;
  String? time;
}
