import 'package:flutter/material.dart';

class CineFouineInputField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final ValueChanged<String> onChanged;

  const CineFouineInputField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.isPassword = false,
    TextEditingController? controller
  }) : _controller = controller;

  final TextEditingController? _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8), // Espacement vertical
      decoration: BoxDecoration(
        color: const Color(0xFF7D7D7D), // Couleur de fond (grise)
        borderRadius: BorderRadius.circular(8), // Bords arrondis
      ),
      child: TextField(
        controller: _controller,
        obscureText: isPassword,
        cursorColor: Colors.white, // Couleur du curseur
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white70, // Texte indicatif légèrement transparent
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(8), // Même rayon que le conteneur
            borderSide: BorderSide.none, // Pas de bordure par défaut
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Bords arrondis
            borderSide: const BorderSide(
              color: Colors.white, // Bordure blanche au focus
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16, // Espacement interne
          ),
        ),
        style: const TextStyle(
          color: Colors.white, // Texte saisi en blanc
        ),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}
