import 'package:countdown/src/app/presentations/events/events_page.dart';
import 'package:countdown/src/app/presentations/root/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:countdown/src/core/app_states/states/language_state.dart';
import 'package:countdown/src/core/app_states/states/theme_state.dart';
import 'package:tekflat_design/tekflat_design.dart';

import 'app_router.dart';
import 'app_routes.dart';

class AppRouterKeys {
  const AppRouterKeys._();

  static const ValueKey<String> $signInKey = ValueKey<String>('APP_ROUTER_SIGN_IN_KEY');
  static const ValueKey<String> $signUpKey = ValueKey<String>('APP_ROUTER_SIGN_UP_KEY');

  static const ValueKey<String> $rootKey = ValueKey<String>('APP_ROUTER_ROOT_KEY');

  static const ValueKey<String> $homeKey = ValueKey<String>('APP_ROUTER_HOME_KEY');

  static const ValueKey<String> $planKey = ValueKey<String>('APP_ROUTER_PLAN_KEY');

  static const ValueKey<String> $wishListKey = ValueKey<String>('APP_ROUTER_WISH_LIST_KEY');

  static const ValueKey<String> $profileKey = ValueKey<String>('APP_ROUTER_PROFILE_KEY');

  static const ValueKey<String> $eventsKey = ValueKey<String>('APP_ROUTER_EVENTS_KEY');
}

class AppRouterImpl extends AppRouter {
  AppRoutes? _currentRoute;
  late final GoRouter _router;

  @override
  AppRouterImpl init() {
    _router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: AppRoutes.events.path,
      redirect: (context, state) {
        _currentRoute = AppRoutes.getRouteFromString(state.matchedLocation);
        return null;
      },
      refreshListenable: Listenable.merge(
        [
          LanguageState.to,
          ThemeState.to,
        ],
      ),
      routes: [
        GoRoute(
          path: AppRoutes.events.path,
          name: AppRoutes.events.name,
          builder: (_, __) => const RootPage(
            key: AppRouterKeys.$rootKey,
            child: EventsPage(key: AppRouterKeys.$eventsKey),
          ),
        ),
        // ShellRoute(
        //   builder: (_, GoRouterState state, Widget child) => RootPage(
        //     key: AppRouterKeys.$rootKey,
        //     child: child,
        //   ),
        //   routes: [
        //     GoRoute(
        //       path: AppRoutes.home.path,
        //       name: AppRoutes.home.name,
        //       builder: (context, state) => const HomePage(key: AppRouterKeys.$homeKey),
        //     ),
        //     GoRoute(
        //       path: AppRoutes.profile.path,
        //       name: AppRoutes.profile.name,
        //       builder: (context, state) => const ProfilePage(key: AppRouterKeys.$profileKey),
        //     ),
        //   ],
        // ),
      ],
      errorBuilder: (context, state) {
        /// TODO handle others error
        return const Center(
          child: TekTypography(
            text: 'GoRouter errorBuilder',
          ),
        );
      },
    );
    return this;
  }

  @override
  GoRouter get router => _router;

  @override
  AppRoutes? get currentAppRoutes => _currentRoute;
}
