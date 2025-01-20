import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/data/entities/event/event_info.dart';
import 'package:cinefouine/data/repositories/event_repository.dart';
import 'package:cinefouine/data/sources/shared_preference/preferences.dart';
import 'package:cinefouine/modules/detailsEvent/view.dart';
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
    final preferences = ref.read(preferencesProvider);
    return ref.watch(eventRepositoryProvider).getAllEvents(preferences.idUserPreferences.load());
  }

  Future<void> updateEvents() async {
    final preferences = ref.read(preferencesProvider);
    state = AsyncValue.data(
        await ref.watch(eventRepositoryProvider).getAllEvents(preferences.idUserPreferences.load()));
    ref.read(myEventsProvider.notifier).updateMyEvents();
  }
}

@Riverpod(keepAlive: false)
class MyEvents extends _$MyEvents {
  @override
  Future<List<EventInfo>?> build() async {
    final preferences = ref.read(preferencesProvider);
    if (preferences.idUserPreferences.load() != null) {
      return ref
          .watch(eventRepositoryProvider)
          .getMyEvents(preferences.idUserPreferences.load()!);
    } else {
      return [];
    }
  }

  Future<void> updateMyEvents() async {
    state = AsyncLoading();
    final preferences = ref.read(preferencesProvider);
    if (preferences.idUserPreferences.load() != null) {
      state = AsyncValue.data(
        await ref
            .read(eventRepositoryProvider)
            .getMyEvents(preferences.idUserPreferences.load()!),
      );
    } else {
      state = AsyncValue.data([]);
    }
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
    final myEvents = ref.watch(myEventsProvider);

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
                child: index == 0
                    ? events.when(
                        data: (data) {
                          if (data == null || data.isEmpty) {
                            return const Center(
                              child: Text(
                                "No events available",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          } else {
                            return _buildEventList(data, ref, false);
                          }
                        },
                        error: (error, stackTrace) {
                          return Center(
                            child: Text(
                              'Erreur: $error',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      )
                    : myEvents.when(
                        data: (data) {
                          if (data == null || data.isEmpty) {
                            return const Center(
                              child: Text(
                                "You don't have any events yet",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          } else {
                            return _buildEventList(data, ref, true);
                          }
                        },
                        error: (error, stackTrace) {
                          return Center(
                            child: Text(
                              'Erreur: $error',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildEventList(List<EventInfo> events, WidgetRef ref, bool isMyEvent) {
  return RefreshIndicator(
    onRefresh: () async {
      if (isMyEvent) {
        await ref.read(myEventsProvider.notifier).updateMyEvents();
      } else {
        await ref.read(eventsProvider.notifier).updateEvents();
      }
    },
    child: ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return EventItem(
          event: event,
          avatarPath: "assets/images/default_avatar.jpg",
          isJoined: false,
          isMyEvent: isMyEvent,
          ref: ref,
        );
      },
    ),
  );
}

class EventItem extends StatelessWidget {
  final EventInfo event;
  final String avatarPath;
  final bool isJoined;
  final bool isMyEvent;
  final WidgetRef ref;

  const EventItem({
    super.key,
    required this.avatarPath,
    required this.isJoined,
    required this.ref,
    required this.event,
    required this.isMyEvent,
  });

  @override
  Widget build(BuildContext context) {
    var router = ref.watch(appRouterProvider);

    return InkWell(
      onTap: () {
        ref.read(eventSeletedProvider.notifier).setEvent(event);
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
                    event.eventName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    event.eventDescription ?? "",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (!isMyEvent)
              Cinefouineboutton(
                isClicked: isJoined,
                onPressed: () {
                  print("join");
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
