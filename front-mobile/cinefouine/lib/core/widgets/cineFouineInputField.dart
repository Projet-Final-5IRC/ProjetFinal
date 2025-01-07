import 'package:flutter/material.dart';

class CineFouineInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;

  const CineFouineInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF7D7D7D), // Couleur de fond (grise)
        borderRadius: BorderRadius.circular(8), // Bords arrondis
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white, // Texte en blanc
          ),
          border: InputBorder.none, // Pas de bordure
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16, // Espacement interne
          ),
        ),
        style: const TextStyle(
          color: Colors.white, // Texte saisi en blanc
        ),
      ),
    );
  }
}
