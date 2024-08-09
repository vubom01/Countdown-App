import 'package:countdown/src/app/presentations/root/index.dart';
import 'package:countdown/src/core/utils/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:tekflat_design/tekflat_design.dart';

class RootBottomNavigationBarWidget extends StatefulWidget {
  const RootBottomNavigationBarWidget({super.key});

  @override
  State<RootBottomNavigationBarWidget> createState() => _RootBottomNavigationBarWidgetState();
}

class _RootBottomNavigationBarWidgetState extends State<RootBottomNavigationBarWidget> {
  // final List<MenuItemModel> _leftMenuItems = [
  //   MenuItemModel(
  //     title: S.current.home,
  //     pathSvg: AppSvgIcons.calendarOutlined,
  //     route: AppRoutes.events,
  //   ),
  //   MenuItemModel(
  //     title: S.current.explore,
  //     pathSvg: AppSvgIcons.exploreOutlined,
  //     route: AppRoutes.explore,
  //   ),
  // ];
  // final List<MenuItemModel> _rightMenuItems = [
  //   MenuItemModel(
  //     title: S.current.notification,
  //     pathSvg: AppSvgIcons.bellOutlined,
  //     route: AppRoutes.notification,
  //     badge: true,
  //   ),
  //   MenuItemModel(
  //     title: S.current.profile,
  //     pathSvg: AppSvgIcons.userOutlined,
  //     route: AppRoutes.profile,
  //   ),
  // ];
  //
  // void _onItemTapped(MenuItemModel menuItem) {
  //   context.goNamed(menuItem.route.name);
  // }
  //
  // bool _isActive(MenuItemModel menuItem) =>
  //     context.goRouter.currentLocation.contains(menuItem.route.path);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      padding: EdgeInsets.only(
        top: TekSpacings().mainSpacing,
        bottom: TekSpacings().p8,
      ),
      margin: EdgeInsets.only(bottom: context.bottomPadding),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.background,
        boxShadow: [
          TekShadows.mUp,
          // remove shadow bottom
          BoxShadow(
            color: context.theme.colorScheme.background,
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          )
        ],
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ..._leftMenuItems.map(_navItem),
          Expanded(child: RootNavigationBarControlButton()),
          // ..._rightMenuItems.map(_navItem),
        ],
      ),
    );
  }

// Widget _navItem(MenuItemModel menuItem) {
//   final isActive = _isActive(menuItem);
//   return Expanded(
//     child: TekButtonInkwell(
//       onPressed: () => _onItemTapped(menuItem),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Stack(
//             children: [
//               TekSvgIcon(
//                 path: menuItem.pathSvg,
//                 size: TekFontSizes().s22,
//                 color: isActive ? TekColors().primary : AppColors.iconSecondary,
//               ),
//               if (menuItem.badge ?? false)
//                 Obx(
//                   () => NotificationController.to.state.unRead > 0
//                       ? Positioned(
//                           right: 0,
//                           top: 2,
//                           child: Container(
//                             width: 7,
//                             height: 7,
//                             decoration: BoxDecoration(
//                               color: TekColors().primary,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                         )
//                       : const SizedBox.shrink(),
//                 )
//             ],
//           ),
//           TekVSpace.p4,
//           TekTypography(
//             text: menuItem.title,
//             color: isActive ? TekColors().primary : null,
//             fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
//             fontSize: TekFontSizes().s12,
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
