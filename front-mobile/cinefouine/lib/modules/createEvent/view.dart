import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/mainAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CreateEventView extends ConsumerWidget {
  const CreateEventView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color(0xFF243040),
      appBar: MainAppBar(title: "Event"),
      body: SingleChildScrollView(
        child: Center(
          child: Text("Create event"),
        ),
      ),
    );
  }
}
