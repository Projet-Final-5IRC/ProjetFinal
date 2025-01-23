import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/data/entities/user/user_info.dart';
import 'package:cinefouine/data/repositories/event_repository.dart';
import 'package:cinefouine/data/repositories/genre_repository.dart';
import 'package:cinefouine/modules/detailsEvent/view.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class Users extends _$Users {
  @override
  Future<List<UserInfo>?> build() async {
    return ref.watch(genreRepositoryProvider).getAllUsers();
  }

  Future<void> updateUsers() async {
    state =
        AsyncValue.data(await ref.watch(genreRepositoryProvider).getAllUsers());
  }
}

@Riverpod(keepAlive: false)
class UsersInEvent extends _$UsersInEvent {
  @override
  List<int> build() {
    final users = ref.read(userInvitedToSelectedEventProvider).value;
    if (users == null) {
      return [];
    }
    return users.map((user) => user.idUser).toList();
  }

  void toggleUser(int userId) {
    if (state.contains(userId)) {
      state = state.where((id) => id != userId).toList();
    } else {
      state = [...state, userId];
    }
  }
}

@Riverpod(keepAlive: false)
class InviteUserButton extends _$InviteUserButton {
  @override
  Future<bool> build() async {
    return false;
  }

  Future<void> inviteUser(
    int idUser,
  ) async {
    final eventRepo = ref.read(eventRepositoryProvider);
    final currentEvent = ref.read(eventSeletedProvider);
    final userInevent = ref.read(usersInEventProvider);

    if (currentEvent?.idEvent != null) {
      if (userInevent.contains(idUser)) {
        ref.read(eventRepositoryProvider).deleteInvite(
              idEvent: currentEvent!.idEvent,
              idUser: idUser,
            );
      } else {
        await eventRepo.inviteEvent(
          idEvent: currentEvent!.idEvent,
          idUser: idUser,
          isPending: true,
        );
      }
      ref.read(usersInEventProvider.notifier).toggleUser(idUser);
      ref.read(userInvitedToSelectedEventProvider.notifier).updateUsers();
    }
  }
}

@Riverpod(keepAlive: false)
class IsUserInvited extends _$IsUserInvited {
  @override
  Future<bool> build() async {
    return false;
  }

  Future<bool> isUserInvited(
    int idUser,
  ) async {
    return false;
  }
}

@RoutePage()
class EventInviteView extends ConsumerWidget {
  const EventInviteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final users = ref.watch(usersProvider);
    final usersInEvent = ref.watch(usersInEventProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1F25),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: users.when(
                  data: (userList) {
                    if (userList == null || userList.isEmpty) {
                      return const Center(
                        child: Text(
                          "Aucun utilisateur disponible.",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: userList.length,
                      separatorBuilder: (context, index) =>
                          const Divider(color: Colors.grey),
                      itemBuilder: (context, index) {
                        final user = userList[index];
                        return _buildInviteItem(
                          name: user.userName,
                          isInvited: usersInEvent.contains(user.idUser),
                          onPressed: () {
                            ref
                                .read(inviteUserButtonProvider.notifier)
                                .inviteUser(user.idUser);
                          },
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (err, stack) => Center(
                    child: Text(
                      "Erreur : $err",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: CineFouineHugeBoutton(
                  onPressed: () {
                    router.back();
                  },
                  text: "Confirmer",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInviteItem({
    required String name,
    required bool isInvited,
    required VoidCallback onPressed,
  }) {
    return Row(
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
            ],
          ),
        ),
        Cinefouineboutton(
          isClicked: isInvited,
          onPressed: onPressed,
          text: isInvited ? "Invited" : "Invite",
          text2: "Invited",
        ),
      ],
    );
  }
}
