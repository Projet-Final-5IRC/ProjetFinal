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
  final ValueChanged<String>? onSearchTextChanged;

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
    this.onSearchTextChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearchModeActif = ref.watch(isSearchModeActifProvider);

    return AppBar(
      title: Column(
        children: [
          if (isSearchModeActif)
            TextField(
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Recherche ...",
                labelStyle: const TextStyle(color: Colors.grey),
              ),
              onChanged: onSearchTextChanged,
            )
          else
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
        ],
      ),
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
