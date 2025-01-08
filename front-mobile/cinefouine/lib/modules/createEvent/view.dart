import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/data/entities/event/event_info.dart';
import 'package:cinefouine/data/repositories/event_repository.dart';
import 'package:cinefouine/modules/event/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefouine/core/widgets/cinefouineInputField.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class _CreateEventButton extends _$CreateEventButton {
  @override
  bool build() => true;

  void createEvent({
    required String eventName,
    required String eventDate,
    required String eventHour,
    required String eventLocation,
    required String eventDescription,
    int? idGenre,
    String? genreName,
    required int idUser,
  }) {
    ref.read(eventRepositoryProvider).createEvent(
          eventName: eventName,
          eventDate: eventDate,
          eventHour: eventHour,
          eventLocation: eventLocation,
          idGenre: idGenre,
          genreName: genreName,
          eventDescription: eventDescription,
          idUser: idUser,
        );
  }
}

@RoutePage()
class CreateEventView extends ConsumerStatefulWidget {
  const CreateEventView({super.key});

  @override
  ConsumerState<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends ConsumerState<CreateEventView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var router = ref.watch(appRouterProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF243040), // Couleur de fond
      appBar: AppBar(
        title: const Text("Create Event"),
        backgroundColor: const Color(0xFF16213E),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            CineFouineInputField(
              controller: _nameController,
              hintText: "Name",
            ),
            const SizedBox(height: 16),
            CineFouineInputField(
              controller: _descriptionController,
              hintText: "Description",
            ),
            const SizedBox(height: 16),
            CineFouineInputField(
              controller: _dateController,
              hintText: "Date",
            ),
            const SizedBox(height: 32),
            CineFouineHugeBoutton(
              onPressed: () {
                ref.read(_createEventButtonProvider.notifier).createEvent(
                      eventName: "eventdepuislapp",
                      eventDate: "09:12:2023",
                      eventHour: "18:30",
                      eventLocation: "gogo",
                      idGenre: 1,
                      eventDescription: "description",
                      idUser: 1,
                    );
                // TODO: Ajouter la logique pour créer l'événement
                print("Event added: Name=${_nameController.text}, "
                    "Description=${_descriptionController.text}, "
                    "Date=${_dateController.text}");
                ref.read(eventsProvider.notifier).updateEvents();
                router.replaceAll([const EventRoute()]);
                // Vous pouvez afficher un message de confirmation ou naviguer après l'ajout
              },
              text: "Add",
            ),
          ],
        ),
      ),
    );
  }
}
