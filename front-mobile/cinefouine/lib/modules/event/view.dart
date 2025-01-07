import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class EventView extends ConsumerWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color(0xFF243040),
      appBar: AppBar(
        title: const Text('Flutter'),
      ),
      body: Center(
        child: Text("Event")
      ),
    );
  }
}