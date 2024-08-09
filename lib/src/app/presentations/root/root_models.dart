import 'package:countdown/src/core/router/router.dart';

class MenuItemModel {
  final String title;
  final String pathSvg;
  final AppRoutes route;
  final bool? badge;

  MenuItemModel({
    required this.title,
    required this.pathSvg,
    required this.route,
    this.badge,
  });
}
