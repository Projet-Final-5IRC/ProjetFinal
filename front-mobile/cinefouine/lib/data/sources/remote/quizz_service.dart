import 'dart:convert';
import 'package:cinefouine/data/entities/quizz/quizz_info.dart';
import 'package:cinefouine/data/entities/user/user_info.dart';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cinefouine/data/sources/cine_fouine_endpoints.dart';

part 'quizz_service.g.dart';

@Riverpod(keepAlive: true)
QuizzService quizzService(QuizzServiceRef ref) {
  final dioClient = ref.watch(dioClientProvider(
    url:
        "https://ms-data-f9bvgcewdvchayha.francecentral-01.azurewebsites.net/api",
  ));
  return QuizzService(dioClient: dioClient);
}

class QuizzService {
  QuizzService({required this.dioClient});
  final DioClient dioClient;

  Future<List<Quizz>?> getQuizz() async {
    final endpoint = CineFouineEndpoints.getQuizz;
    final apiResult = await dioClient.get<List<Quizz>>(
      endpoint,
      deserializer: (json) =>
          QuizzListExtension.quizzFromJson(jsonEncode(json)),
    );
    debugPrint("apiResult: $apiResult");
    return apiResult;
  }

}
