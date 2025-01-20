import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/data/entities/user/user_info.dart';
import 'package:cinefouine/data/repositories/genre_repository.dart';
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
    state = AsyncValue.data(
        await ref.watch(genreRepositoryProvider).getAllUsers());
  }
}

@RoutePage()
class EventInviteView extends ConsumerWidget {
  const EventInviteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final users = ref.watch(usersProvider); // Récupération de la liste des utilisateurs

    return Scaffold(
      backgroundColor: const Color(0xFF1A1F25),
      appBar: AppBar(
        backgroundColor: const Color(0xFF16213E),
        title: const Text("Invite Friends"),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
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
                          user.userName,
                          "Aucun film proposé", // Vous pouvez adapter ce texte si nécessaire
                          false, // Valeur par défaut pour l'invitation
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
                    print("Invitation confirmed");
                    // Logique de confirmation de l'invitation
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

  Widget _buildInviteItem(String name, String status, bool isInvited) {
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
        Cinefouineboutton(
          isClicked: isInvited,
          onPressed: () {
            print("$name invitation toggled");
            // Logique pour inviter ou retirer l'invitation
          },
          text: isInvited ? "Invited" : "Invite",
          text2: "Invited",
        ),
      ],
    );
  }
}