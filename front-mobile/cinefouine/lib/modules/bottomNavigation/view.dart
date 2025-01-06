import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
            backgroundColor: Color(0xFF2A6A86),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            currentIndex: tabsRouter.activeIndex,
            items: [
              BottomNavigationBarItem(
                icon: _buildCustomIcon('assets/icons/calendar_icon.svg', tabsRouter.activeIndex == 0),
                label: "Event",
              ),
                BottomNavigationBarItem(
                icon: _buildCustomIcon('assets/icons/home_icon.svg', tabsRouter.activeIndex == 1),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: _buildCustomIcon('assets/icons/profil_icon.svg', tabsRouter.activeIndex == 2),
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

  Widget _buildCustomIcon(String svgPath, bool isSelected) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isSelected)
          Container(
            width: 64,
            padding: EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        SvgPicture.asset(
          svgPath,
        ),
      ],
    );
  }
}