import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';


@RoutePage()
class DetailsEventView extends StatelessWidget {
  const DetailsEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16213E), // Couleur sombre pour l'arrière-plan
      appBar: AppBar(
        backgroundColor: const Color(0xFF16213E),
        title: const Text("Event Details"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: const AssetImage("assets/images/default_avatar.jpg"),
                    radius: 40,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Created by Sarah",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Theme",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Horror",
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
              const Text(
                "On se fait peur venez nombreux !\nSurtout Rémi vient, j’ai quelque chose à te montrer :))",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
            Cinefouineboutton(
              isClicked: false,
              onPressed: () {
                print("click");
              },
              text: "Join",
              text2: "Joined",
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
              _buildMemberItem("Sarah (creator)", "Film proposé"),
              const Divider(color: Colors.grey),
              _buildMemberItem("Rémi", "Proposer un film"),
              const Divider(color: Colors.grey),
              _buildMemberItem("Noé", "Film proposé"),
              const Divider(color: Colors.grey),
              _buildMemberItem("Camille", "Aucun film proposé"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemberItem(String name, String status) {
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
  }
}
