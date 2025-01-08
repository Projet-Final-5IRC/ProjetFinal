import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class EventInviteView extends ConsumerWidget {
  const EventInviteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var router = ref.watch(appRouterProvider);
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
                child: ListView(
                  children: [
                    _buildInviteItem("Sarah", "Film proposé", true),
                    const Divider(color: Colors.grey),
                    _buildInviteItem("Rémi", "Proposer un film", false),
                    const Divider(color: Colors.grey),
                    _buildInviteItem("Noé", "Film proposé", false),
                    const Divider(color: Colors.grey),
                    _buildInviteItem("Camille", "Aucun film proposé", false),
                    const Divider(color: Colors.grey),
                  ],
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
          text: isInvited ? "Invited" : "Invite", // Change le texte
          text2: "Invited",
        ),
      ],
    );
  }
}
