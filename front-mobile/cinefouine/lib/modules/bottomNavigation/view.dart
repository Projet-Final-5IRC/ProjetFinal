import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/mainAppBar.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class _TabBarIndexNotifier extends _$TabBarIndexNotifier {
  @override
  int build() => 1;

  void setPosition(int value) {
    state = value;
  }
}

@RoutePage()
class BottomNavigationView extends ConsumerWidget {
  const BottomNavigationView({super.key});

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
        final index = ref.watch(_tabBarIndexNotifierProvider);
        return Scaffold(
          appBar: MainAppBar(
            title: _indexToTitle(index),
            showBurgerMenu:
                index == 1, //on montre le burgermenu que dans le home
            showAvatar: index != 2, //on montre pas avatar pour la page profil
            showSearchButton:
                index == 1, //on montre le bouton recherche que dans le home
            avatarUrl: "https://i.pravatar.cc/150?img=3",
            onAvatarPressed: () => print("profil"),
          ),
          drawer: index == 1
              ? Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: const [
                      DrawerHeader(
                        decoration: BoxDecoration(color: Color(0xFF2A6A86)),
                        child: Text(
                          "Menu",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text("Home"),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text("Settings"),
                      ),
                    ],
                  ),
                )
              : null,
          body: ProviderScope(child: child),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xFF2A6A86),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            currentIndex: tabsRouter.activeIndex,
            items: [
              BottomNavigationBarItem(
                icon: _buildCustomIcon('assets/icons/calendar_icon.svg',
                    tabsRouter.activeIndex == 0),
                label: "Event",
              ),
              BottomNavigationBarItem(
                icon: _buildCustomIcon(
                    'assets/icons/home_icon.svg', tabsRouter.activeIndex == 1),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: _buildCustomIcon('assets/icons/profil_icon.svg',
                    tabsRouter.activeIndex == 2),
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

String _indexToTitle(int index) => switch (index) {
      0 => "Event",
      1 => "Cine Fouine",
      2 => "My Profile",
      _ => '',
    };
