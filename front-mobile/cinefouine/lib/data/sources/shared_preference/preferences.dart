import 'package:cinefouine/data/sources/shared_preference/preference_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferencesInstance(SharedPreferencesInstanceRef ref) {
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
Preferences preferences(PreferencesRef ref) {
  final sharedPreferencesInstance = ref.watch(
    sharedPreferencesInstanceProvider,
  );

  return Preferences(pref: sharedPreferencesInstance);
}

class Preferences {
  Preferences({required this.pref}) {
    idUserPreferences = SharedPref<int>(key: idUser, pref: pref);
    firstNamePreferences = SharedPref<String>(key: firstName, pref: pref);
    userNamePreferences = SharedPref<String>(key: userName, pref: pref);
    emailPreferences = SharedPref<String>(key: email, pref: pref);
    lastNamePreferences = SharedPref<String>(key: lastName, pref: pref);
  }

  final SharedPreferences pref;

  late SharedPref<int> idUserPreferences;
  late SharedPref<String> firstNamePreferences;
  late SharedPref<String> emailPreferences;
  late SharedPref<String> lastNamePreferences;
  late SharedPref<String> userNamePreferences;

  static const idUser = PreferencesKey.idUser;

  static const firstName = PreferencesKey.firstName;

  static const email = PreferencesKey.email;

  static const lastName = PreferencesKey.lastName;

  static const userName = PreferencesKey.userName;
}

/// Represents a singular preference.

abstract class Preference<T> {
  const Preference();

  T? load();

  void save(T? value);
}

class SharedPref<T> extends Preference<T> {
  const SharedPref({
    required this.key,
    required this.pref,
  });

  final String key;

  final SharedPreferences pref;

  @override
  T? load() {
    final sharedPreferences = pref;

    final Object? value = sharedPreferences.get(key);

    if (value is T) {
      return value;
    }

    return null;
  }

  @override
  void save(T? value) {
    final sharedPreferences = pref;

    if (value == null) {
      // Removes the value from the preferences.

      sharedPreferences.remove(key);
    } else if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is List<String>) {
      sharedPreferences.setStringList(key, value);
    } else {
      throw UnsupportedError('The type $T is not supported');
    }
  }
}
