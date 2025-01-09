import 'dart:async';

import 'package:cinefouine/data/repositories/movie_repository.dart';
import 'package:cinefouine/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mainAppBar.g.dart';

@Riverpod(keepAlive: false)
class IsSearchModeActif extends _$IsSearchModeActif {
  @override
  bool build() => false;

  void switchValue() {
    state = !state;
  }
}

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool isBackNavigationAvailable;
  final VoidCallback? onBackButtonPressed;
  final bool showBurgerMenu;
  final bool showAvatar;
  final bool showSearchButton;
  final String? avatarUrl;
  final VoidCallback? onAvatarPressed;
  final Color backgroundColor;
  final TextStyle? titleTextStyle;
  final PreferredSizeWidget? bottom;

  const MainAppBar({
    super.key,
    required this.title,
    this.actions,
    this.isBackNavigationAvailable = false,
    this.onBackButtonPressed,
    this.showBurgerMenu = false,
    this.showAvatar = false,
    this.showSearchButton = false,
    this.avatarUrl,
    this.onAvatarPressed,
    this.backgroundColor = AppColors.secondary2,
    this.titleTextStyle,
    this.bottom,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearchModeActif = ref.watch(isSearchModeActifProvider);
    final movieRepository = ref.watch(movieRepositoryProvider);
    final suggestionsStream = StreamController<List<String>>.broadcast();

    void onSearchTextChanged(String query) async {
      if (query.isEmpty) {
        suggestionsStream.add([]);
        debugPrint("APP-DEBUG: Query vide, suggestions réinitialisées.");
        return;
      }
      try {
        debugPrint("APP-DEBUG: Recherche de suggestions pour : $query");
        final suggestions = await movieRepository.getMovieSuggestions(query);
debugPrint("APP-DEBUG: Suggestions reçues : $suggestions");
        suggestionsStream.add(suggestions);
      } catch (e) {
        debugPrint("APP-DEBUG: Erreur lors de la recherche des suggestions : $e");
      }
    }

    return AppBar(
      title: Column(
              children: [
                TextField(
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Recherche ...",
                    labelStyle: const TextStyle(color: Colors.grey),
                  ),
                  onChanged: onSearchTextChanged,
                ),
                StreamBuilder<List<String>>(
                  stream: suggestionsStream.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final suggestion = snapshot.data![index];
                        return ListTile(
                          title: Text(
                            suggestion,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            // Logique pour gérer la sélection
                            // Exemple : Naviguer vers la page de détails du film
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            )
  /*        : Text(
              title,
              style: titleTextStyle ??
                  const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
            )*/,
      actions: [
        ...?actions,
        if (showSearchButton)
          _buildSearchButton(
              ref.read(isSearchModeActifProvider.notifier).switchValue),
        if (showAvatar) _buildAvatar(),
      ],
      leading: _buildLeading(context),
      backgroundColor: backgroundColor,
      bottom: bottom,
    );
  }

  Widget _buildSearchButton(final VoidCallback? onIconPressed) {
    return IconButton(
      icon: const Icon(
        Icons.search,
        color: Colors.white,
        size: 36,
      ),
      onPressed: onIconPressed,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (isBackNavigationAvailable) {
      return IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.white,
        ),
        onPressed: onBackButtonPressed,
      );
    } else if (showBurgerMenu) {
      return IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      );
    }
    return SizedBox(
      width: 24.0,
      height: 24.0,
    );
  }

  Widget _buildAvatar() {
    return GestureDetector(
      onTap: onAvatarPressed,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
          child: avatarUrl == null
              ? const Icon(
                  Icons.person,
                  size: 24,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
