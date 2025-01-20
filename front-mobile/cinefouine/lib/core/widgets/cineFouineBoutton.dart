
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Cinefouineboutton extends ConsumerWidget {
  final bool isClicked;
  final String text;
  final String text2;
  final VoidCallback onPressed;

  const Cinefouineboutton({
    super.key,
    this.isClicked = false,
    required this.onPressed,
    required this.text,
    this.text2 = "",
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isClicked ? Colors.grey : const Color(0xFF0099CC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        minimumSize: const Size(100, 32),
      ),
      child: Text(
        isClicked ? text2 : text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}