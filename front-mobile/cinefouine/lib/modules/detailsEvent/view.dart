import 'package:cinefouine/data/entities/event/event_info.dart';
import 'package:cinefouine/data/entities/user/user_info.dart';
import 'package:cinefouine/data/sources/shared_preference/preferences.dart';
import 'package:cinefouine/modules/chosseMovie/view.dart';
import 'package:cinefouine/modules/event/view.dart';
import 'package:cinefouine/modules/eventInvite/view.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:cinefouine/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/number_symbols.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cinefouine/data/repositories/event_repository.dart';

part 'view.g.dart';

@Riverpod(keepAlive: true)
class EventSeleted extends _$EventSeleted {
  @override
  EventInfo? build() => null;

  void setEvent(EventInfo value) {
    state = value;
    ref.read(userInvitedToSelectedEventProvider.notifier).updateUsers();
  }
}

@Riverpod(keepAlive: true)
class UserInvitedToSelectedEvent extends _$UserInvitedToSelectedEvent {
  @override
  Future<List<UserInfo>?> build() async {
    final selectedEvent = ref.read(eventSeletedProvider);
    if (selectedEvent != null) {
      return await ref
          .read(eventRepositoryProvider)
          .getInvitedUserByEvent(idEvent: selectedEvent.idEvent);
    } else {
      return [];
    }
  }

  void updateUsers() async {
    state = AsyncLoading();
    final selectedEvent = ref.read(eventSeletedProvider);
    if (selectedEvent != null) {
      state = AsyncData(
        await ref
            .read(eventRepositoryProvider)
            .getInvitedUserByEvent(idEvent: selectedEvent.idEvent),
      );
    } else {
      state = AsyncData([]);
    }
  }
}

@RoutePage()
class DetailsEventView extends ConsumerWidget {
  const DetailsEventView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventSelected = ref.watch(eventSeletedProvider);
    final router = ref.watch(appRouterProvider);
    final users = ref.watch(userInvitedToSelectedEventProvider);
    final preferences = ref.read(preferencesProvider);
    final bool isMyevent =
        eventSelected?.idUser == preferences.idUserPreferences.load();
    final eventsJoined = ref.watch(eventsJoinedProvider);
    final isJoined = eventsJoined.value?.contains(eventSelected?.idEvent);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Created by ${eventSelected?.ownerName}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        const AssetImage("assets/images/default_avatar.jpg"),
                    radius: 40,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Theme",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        eventSelected?.genreName ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Horaire",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${eventSelected?.eventDate ?? ""} at ${eventSelected?.eventHour ?? ""}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Description",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                eventSelected?.eventDescription ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  if (!isMyevent)
                    Cinefouineboutton(
                      isClicked: isJoined ?? false,
                      onPressed: () {
                        final preferences = ref.read(preferencesProvider);
                        if (preferences.idUserPreferences.load() != null ||
                            eventSelected != null) {
                          if (isJoined ?? false) {
                            ref.read(eventRepositoryProvider).deleteInvite(
                                  idEvent: eventSelected!.idEvent,
                                  idUser: preferences.idUserPreferences.load()!,
                                );
                          } else {
                            ref
                                .read(joinEventButtonProvider.notifier)
                                .joinEvent(
                                  preferences.idUserPreferences.load()!,
                                  eventSelected!.idEvent,
                                );
                          }
                          ref
                              .read(eventsJoinedProvider.notifier)
                              .toggleEvent(eventSelected.idEvent);
                          ref
                              .read(userInvitedToSelectedEventProvider.notifier)
                              .updateUsers();
                        }
                      },
                      text: "Join",
                      text2: "Joined",
                    )
                  else
                    Cinefouineboutton(
                      isClicked: false,
                      onPressed: () {
                        router.push(EventInviteRoute());
                      },
                      text: "Invite",
                      text2: "Joined",
                    ),
                  const SizedBox(width: 16),
                  if (isMyevent)
                    Cinefouineboutton(
                      isClicked: false,
                      onPressed: () async {
                        if (eventSelected != null) {
                          await ref
                              .read(eventRepositoryProvider)
                              .deleteEvent(eventSelected.idEvent);
                          router.replaceAll([EventRoute()]);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Event Deleted")),
                          );
                        }
                      },
                      text: "Delete",
                      text2: "Deleted",
                      buttonColor: Colors.red,
                    ),
                  SizedBox(width: 16),
                  Cinefouineboutton(
                    isClicked: false,
                    onPressed: () async {
                      if (eventSelected != null) {
                        router.push(const ChooseMovieRoute());
                      }
                    },
                    text: "Choose a film",
                    text2: "Choose a film",
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "Membres",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              users.when(
                data: (userList) {
                  if (userList == null || userList.isEmpty) {
                    return Text(
                      "Aucun utilisateur dans l'événement",
                      style: TextStyle(color: Colors.white),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref
                          .read(userInvitedToSelectedEventProvider.notifier)
                          .updateUsers();
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        final user = userList[index];
                        return Column(
                          children: [
                            MemberItem(
                              name: "${user.firstName} ${user.lastName}",
                              ref: ref,
                              status: "Film proposé",
                              user: user,
                              isMyEvent: isMyevent,
                            ),
                            const Divider(color: Colors.grey),
                          ],
                        );
                      },
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Text(
                  "Erreur : $error",
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MemberItem extends StatelessWidget {
  final String name;
  final String status;
  final UserInfo user;
  final WidgetRef ref;
  final bool isMyEvent;

  const MemberItem({
    super.key,
    required this.name,
    required this.status,
    required this.user,
    required this.ref,
    required this.isMyEvent,
  });

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    // Contenu principal du widget (Row)
    final childContent = Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/images/default_avatar.jpg"),
          radius: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                status,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF243040),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.image,
            color: Colors.grey,
          ),
        ),
      ],
    );

    return isMyEvent
        ? Dismissible(
            key: ValueKey(user.idUser),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              ref.read(eventRepositoryProvider).deleteInvite(
                    idEvent: ref.read(eventSeletedProvider)?.idEvent ?? 0,
                    idUser: user.idUser,
                  );
              ref
                  .read(userInvitedToSelectedEventProvider.notifier)
                  .updateUsers();
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: childContent,
          )
        : childContent;
  }
}
