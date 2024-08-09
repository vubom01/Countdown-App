import 'package:collection/collection.dart';
import 'package:countdown/src/core/l10n/generated/l10n.dart';

enum AppRoutes {
  events('/events'),
  ;

  final String path;

  const AppRoutes(this.path);

  String get nameOfRoute {
    switch (this) {
      case AppRoutes.events:
        return S.current.events;
    }
  }

  String get routerKey => 'APP_ROUTE_$name';

  static AppRoutes? getRouteFromString(String name) =>
      AppRoutes.values.firstWhereOrNull((element) => element.name == name);
}
