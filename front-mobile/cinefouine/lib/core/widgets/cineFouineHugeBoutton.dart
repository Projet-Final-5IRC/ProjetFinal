import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CineFouineHugeBoutton extends ConsumerWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CineFouineHugeBoutton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        backgroundColor: const Color(0xFF0099CC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: !isLoading
          ? Text(
              text,
              style: const TextStyle(color: Colors.white),
            )
          : CircularProgressIndicator(),
    );
  }
}
