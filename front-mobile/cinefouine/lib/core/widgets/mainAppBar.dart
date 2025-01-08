// main_app_bar.dart
import 'package:cinefouine/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'movie_service.dart';

part 'main_app_bar.g.dart';

@Riverpod(keepAlive: false)
class IsSearchModeActive extends _$IsSearchModeActive {
  @override
  bool build() => false;

  void toggle() {
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
    final isSearchModeActive = ref.watch(isSearchModeActiveProvider);
    return AppBar(
      title: isSearchModeActive
          ? SearchField()
          : Text(
              title,
              style: titleTextStyle ??
                  const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
            ),
      actions: [
        ...?actions,
        if (showSearchButton)
          _buildSearchButton(ref.read(isSearchModeActiveProvider.notifier).toggle),
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
    return const SizedBox(
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

class SearchField extends ConsumerStatefulWidget {
  const SearchField({super.key});

  @override
  ConsumerState<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<String>> _suggestions;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _controller.text;
    if (query.isNotEmpty) {
      setState(() {
        _suggestions = ref.read(movieServiceProvider).getMovieSuggestions(query);
      });
    } else {
      setState(() {
        _suggestions = Future.value([]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: "Recherche ...",
            labelStyle: TextStyle(color: Colors.grey),
          ),
        ),
        FutureBuilder<List<String>>(
          future: _suggestions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erreur: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final suggestions = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(suggestions[index]),
                    onTap: () {
                      // Gérer la sélection d'une suggestion
                    },
                  );
                },
              );
            } else {
              return const Text('Aucune suggestion');
            }
          },
        ),
      ],
    );
  }
}
