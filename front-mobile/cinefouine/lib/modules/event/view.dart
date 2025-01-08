import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/data/entities/event/event_info.dart';
import 'package:cinefouine/data/repositories/event_repository.dart';
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

@Riverpod(keepAlive: false)
class Events extends _$Events {
  @override
  Future<List<EventInfo>?> build() async {
    return ref.watch(eventRepositoryProvider).getAllEvents();
  }

  Future<void> updateEvents() async {
    state = AsyncValue.data(
        await ref.watch(eventRepositoryProvider).getAllEvents());
  }
}

@RoutePage()
class EventView extends ConsumerWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(_tabBarIndexNotifierProvider);
    final router = ref.watch(appRouterProvider);
    final events = ref.watch(eventsProvider);
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
                onPressed: () async {
                  //await ref.read(eventRepositoryProvider).getAllEvents();
                  router.push(const CreateEventRoute());
                },
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
                child: events.when(
                  data: (data) {
                    if (data == null) {
                      return const Placeholder();
                    } else {
                      print("BUILD EVENT");
                      return RefreshIndicator(
                        onRefresh: () async {
                          // Appelle la méthode updateEvents() du provider
                          await ref
                              .read(eventsProvider.notifier)
                              .updateEvents();
                        },
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final event = data[index];
                            return EventItem(
                              title: event.eventName,
                              description: event.eventDescription,
                              avatarPath: "assets/images/default_avatar.jpg",
                              isJoined: false,
                              ref: ref,
                            );
                          },
                        ),
                      );
                    }
                  },
                  error: (error, stackTrace) {
                    return Center(
                      child: Text(
                        'Erreur: $error',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final String title;
  final String? description;
  final String avatarPath;
  final bool isJoined;
  final WidgetRef ref;

  const EventItem({
    super.key,
    required this.title,
    this.description,
    required this.avatarPath,
    required this.isJoined,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    var router = ref.watch(appRouterProvider);

    return GestureDetector(
      onTap: () {
        router.push(const DetailsEventRoute());
      },
      child: Padding(
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
                  Text(
                    description ?? "",
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
