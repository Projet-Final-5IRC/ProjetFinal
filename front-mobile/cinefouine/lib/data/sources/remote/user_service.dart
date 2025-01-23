import 'package:cinefouine/data/entities/user/user_info.dart';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_service.g.dart';

@Riverpod(keepAlive: true)
UserService userService(UserServiceRef ref) {
  final dioClient = ref.watch(dioClientProvider(
    url:
        "https://ms-auth-hdcfgcawgcfngaas.francecentral-01.azurewebsites.net/api",
  ));
  return UserService(dioClient: dioClient);
}

class UserService {
  UserService ({required this.dioClient});
  final DioClient dioClient;

    Future<List<UserInfo>?> getUsers() async {
      return null;
    }
}