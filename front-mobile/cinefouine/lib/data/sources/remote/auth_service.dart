import 'dart:convert';
import 'package:cinefouine/data/entities/movie/movie_info.dart';
import 'package:cinefouine/data/entities/user/user_info.dart';
import 'package:cinefouine/data/sources/cine_fouine_endpoints.dart';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  final dioClient = ref.watch(dioClientProvider(
    url: "https://ms-auth-hdcfgcawgcfngaas.francecentral-01.azurewebsites.net/api",
  ));
  return AuthService(dioClient: dioClient);
}

class AuthService {
  AuthService({required this.dioClient});

  final DioClient dioClient;

  Future<UserInfo?> register({
    required String userName,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String dateCreation,
  }) async {
    final endpoint = CineFouineEndpoints.register;
    final data = {
      "userName": userName,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "dateCreation": dateCreation,
    };
    try {
      return await dioClient.post(
        endpoint,
        data: data,
        deserializer: (json) => UserInfo.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      print('Erreur lors de l\'inscription : $e');
      return null;
    }
  }
}