import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/data/repositories/event_repository.dart';
import 'package:cinefouine/modules/createEvent/model/create_event_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefouine/core/widgets/cinefouineInputField.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart'; // Pour formater la date et l'heure

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

  void setHours(String hours) {
    state = state.copyWith(
      hours: hours,
    );
  }

  void setLocation(String location) {
    state = state.copyWith(
      location: location,
    );
  }
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
            eventDate: eventForm.date,  // La date est formatée avant l'envoi
            eventHour: eventForm.hours, // L'heure est également formatée avant l'envoi
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

  // Sélecteur de date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      _dateController.text = DateFormat('dd:MM:yyyy').format(pickedDate);
      ref.read(createEventFormProvider.notifier).setDate(_dateController.text);
    }
  }

  // Sélecteur d'heure (format 24h)
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      // Crée un objet DateTime avec l'heure et les minutes
      final now = DateTime.now();
      final time = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);

      // Utilisation de 'HH:mm' pour formater l'heure en format 24 heures
      _hoursController.text = DateFormat('HH:mm').format(time);
      ref.read(createEventFormProvider.notifier).setHours(_hoursController.text);
    }
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
      backgroundColor: const Color(0xFF243040),
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
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: CineFouineInputField(
                  controller: _dateController,
                  onChanged: (value) {},  // Fonction vide pour éviter l'erreur
                  hintText: "Date (dd:MM:yyyy)",
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: AbsorbPointer(
                child: CineFouineInputField(
                  controller: _hoursController,
                  onChanged: (value) {},  // Fonction vide pour éviter l'erreur
                  hintText: "Time (HH:mm)",
                ),
              ),
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
              Text("Erreur dans la création"),
            if (isLoading) const CircularProgressIndicator(),
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
