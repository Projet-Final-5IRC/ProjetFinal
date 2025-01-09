import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/data/repositories/event_repository.dart';
import 'package:cinefouine/modules/createEvent/model/create_event_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefouine/core/widgets/cinefouineInputField.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class CreateEventForm extends _$CreateEventForm {
  @override
  CreateEventStatus build() {
    return CreateEventStatus();
  }

  void setTitle(String title) {
    state = state.copyWith(
      title: title,
    );
  }

  void setDescription(String description) {
    state = state.copyWith(
      description: description,
    );
  }

  void setDate(String date) {
    state = state.copyWith(
      date: date,
    );
  }

  void setHours(
    String hours,
  ) {
    state = state.copyWith(
      hours: hours,
    );
  }

  void setLocation(
    String location,
  ) {
    state = state.copyWith(
      location: location,
    );
  }
/*
  void isFieldsEmpty() {
    ref.read(_isButtonActiveProvider.notifier).setState(
          value: state.confirmPassword.isNotEmpty &&
              state.password.isNotEmpty &&
              state.username.isNotEmpty &&
              state.name.isNotEmpty,
        );
  }
  */
}

@Riverpod(keepAlive: false)
class _CreateEventButton extends _$CreateEventButton {
  @override
  FutureOr<bool> build() async {
    return false;
  }

  Future<bool> createEvent() async {
    bool eventCreated = false;
    final eventForm = ref.read(createEventFormProvider);
    try {
      state = const AsyncValue.loading();
      print("creation event: eventName: ${eventForm.title}, "
          "eventDate: ${eventForm.date}, "
          "eventHour: ${eventForm.hours}, "
          "eventLocation: ${eventForm.location}, "
          "idGenre: 1, "
          "eventDescription: ${eventForm.description}, "
          "idUser: 1");
      ref.read(eventRepositoryProvider).createEvent(
            eventName: eventForm.title,
            eventDate: eventForm.date,
            eventHour: eventForm.hours,
            eventLocation: eventForm.location,
            idGenre: 1,
            eventDescription: eventForm.description,
            idUser: 1,
          );
      eventCreated = true;
    } on Exception catch (error, _) {
      state = AsyncValue.error(error, _);
    }
    return eventCreated;
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
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _hoursController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final createEventForm = ref.watch(createEventFormProvider);
    bool isLoading = false;
    ref.watch(_createEventButtonProvider).when(
      data: (isAutheticated) {
        isLoading = false;
      },
      error: (error, stackTrace) {
        isLoading = false;
      },
      loading: () {
        isLoading = true;
      },
    );
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
              onChanged: (value) {
                ref
                    .read(createEventFormProvider.notifier)
                    .setTitle(_nameController.text);
              },
              hintText: "Name",
            ),
            const SizedBox(height: 16),
            CineFouineInputField(
              controller: _descriptionController,
              onChanged: (value) {
                ref
                    .read(createEventFormProvider.notifier)
                    .setDescription(_descriptionController.text);
              },
              hintText: "Description",
            ),
            const SizedBox(height: 16),
            CineFouineInputField(
              controller: _dateController,
              onChanged: (value) {
                ref
                    .read(createEventFormProvider.notifier)
                    .setDate(_dateController.text);
              },
              hintText: "Date",
            ),
            const SizedBox(height: 16),
            CineFouineInputField(
              controller: _hoursController,
              onChanged: (value) {
                ref
                    .read(createEventFormProvider.notifier)
                    .setHours(_hoursController.text);
              },
              hintText: "Hours",
            ),
            const SizedBox(height: 16),
            CineFouineInputField(
              controller: _locationController,
              onChanged: (value) {
                ref
                    .read(createEventFormProvider.notifier)
                    .setLocation(_locationController.text);
              },
              hintText: "Location",
            ),
            const SizedBox(height: 32),
            if (createEventForm.isError)
              Text("Erreur dans la création"), //TODO improve
            if (isLoading) CircularProgressIndicator(),
            CineFouineHugeBoutton(
              onPressed: () async {
                if (!isLoading) {
                  bool isEventCreated = await ref
                      .read(_createEventButtonProvider.notifier)
                      .createEvent();
                  if (isEventCreated) router.replaceAll([const EventRoute()]);
                }
              },
              text: "Add",
            ),
          ],
        ),
      ),
    );
  }
}
