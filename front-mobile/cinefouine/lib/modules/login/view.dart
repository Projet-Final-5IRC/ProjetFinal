import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/core/widgets/cinefouineInputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefouine/router/app_router.dart';

@RoutePage()
class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var router = ref.watch(appRouterProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF16213E), // Couleur de fond sombre
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Sign In",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            CineFouineInputField(
              controller: _emailController,
              hintText: "Email or Phone no",
            ),
            const SizedBox(height: 16),
            CineFouineInputField(
              controller: _passwordController,
              hintText: "Password",
              isPassword: true,
            ),
            const SizedBox(height: 32),
            CineFouineHugeBoutton(
              onPressed: () {
                // TODO: Ajouter la logique pour se connecter
                router.replaceAll([const HomeRoute()]);
              },
              text: "Sign In",
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                      activeColor: const Color(0xFF0099CC), // Couleur du checkbox
                    ),
                    const Text(
                      "Remember me",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const Text(
                  "Need Help?",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24), // Ajout d'un espace avant le texte d'inscription
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "New to cine fouine?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () => router.push(RegisterRoute()),
                  child: const Text(
                    "Sign up now",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(), // Spacer reste en bas pour équilibrer
          ],
        ),
      ),
    );
  }
}
