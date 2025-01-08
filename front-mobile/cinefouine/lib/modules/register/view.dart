import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefouine/core/widgets/cinefouineInputField.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/router/app_router.dart';


@RoutePage()
class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var router = ref.watch(appRouterProvider);

    // Contrôleurs pour chaque champ
    final TextEditingController nicknameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF16213E), // Couleur de fond
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              CineFouineInputField(
                controller: nicknameController,
                hintText: "Nickname",
              ),
              const SizedBox(height: 16),
              CineFouineInputField(
                controller: phoneController,
                hintText: "Phone",
              ),
              const SizedBox(height: 16),
              CineFouineInputField(
                controller: emailController,
                hintText: "Email",
              ),
              const SizedBox(height: 16),
              CineFouineInputField(
                controller: passwordController,
                hintText: "Password",
                isPassword: true,
              ),
              const SizedBox(height: 16),
              CineFouineInputField(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                isPassword: true,
              ),
              const SizedBox(height: 32),
              CineFouineHugeBoutton(
                onPressed: () {
                  // TODO: Ajouter la logique pour la validation et l'enregistrement
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Sign Up Successful!")),
                  );
                },
                text: "Sign Up",
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () => router.push(LoginRoute()),
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
