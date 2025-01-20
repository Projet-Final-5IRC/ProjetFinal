import 'package:cinefouine/data/entities/user/user_info.dart';
import 'package:cinefouine/data/sources/remote/user_service.dart';
import 'package:meta/meta.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

@Riverpod(keepAlive: true)
UserRepository movieRepository(MovieRepositoryRef ref) {
  final UserService movieService = ref.watch(userServiceProvider);
  return UserRepository(
    appApiClient: movieService,
  );
}

@immutable
class UserRepository {
  const UserRepository({
    required UserService appApiClient,
  }) : _appApiClient = appApiClient;

  final UserService _appApiClient;

  Future<List<UserInfo>?> getUsers() async {
    return _appApiClient.getUsers();
  }
}