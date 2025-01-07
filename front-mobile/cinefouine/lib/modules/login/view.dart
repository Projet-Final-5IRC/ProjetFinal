import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var router = ref.watch(appRouterProvider);
    return Scaffold(
      appBar: AppBar(title: Text("login")),
      body: Column(
        children: [
          Text("Login"),
          CineFouineHugeBoutton(
              onPressed: () => router.push(RegisterRoute()), text: "Register"),
          CineFouineHugeBoutton(
              onPressed: () => router.replaceAll([const HomeRoute()]),
              text: "Login"),
        ],
      ),
    );
  }
}
