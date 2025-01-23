import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/data/repositories/auth_repository.dart';
import 'package:cinefouine/modules/register/model/register_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefouine/core/widgets/cinefouineInputField.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class RegisterForm extends _$RegisterForm {
  @override
  RegisterStatus build() {
    return RegisterStatus();
  }

  void setUserName(String userName) {
    state = state.copyWith(
      userName: userName,
    );
  }

  void setFirstName(String firstName) {
    state = state.copyWith(
      firstName: firstName,
    );
  }

  void setLastName(String lastName) {
    state = state.copyWith(
      lastName: lastName,
    );
  }

  void setEmail(String email) {
    state = state.copyWith(
      email: email,
    );
  }

  void setPassword(String password) {
    state = state.copyWith(
      password: password,
    );
  }

  void setRewritePassword(String rewritePassword) {
    state = state.copyWith(
      rewritePassword: rewritePassword,
    );
  }

  void setDateCreation(String dateCreation) {
    state = state.copyWith(
      dateCreation: dateCreation,
    );
  }

  void setIsErrorApi(bool isError) {
    state = state.copyWith(
      isErrorApi: isError,
    );
  }

  void setIsErrorPasword(bool isError) {
    state = state.copyWith(
      isErrorPassword: isError,
    );
  }

  void setIsErrorEmpty(bool isError) {
    state = state.copyWith(
      isErrorEmpty: isError,
    );
  }

  void setIsErrorRewritePassword(bool isError) {
    state = state.copyWith(
      isErrorRewritePassword: isError,
    );
  }

  bool fieldIsNotEmpty() {
    if (state.firstName.isEmpty ||
        state.lastName.isEmpty ||
        state.email.isEmpty ||
        state.password.isEmpty ||
        state.rewritePassword.isEmpty) {
      setIsErrorEmpty(true);
      return false;
    } else {
      setIsErrorEmpty(false);
      return true;
    }
  }

  bool isPasswordValid(String password) {
    // Vérifier la longueur minimale
    if (password.length < 8) {
      return false;
    }

    // Vérifier au moins une lettre majuscule
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    // Vérifier au moins un chiffre
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    // Vérifier au moins un caractère spécial
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    return true; // Tous les critères sont respectés
  }

  bool fieldIsValid() {
    if (fieldIsNotEmpty()) {
      // Vérifier si les mots de passe ne correspondent pas
      if (state.password != state.rewritePassword) {
        setIsErrorRewritePassword(true);
        return false;
      } else {
        setIsErrorRewritePassword(false);
      }

      if (!isPasswordValid(state.password)) {
        setIsErrorPasword(true);
        return false;
      } else {
        setIsErrorPasword(false);
      }

      return true;
    }
    return false; // Un ou plusieurs champs sont vides
  }
}

@Riverpod(keepAlive: false)
class _RegisterButton extends _$RegisterButton {
  @override
  FutureOr<bool> build() async {
    return false;
  }

  Future<bool> register() async {
    if (!ref.read(registerFormProvider.notifier).fieldIsValid()) return false;
    state = AsyncLoading();
    // Récupération du service AuthService via le provider
    final authService = ref.read(authRepositoryProvider);
    final registerForm = ref.read(registerFormProvider);

    try {
      // Appel de la méthode register avec les paramètres nécessaires
      final userInfo = await authService.register(
        userName: registerForm.firstName,
        firstName: registerForm.firstName,
        lastName: registerForm.lastName,
        email: registerForm.email,
        password: registerForm.password,
      );

      if (userInfo != null) {
        state = AsyncValue.data(true);
        ref.read(registerFormProvider.notifier).setIsErrorApi(false);
        return true;
      }
      state = AsyncValue.data(false);
      return false;
    } catch (e, _) {
      print('Erreur lors de l\'enregistrement : $e');
      ref.read(registerFormProvider.notifier).setIsErrorApi(true);
      state = AsyncValue.error(e, _);
      return false;
    }
  }
}

@RoutePage()
class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final registerStatus = ref.watch(registerFormProvider);
    bool isLoading = false;
    ref.watch(_registerButtonProvider).when(
      data: (isRegistered) {
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
      backgroundColor: const Color(0xFF16213E),
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
                controller: _firstNameController,
                onChanged: (value) {
                  ref.read(registerFormProvider.notifier).setFirstName(value);
                },
                hintText: "First name",
              ),
              const SizedBox(height: 16),
              CineFouineInputField(
                controller: _lastNameController,
                onChanged: (value) {
                  ref.read(registerFormProvider.notifier).setLastName(value);
                },
                hintText: "Last name",
              ),
              const SizedBox(height: 16),
              CineFouineInputField(
                controller: _emailController,
                onChanged: (value) {
                  ref.read(registerFormProvider.notifier).setEmail(value);
                },
                hintText: "Email",
              ),
              const SizedBox(height: 16),
              CineFouineInputField(
                controller: _passwordController,
                onChanged: (value) {
                  ref.read(registerFormProvider.notifier).setPassword(value);
                },
                hintText: "Password",
                isPassword: true,
              ),
              if (registerStatus.isErrorPassword)
                const Text(
                  "Le mot de passe doit contenir au moins 8 caractères avec 1 lettre en majuscule, 1 chiffre et 1 caractère spécial",
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              CineFouineInputField(
                controller: _confirmPasswordController,
                onChanged: (value) {
                  ref
                      .read(registerFormProvider.notifier)
                      .setRewritePassword(value);
                },
                hintText: "Confirm Password",
                isPassword: true,
              ),
              if (registerStatus.isErrorRewritePassword)
                const Text(
                  "Les mots de passe ne correspondent pas",
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 32),
              if (registerStatus.isErrorApi)
                const Text(
                  "Erreur dans la création de compte, essayer un autre email",
                  style: TextStyle(color: Colors.red),
                ),
              if (registerStatus.isErrorEmpty)
                const Text(
                  "Tout les champs sont obligatoire",
                  style: TextStyle(color: Colors.red),
                ),
              CineFouineHugeBoutton(
                isLoading: isLoading,
                onPressed: () async {
                  bool isRegistered = await ref
                      .read(_registerButtonProvider.notifier)
                      .register();
                  if (isRegistered) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sign Up Successful!")),
                    );
                    router.replaceAll([const GenresSelectionRoute()]);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Erreur register")),
                    );
                  }
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
