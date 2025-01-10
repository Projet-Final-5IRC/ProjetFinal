import 'package:cinefouine/data/entities/event/event_info.dart';
import 'package:cinefouine/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: true)
class EventSeleted extends _$EventSeleted {
  @override
  EventInfo? build() => null;

  void setEvent(EventInfo value) {
    state = value;
  }
}

@RoutePage()
class DetailsEventView extends ConsumerWidget {
  const DetailsEventView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventSelected = ref.watch(eventSeletedProvider);

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
                "Created by ${eventSelected?.idOwner}",
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
