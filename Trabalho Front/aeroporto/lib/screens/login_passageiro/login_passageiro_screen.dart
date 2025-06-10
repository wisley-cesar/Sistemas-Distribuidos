import 'package:aeroporto/screens/login_funcionario/widgets/button_login.dart';
import 'package:aeroporto/screens/login_funcionario/widgets/login_background.dart';
import 'package:aeroporto/screens/login_passageiro/controllers/login_passageiro_controller.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:aeroporto/widgets/my_icon.dart';
import 'package:aeroporto/widgets/my_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPassageiroScreen extends StatelessWidget {
  LoginPassageiroScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginController = Get.put(LoginPassageiroController());

  Future<void> _handleLogin() async {
    print('Login button pressed');
    if (_formKey.currentState!.validate()) {
      print('Form is valid, proceeding with login');
      await _loginController.login(
        _emailController.text,
        _passwordController.text,
      );
    } else {
      print('Form validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
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
                  Text(
                    'Login do Passageiro',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Acesse sua conta de passageiro',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu email';
                      }
                      if (!value.contains('@')) {
                        return 'Por favor, insira um email válido';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Obx(() => ButtonLogin(
                        title: _loginController.isLoading.value
                            ? 'Entrando...'
                            : 'Entrar',
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.blue.shade900,
                        onPressed: _loginController.isLoading.value
                            ? null
                            : _handleLogin,
                      )),
                  const SizedBox(height: 15),
                  ButtonLogin(
                    title: 'Voltar',
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade700,
                    shadowColor: Colors.blue.shade700,
                    isOutlined: true,
                    onPressed: () {
                      Get.back();
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
