import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cinefouine/modules/home/view.dart';
import 'package:cinefouine/modules/event/view.dart';
import 'package:cinefouine/modules/profil/view.dart';
import 'package:cinefouine/modules/bottomNavigation/view.dart';
import 'package:cinefouine/modules/createEvent/view.dart';
import 'package:cinefouine/modules/eventHome/view.dart';
import 'package:cinefouine/modules/login/view.dart';
import 'package:cinefouine/modules/register/view.dart';

part 'app_router.g.dart';
part 'app_router.gr.dart';

@riverpod
AppRouter appRouter(Ref ref) {
  return AppRouter(ref: ref);
}

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required this.ref});

  final Ref ref;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: BottomNavigationRoute.page, children: [
          AutoRoute(page: HomeRoute.page, initial: true),
          AutoRoute(
            page: EventHomeRoute.page,
            children: [
              AutoRoute(page: EventRoute.page, initial: true),
              AutoRoute(page: CreateEventRoute.page),
            ],
          ),
          AutoRoute(page: ProfilRoute.page),
        ]),
      ];
}
