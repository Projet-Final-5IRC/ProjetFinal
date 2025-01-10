import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/core/widgets/cinefouineInputField.dart';
import 'package:cinefouine/data/repositories/auth_repository.dart';
import 'package:cinefouine/modules/login/model/login_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class LoginForm extends _$LoginForm {
  @override
  LoginStatus build() {
    return LoginStatus();
  }

  void setMail(String mail) {
    state = state.copyWith(
      mail: mail,
    );
  }

  void setPassword(String password) {
    state = state.copyWith(
      password: password,
    );
  }

  void setIsError(bool isError) {
    state = state.copyWith(
      isError: isError,
    );
  }
}

@Riverpod(keepAlive: false)
class _LoginButton extends _$LoginButton {
  @override
  FutureOr<bool> build() async {
    return false;
  }

  Future<bool> login() async {
    state = AsyncLoading();
    try {
      // Récupération du service AuthService via le provider
      final authService = ref.read(authRepositoryProvider);
      final loginForm = ref.read(loginFormProvider);

      // Appel de la méthode register avec les paramètres nécessaires
      final userInfo = await authService.login(
        email: loginForm.mail,
        password: loginForm.password,
      );

      if (userInfo != null) {
        return true;
      }
      state = AsyncValue.data(false);
      return false;
    } catch (e) {
      print('bouton: Erreur lors du login : $e');
      state = AsyncValue.data(false);
      return false;
    }
  }
}

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
    final router = ref.watch(appRouterProvider);
    final loginForm = ref.watch(loginFormProvider);
    bool isLoading = false;
    ref.watch(_loginButtonProvider).when(
      data: (isAutheticated) {
        isLoading = false;
      },
      error: (error, stackTrace) {
        isLoading = false;
      },
      loading: () {
        isLoading = true;
      },
    );

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
              onChanged: (value) {
                ref.read(loginFormProvider.notifier).setMail(value);
              },
              hintText: "Email or Phone no",
            ),
            const SizedBox(height: 16),
            CineFouineInputField(
              controller: _passwordController,
              hintText: "Password",
              onChanged: (value) {
                ref.read(loginFormProvider.notifier).setPassword(value);
              },
              isPassword: true,
            ),
            const SizedBox(height: 32),
            if (loginForm.isError) //TODO improve
              Text(
                "Mauvais mot de passe/email",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            CineFouineHugeBoutton(
              isLoading: isLoading,
              onPressed: () async {
                final isLoged =
                    await ref.read(_loginButtonProvider.notifier).login();
                if (isLoged) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Sign In Successful!")),
                  );
                  ref.read(loginFormProvider.notifier).setIsError(false);
                  router.replaceAll([const HomeRoute()]);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Wrong login!")),
                  );
                  ref.read(loginFormProvider.notifier).setIsError(true);
                }
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
                      activeColor:
                          const Color(0xFF0099CC), // Couleur du checkbox
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
            const SizedBox(
                height: 24), // Ajout d'un espace avant le texte d'inscription
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
