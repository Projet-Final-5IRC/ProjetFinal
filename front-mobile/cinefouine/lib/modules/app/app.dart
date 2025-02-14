import 'package:cinefouine/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return Builder(
      builder: (context) {
        return MaterialApp.router(
          title: 'Cine Fouine',
          routerConfig: router.config(),
        );
      },
    );
  }
}