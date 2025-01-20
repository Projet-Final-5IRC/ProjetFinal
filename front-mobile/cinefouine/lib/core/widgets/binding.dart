import 'package:cinefouine/data/sources/shared_preference/preferences.dart';
import 'package:cinefouine/modules/app/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferencesInstance = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesInstanceProvider.overrideWithValue(
          sharedPreferencesInstance,
        ),
      ],
      child: App(),
    ),
  );
}
