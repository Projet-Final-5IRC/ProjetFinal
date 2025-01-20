import 'package:cinefouine/data/entities/genre/genre_info.dart';
import 'package:cinefouine/data/entities/user_preferences/user_preferences_info.dart';
import 'package:cinefouine/data/repositories/user_repository.dart';
import 'package:cinefouine/data/sources/remote/genre_service.dart';
import 'package:cinefouine/data/sources/remote/user_preference_service.dart';
import 'package:cinefouine/data/sources/remote/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meta/meta.dart';

part 'user_preference_repository.g.dart';

@Riverpod(keepAlive: true)
UserPreferenceRepository userPreferenceRepository(UserPreferenceRepositoryRef ref) {
  final UserPreferenceService userPreferenceService = ref.watch(userPreferenceServiceProvider);
  return UserPreferenceRepository(
    userPreferenceService: userPreferenceService,
  );
}

@immutable
class UserPreferenceRepository {
  const UserPreferenceRepository({
    required UserPreferenceService userPreferenceService,
  }) : _userPreferenceService = userPreferenceService;

  final UserPreferenceService _userPreferenceService;

  Future<bool> postUserPreferences(int userId, Set<int> selectedGenres) async {
    return await _userPreferenceService.postUserPreferences(userId, selectedGenres);
  }

    Future<bool> updateUserPreferences(int userId, List<int> selectedGenres) async {
    return await _userPreferenceService.updateUserPreferences(userId, selectedGenres);
  }

    Future<List<UserPreference>?> getUserGenres(int userId) async {
    final userPreferences = await _userPreferenceService.getUserPreferences(userId);
    return userPreferences;
  }
}