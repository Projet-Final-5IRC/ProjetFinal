import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/modules/chosseMovie/view.dart';
import 'package:cinefouine/modules/eventInvite/view.dart';
import 'package:cinefouine/router/auth_guard.dart';
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
import 'package:cinefouine/modules/detailsEvent/view.dart';
import 'package:cinefouine/modules/detailsMovie/view.dart';
import 'package:cinefouine/modules/genresSelection/view.dart';
import 'package:cinefouine/modules/quiz/view.dart';
import 'package:cinefouine/modules/platforme/view.dart';

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
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: GenresSelectionRoute.page),
        AutoRoute(page: DetailsMovieRoute.page),
        AutoRoute(page: PlatformeRoute.page),
        AutoRoute(page: QuizRoute.page),
        AutoRoute(
          page: BottomNavigationRoute.page,
          initial: true,
          guards: [AuthGuard(ref: ref)],
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(
              page: EventHomeRoute.page,
              children: [
                AutoRoute(page: EventRoute.page, initial: true),
                AutoRoute(page: CreateEventRoute.page),
                AutoRoute(page: ChooseMovieRoute.page),
                AutoRoute(page: EventInviteRoute.page),
                AutoRoute(page: DetailsEventRoute.page),
                AutoRoute(page: EventInviteRoute.page),
              ],
            ),
            AutoRoute(page: ProfilRoute.page),
          ],
        ),
      ];
}
