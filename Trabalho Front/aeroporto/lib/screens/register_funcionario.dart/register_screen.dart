import 'package:aeroporto/screens/login_funcionario/widgets/button_login.dart';
import 'package:aeroporto/screens/register_funcionario.dart/controllers/register_controller.dart';
import 'package:aeroporto/screens/register_funcionario.dart/widgets/user_type_dropdown.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:aeroporto/widgets/my_icon.dart';
import 'package:aeroporto/widgets/my_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../login_funcionario/widgets/login_background.dart';

class RegisterScreen extends StatelessWidget {
  final bool isPassageiro;

  RegisterScreen({super.key, this.isPassageiro = false});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _registerController = Get.put(RegisterController());

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
                    isPassageiro
                        ? 'Cadastro de Passageiro'
                        : 'Cadastro de Funcionário',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(() {
                    if (_registerController.errorMessage.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          _registerController.errorMessage.value,
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
                    label: 'Nome',
                    prefixIcon: Icons.person,
                    hintText: 'Digite seu nome completo',
                    textInputAction: TextInputAction.next,
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O nome é obrigatório';
                      }
                      if (value.length < 3) {
                        return 'O nome deve ter pelo menos 3 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  if (isPassageiro) ...[
                    MyTextInput(
                      label: 'CPF',
                      prefixIcon: Icons.badge,
                      keyboardType: TextInputType.number,
                      hintText: 'Digite seu CPF',
                      textInputAction: TextInputAction.next,
                      controller: _cpfController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o CPF';
                        }
                        if (value.length != 11) {
                          return 'CPF deve conter 11 dígitos';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
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
                        return 'O email é obrigatório';
                      }
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  if (!isPassageiro) ...[
                    const UserTypeDropdown(),
                    const SizedBox(height: 16),
                  ],
                  MyTextInput(
                    label: 'Senha',
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    hintText: 'Digite sua senha',
                    textInputAction: TextInputAction.next,
                    controller: _passwordController,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A senha é obrigatória';
                      }
                      final passwordRegex = RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
                      if (!passwordRegex.hasMatch(value)) {
                        return 'A senha deve ter no mínimo 8 caracteres, uma letra maiúscula, uma minúscula e um número';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  MyTextInput(
                    label: 'Confirmar Senha',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    hintText: 'Confirme sua senha',
                    textInputAction: TextInputAction.done,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirme sua senha';
                      }
                      if (value != _passwordController.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Obx(() => ButtonLogin(
                        title: _registerController.isLoading.value
                            ? 'Cadastrando...'
                            : 'Cadastrar',
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.blue.shade900,
                        onPressed: _registerController.isLoading.value
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  final success =
                                      await _registerController.register(
                                    _nameController.text,
                                    _emailController.text,
                                    _passwordController.text,
                                    _confirmPasswordController.text,
                                  );
                                  if (success) {
                                    Get.offAllNamed(AppRoutes.login);
                                  }
                                }
                              },
                      )),
                  const SizedBox(height: 15),
                  ButtonLogin(
                    title: 'Voltar para Login',
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
