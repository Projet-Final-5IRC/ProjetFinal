import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/data/entities/userAction/user_action.dart';
import 'package:cinefouine/data/repositories/user_preference_repository.dart';
import 'package:cinefouine/data/sources/shared_preference/preferences.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:cinefouine/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class UserActionStat extends _$UserActionStat {
  @override
  Future<UserAction?> build() async {
    final Preferences preferences = ref.read(preferencesProvider);
    try {
      return await ref
          .read(userPreferenceRepositoryProvider)
          .getUserActivity(preferences.idUserPreferences.load()!);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateAction() async {
    final Preferences preferences = ref.read(preferencesProvider);
    try {
      state = AsyncData(
        await ref
            .read(userPreferenceRepositoryProvider)
            .getUserActivity(preferences.idUserPreferences.load()!),
      );
    } catch (e) {
      return;
    }
  }

  Future<void> postUserAction({
    required int idUser,
    required int value,
    required String action,
  }) async {
    try {
      await ref.read(userPreferenceRepositoryProvider).postUserAction(
            userId: idUser,
            value: value,
            actionType: action,
          );
      await updateAction();
    } catch (e) {
      return;
    }
  }
}

@RoutePage()
class ProfilView extends ConsumerWidget {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Preferences preferences = ref.watch(preferencesProvider);
    final router = ref.watch(appRouterProvider);
    final userActionAsync = ref.watch(userActionStatProvider);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${preferences.firstNamePreferences.load() ?? ""} ${preferences.lastNamePreferences.load() ?? ""}",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 126.0,
                          height: 126.0,
                          child: Image.asset(
                            'assets/images/default_avatar.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            print('Icône cliquée');
                          },
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Followers: 0",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Followed: 0",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Mail: ${preferences.emailPreferences.load() ?? ""}",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Password: ***",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              CineFouineHugeBoutton(
                onPressed: () {
                  router.replaceAll([const GenresSelectionRoute()]);
                },
                text: "choose favorite genre",
              ),
              const SizedBox(height: 16),
              Text(
                "Mes badges",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              userActionAsync.when(
                data: (userAction) {
                  if (userAction == null) {
                    return Text(
                      "Aucune action enregistrée.",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nombre de connexions : ${userAction.loginCount}",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "Score au quiz : ${userAction.quizScore}",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "Films regardés ce mois-ci : ${userAction.moviesWatchedInMonth}",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "Événements assistés : ${userAction.eventsAttended}",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "Jours actifs : ${userAction.daysActive}",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "Critiques écrites : ${userAction.reviewsWritten}",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "Genres uniques regardés : ${userAction.uniqueGenresWatched}",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  );
                },
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
                error: (err, stack) => Text(
                  "Erreur lors du chargement des actions utilisateur : $err",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Mes films",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Film regardé: 42",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              Text(
                "Heures regardé: 6969 heures",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              _buildSection("Favoris",
                  ["Harry Potter", "Stars wars", "Le seigneur des anneaux"]),
              const SizedBox(height: 16),
              _buildSection("Ma liste",
                  ["Le hobbit", "Les tuchs", "Pirates des caraibes"]),
              SizedBox(height: 24),
              CineFouineHugeBoutton(
                onPressed: () {
                  preferences.idUserPreferences.save(null);
                  preferences.firstNamePreferences.save(null);
                  preferences.lastNamePreferences.save(null);
                  preferences.emailPreferences.save(null);
                  preferences.userNamePreferences.save(null);

                  router.replaceAll([const LoginRoute()]);
                },
                text: "Logout",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<String> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: items
              .map((item) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
