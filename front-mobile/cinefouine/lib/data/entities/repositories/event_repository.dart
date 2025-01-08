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
  })  : _appApiClient = appApiClient;

  final EventService _appApiClient;

  Future<List<EventInfo>?> getAllEvents() async {
    final events = await _appApiClient.getAllEvents();
    print(events);
    return events;
  }
}