import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/data/entities/userAction/user_action.dart';
import 'package:cinefouine/data/repositories/user_preference_repository.dart';
import 'package:cinefouine/data/sources/shared_preference/preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard({
    required this.ref,
  });

  final Ref ref;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if (ref.read(preferencesProvider).idUserPreferences.load() != null) {
      // if user is authenticated we continue
      final preferences = ref.watch(preferencesProvider);
      ref.read(userPreferenceRepositoryProvider).logUserAction(
            actionType: "login",
            userId: preferences.idUserPreferences.load()!,
            value: 1,
          );
      print("login");
      resolver.next();
    } else {
      // we redirect the user to our login page
      // tip: use resolver.redirect to have the redirected route
      // automatically removed from the stack when the resolver is completed
      resolver.redirect(const LoginRoute());
    }
  }
}
