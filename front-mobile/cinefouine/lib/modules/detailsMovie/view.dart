import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/mainAppBar.dart';
import 'package:flutter/material.dart';

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
