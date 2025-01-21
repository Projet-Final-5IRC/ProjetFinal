import 'package:cinefouine/data/entities/event/event_info.dart';
import 'package:cinefouine/data/entities/user/user_info.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:cinefouine/data/sources/remote/event_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_repository.g.dart';

@Riverpod(keepAlive: true)
EventRepository eventRepository(EventRepositoryRef ref) {
  final EventService eventService = ref.watch(eventServiceProvider);
  return EventRepository(
    appApiClient: eventService,
  );
}

@immutable
class EventRepository {
  const EventRepository({
    required EventService appApiClient,
  }) : _appApiClient = appApiClient;

  final EventService _appApiClient;

  Future<List<EventInfo>?> getAllEvents(int? idUser) async {
    final events = await _appApiClient.getAllEvents();
    final allEventsExeptMine =
        events?.where((event) => event.idUser != idUser).toList();
    return allEventsExeptMine;
  }

  Future<List<EventInfo>?> getEventsJoined(int idUser) async {
    return await _appApiClient.getEventsJoined(idUser);
  }

  Future<List<EventInfo>?> getMyEvents(int idUser) async {
    final events = await _appApiClient.getAllEvents();
    final userEvents =
        events?.where((event) => event.idUser == idUser).toList();
    return userEvents;
  }

  Future<void> createEvent({
    required String eventName,
    required String eventDate,
    required String eventHour,
    required String eventLocation,
    int? idGenre,
    String? genreName,
    required String eventDescription,
    required int idUser,
  }) async {
    await _appApiClient.createEvent(
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

  Future<void> inviteEvent({
    required int idEvent,
    required int idUser,
    bool isPending = true,
  }) async {
    _appApiClient.inviteEvent(
      idEvent: idEvent,
      idUser: idUser,
      isPending: isPending,
    );
  }

  // Delete event function
  Future<void> deleteEvent(int eventId) async {
    debugPrint('DEBUG EventRepository: deleteEvent');
    await _appApiClient.deleteEvent(
        eventId); // Call the deleteEvent function from EventService
  }

  Future<List<UserInfo>?> getInvitedUserByEvent({
    required int idEvent,
  }) async {
    return await _appApiClient.getInvitedUserByEvent(
      idEvent: idEvent,
    );
  }

  Future<void> deleteInvite({
    required int idEvent,
    required int idUser,
  }) async {
    await _appApiClient.deleteInvite(
      idEvent: idEvent,
      idUser: idUser,
    );
  }

  Future<void> joinEvent({
    required int idEvent,
    required int idUser,
  }) async {
    _appApiClient.joinEvent(idEvent: idEvent, idUser: idUser);
  }
}
