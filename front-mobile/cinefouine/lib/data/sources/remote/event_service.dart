import 'dart:convert';

import 'package:cinefouine/data/entities/event/event_info.dart';
import 'package:cinefouine/data/sources/cine_fouine_endpoints.dart';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_service.g.dart';

@Riverpod(keepAlive: true)
EventService eventService(EventServiceRef ref) {
  final dioClient = ref.watch(dioClientProvider(
    url:
        "https://ms-evt-gdefbnh7cma0e2a3.francecentral-01.azurewebsites.net/api",
  ));
  return EventService(
    dioClient: dioClient,
  );
}

class EventService {
  EventService({
    required this.dioClient,
  });

  final DioClient dioClient;

  Future<List<EventInfo>?> getAllEvents() async {
    final endpoint = CineFouineEndpoints.getAllEvent;
    final apiResult = await dioClient.get<List<EventInfo>>(
      endpoint,
      deserializer: (json) =>
          EventListExtension.eventFromJson(jsonEncode(json)),
    );
    return apiResult;
  }

  Future<void> createEvent({
    required String eventName,
    required String eventDate,
    required String eventHour,
    required String eventLocation,
    int? idGenre,
    String? genreName,
    String? eventDescription,
    int? idUser,
  }) async {
    final endpoint = CineFouineEndpoints.createEvent;
    final eventData = {
      "eventName": eventName,
      "eventDate": eventDate,
      "eventHour": eventHour,
      "eventLocation": eventLocation,
      "idGenre": idGenre,
      "eventDescription": eventDescription,
      "idUser": idUser
    };

    try {
      final response = await dioClient.post(
        endpoint,
        data: eventData,
      );
    } on DioException catch (e) {
      if (e.response != null) {
        // Une réponse a été reçue mais le serveur a retourné une erreur
        print(
            "Erreur Dio (status code : ${e.response?.statusCode}): ${e.response?.data}");
      } else {
        // Pas de réponse reçue
        print("Erreur de connexion : ${e.message}");
      }
    } catch (e) {
      print("Erreur inconnue : $e");
    }
  }

  Future<void> inviteEvent({
    required int IdEvent,
    required int IdUser,
  }) async {
    final endpoint = "/Event/InviteUser";
    final eventInviteData = {
      "IdEvent": IdEvent,
      "IdUser": IdUser,
      "IsPending": true,
    };
    final response = await dioClient.post(
      endpoint,
      data: eventInviteData,
    );
  }
}
