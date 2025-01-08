import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
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
class EventView extends ConsumerWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var index = ref.watch(_tabBarIndexNotifierProvider);
    var router = ref.watch(appRouterProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F25),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BouttonNavigation(
                    isClicked: index == 0,
                    onPressed: () => ref
                        .read(_tabBarIndexNotifierProvider.notifier)
                        .setPosition(0),
                    text: "All events",
                  ),
                  const SizedBox(width: 16),
                  BouttonNavigation(
                    isClicked: index == 1,
                    onPressed: () => ref
                        .read(_tabBarIndexNotifierProvider.notifier)
                        .setPosition(1),
                    text: "My events",
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CineFouineHugeBoutton(
                onPressed: () => router.push(const CreateEventRoute()),
                text: "Create",
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    index == 0 ? 'All Events' : 'My Events',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildEventItem(
                      'Horror',
                      'On se fait peur venez nombreux !',
                      'assets/images/default_avatar.jpg',
                      true,
                    ),
                    _buildEventItem(
                      'Romance',
                      '',
                      'assets/images/default_avatar.jpg',
                      false,
                    ),
                    _buildEventItem(
                      'Comedy',
                      '',
                      'assets/images/default_avatar.jpg',
                      false,
                    ),
                    _buildEventItem(
                      'Comedy',
                      'On rigole on rigole mais on voit ...',
                      'assets/images/default_avatar.jpg',
                      false,
                    ),
                    _buildEventItem(
                      'Hard Core',
                      '',
                      'assets/images/default_avatar.jpg',
                      false,
                    ),
                    _buildEventItem(
                      'Any',
                      '',
                      'assets/images/default_avatar.jpg',
                      false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventItem(
    String title,
    String description,
    String avatarPath,
    bool isJoined,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(avatarPath),
            radius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                if (description.isNotEmpty)
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
          Cinefouineboutton(
            isClicked: isJoined,
            onPressed: () {
              print("click");
            },
            text: "Join",
            text2: "Joined",
          ),
        ],
      ),
    );
  }
}

class BouttonNavigation extends StatelessWidget {
  final bool isClicked;
  final String text;
  final VoidCallback onPressed;

  const BouttonNavigation({
    required this.isClicked,
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isClicked)
          Positioned(
            bottom: 10,
            child: Container(
              width: text.length * 8.0,
              height: 2.0,
              color: Color(0xFF0099CC),
            ),
          ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style:
                TextStyle(color: isClicked ? Color(0xFF0099CC) : Colors.white),
          ),
        ),
      ],
    );
  }
}
