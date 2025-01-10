import 'package:cinefouine/data/entities/user/user_info.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cinefouine/data/sources/remote/auth_service.dart';
import 'package:meta/meta.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final AuthService authService = ref.read(authServiceProvider);
  //final Preferences preferences = ref.read(preferencesProvider);
  return AuthRepository(
    authApiClient: authService,
    //preferences: preferences,
  );
}

@immutable
class AuthRepository {
  const AuthRepository({
    required AuthService authApiClient,
    //required Preferences preferences,
  }) : _authApiClient = authApiClient;
  //_preferences = preferences;

  final AuthService _authApiClient;
  //final Preferences _preferences;

  Future<UserInfo?> register({
    required String userName,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final now = DateTime.now();
    final dateCreation = DateFormat('dd:MM:yyyy').format(now);

    final userInfo = await _authApiClient.register(
      userName: userName,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      dateCreation: dateCreation,
    );
    /*
    if (userInfo != null) {
      _preferences.idUserPreferences.save(userInfo.idUser);
      _preferences.firstNamePreferences.save(userInfo.firstName);
      _preferences.lastNamePreferences.save(userInfo.lastName);
      _preferences.emailPreferences.save(userInfo.email);
      _preferences.userNamePreferences.save(userInfo.userName);
    }
    */

    return userInfo;
  }

  Future<UserInfo?> login({
    required String email,
    required String password,
  }) async {
    final userInfo = await _authApiClient.login(
      email: email,
      password: password,
    );
    print(userInfo.toString());
    return userInfo;
  }
}
