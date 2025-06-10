import 'package:aeroporto/screens/login_funcionario/controllers/login_funcionario_controller.dart';
import 'package:aeroporto/screens/login_funcionario/widgets/button_login.dart';
import 'package:aeroporto/screens/login_funcionario/widgets/my_text_welcome.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:aeroporto/widgets/my_icon.dart';
import 'package:aeroporto/widgets/my_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/login_background.dart';

class LoginFuncionarioScreen extends StatelessWidget {
  LoginFuncionarioScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginController = Get.put(LoginFuncionarioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MyIcon(
                    size: 80,
                    color: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  const SizedBox(height: 24),
                  const MyTextWelcome(),
                  const SizedBox(height: 32),
                  Obx(() {
                    if (_loginController.errorMessage.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          _loginController.errorMessage.value,
                          style: TextStyle(
                            color: Colors.red.shade400,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  MyTextInput(
                    label: 'Email',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Digite seu email',
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    isEmail: true,
                  ),
                  const SizedBox(height: 16),
                  MyTextInput(
                    label: 'Senha',
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    hintText: 'Digite sua senha',
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),
                  Obx(
                    () => ButtonLogin(
                      title: 'Entrar',
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      shadowColor: Colors.blue.shade900,
                      onPressed: _loginController.isLoading.value
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                final success = await _loginController.login(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                                if (success) {
                                  Get.offAllNamed(AppRoutes.home);
                                }
                              }
                            },
                    ),
                  ),
                  const SizedBox(height: 15),
                  ButtonLogin(
                    title: 'Cadastrar',
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade700,
                    shadowColor: Colors.blue.shade700,
                    isOutlined: true,
                    onPressed: () {
                      Get.toNamed(AppRoutes.registerFuncionario);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
