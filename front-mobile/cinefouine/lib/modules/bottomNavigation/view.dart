import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class _TabBarIndexNotifier extends _$TabBarIndexNotifier {
  @override
  int build() => 0;

  void setPosition(int value) {
    state = value;
  }
}

@RoutePage()
class BottomNavigationView extends ConsumerWidget {
  const BottomNavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: const [
        EventRoute(),
        HomeRoute(),
        ProfilRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cine Fouine"),
          ),
          body: ProviderScope(child: child),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue,
            fixedColor: Colors.orange,
            currentIndex: tabsRouter.activeIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Event",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Profil",
              ),
            ],
            onTap: (value) {
              ref
                  .watch(_tabBarIndexNotifierProvider.notifier)
                  .setPosition(value);
              tabsRouter.setActiveIndex(value);
            },
          ),
        );
      },
    );
  }
}