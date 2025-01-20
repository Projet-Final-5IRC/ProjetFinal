import 'package:cinefouine/data/entities/event/event_info.dart';
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

  Future<List<EventInfo>?> getAllEvents() async {
    final events = await _appApiClient.getAllEvents();
    return events;
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
      required int IdEvent,
      required int IdUser,
    })async {
      _appApiClient.inviteEvent(IdEvent: IdEvent, IdUser: IdUser);
    }
}
