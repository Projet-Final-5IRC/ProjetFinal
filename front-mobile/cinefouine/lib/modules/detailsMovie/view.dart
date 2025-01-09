import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/mainAppBar.dart';
import 'package:cinefouine/data/entities/movie/movie_info.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class MovieSeleted extends _$MovieSeleted {
  @override
  MovieInfo? build() => null;

  void setMovie(MovieInfo value) {

  }
}

@RoutePage()
class DetailsMovieView extends StatelessWidget {
  const DetailsMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "details film"),
      body: Center(
        child: Text("Details Movie"),
      ),
    );
  }
}
