import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/mainAppBar.dart';
import 'package:cinefouine/data/entities/movie/movie_info.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: true)
class MovieSeleted extends _$MovieSeleted {
  @override
  MovieInfo? build() => null;

  void setMovie(MovieInfo value) {
    state = value;
  }
}

@RoutePage()
class DetailsMovieView extends ConsumerWidget {
  const DetailsMovieView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieSelected = ref.watch(movieSeletedProvider);
    final router = ref.watch(appRouterProvider);

    return Scaffold(
      appBar: MainAppBar(
        title: "details film",
        isBackNavigationAvailable: router.canNavigateBack,
        onBackButtonPressed: () => router.maybePop(),
      ),
      body: Center(
        child: Text(movieSelected.toString()),
      ),
    );
  }
}
