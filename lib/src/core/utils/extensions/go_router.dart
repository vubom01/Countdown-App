import 'package:go_router/go_router.dart';
import 'package:tekflat_design/tekflat_design.dart';

extension GoRouterExtension on GoRouter {
  String get currentLocation {
    try {
      if(routerDelegate.currentConfiguration.isEmpty) return "";
      final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
      final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
          ? lastMatch.matches
          : routerDelegate.currentConfiguration;
      final String location = matchList.uri.toString();
      return location;
    } catch (e) {
      TekLogger.errorLog("GoRouterExtension currentLocation $e");
      return "";
    }
  }
}
