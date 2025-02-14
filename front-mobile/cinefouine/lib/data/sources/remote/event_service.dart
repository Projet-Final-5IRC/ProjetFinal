import 'dart:convert';

import 'package:cinefouine/data/entities/event/event_info.dart';
import 'package:cinefouine/data/entities/user/user_info.dart';
import 'package:cinefouine/data/sources/cine_fouine_endpoints.dart';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  Future<List<EventInfo>?> getEventsJoined(int idUser) async {
    final endpoint = "/Event/GetEventJoinedByUser?idUser=$idUser";
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
    required int idUser,
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
      await dioClient.post(
        endpoint,
        data: eventData,
      );
    } on DioException catch (e) {
      // Handle Dio errors (e.g., server issues, no connection, etc.)
      if (e.response != null) {
        // Server returned an error
      } else {
        // No response received (network issues)
      }
    } catch (e) {
      // Handle unknown errors
    }
  }

  Future<void> inviteEvent({
    required int idEvent,
    required int idUser,
    required bool isPending,
  }) async {
    final endpoint = "/Event/InviteUser";
    final eventInviteData = {
      "IdEvent": idEvent,
      "IdUser": idUser,
      "IsPending": isPending,
    };
    return await dioClient.post(
      endpoint,
      data: eventInviteData,
    );
  }

// Delete event function with IdEvent in body
  Future<void> deleteEvent(int eventId) async {
    final endpoint = '/Event/DeleteEvent?id=$eventId';
    try {
      await dioClient.delete(
        endpoint,
      );

      // You can add logic here to handle a successful response, if needed
    } on DioException catch (e) {
      // Handle Dio errors (e.g., server issues, no connection, etc.)
      if (e.response != null) {
        // Server returned an error
        debugPrint(
            "DEBUG - DioException (status code: ${e.response?.statusCode}): ${e.response?.data}");
      } else {
        // No response received (network issues)
        debugPrint("DEBUG - DioException - No response received: ${e.message}");
      }
    } catch (e) {
      // Handle unknown errors
      debugPrint("DEBUG - Unknown error: $e");
    }
  }

  Future<List<UserInfo>?> getInvitedUserByEvent({
    required int idEvent,
  }) async {
    final endpoint = "/Event/GetInvitedUserByEvent?id=$idEvent";

    final apiResult = await dioClient.get<List<UserInfo>>(
      endpoint,
      deserializer: (json) => UserListExtension.userFromJson(jsonEncode(json)),
    );
    return apiResult;
  }

  Future<void> deleteInvite({
    required int idEvent,
    required int idUser,
  }) async {
    final endpoint = "/Event/DeleteInviteByUsername?id=$idEvent&idUser=$idUser";

    final apiResult = await dioClient.delete(
      endpoint,
    );
    return apiResult;
  }

  Future<void> joinEvent({
    required int idEvent,
    required int idUser,
  }) async {
    print("idUser=$idUser&idEvent=$idEvent");
    final endpoint = "/Event/joinEvent?idUser=$idUser&idEvent=$idEvent";

    return await dioClient.put(
      endpoint,
    );
  }
}
