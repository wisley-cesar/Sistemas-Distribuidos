import 'package:aeroporto/screens/login_funcionario/widgets/button_login.dart';
import 'package:aeroporto/screens/login_funcionario/widgets/login_background.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:aeroporto/widgets/my_icon.dart';
import 'package:aeroporto/widgets/my_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPassageiroScreen extends StatelessWidget {
  RegisterPassageiroScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MyIcon(
                    size: 70,
                    color: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Cadastro de Passageiro',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Crie sua conta de passageiro',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextInput(
                    label: 'Nome Completo',
                    prefixIcon: Icons.person,
                    hintText: 'Digite seu nome completo',
                    textInputAction: TextInputAction.next,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 14),
                  MyTextInput(
                    label: 'Email',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Digite seu email',
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    isEmail: true,
                  ),
                  const SizedBox(height: 14),
                  MyTextInput(
                    label: 'CPF',
                    prefixIcon: Icons.badge,
                    keyboardType: TextInputType.number,
                    hintText: 'Digite seu CPF',
                    textInputAction: TextInputAction.next,
                    controller: _cpfController,
                  ),
                  const SizedBox(height: 14),
                  MyTextInput(
                    label: 'Senha',
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    hintText: 'Digite sua senha',
                    textInputAction: TextInputAction.next,
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 14),
                  MyTextInput(
                    label: 'Confirmar Senha',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    hintText: 'Confirme sua senha',
                    textInputAction: TextInputAction.done,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ButtonLogin(
                    title: 'Cadastrar',
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.blue.shade900,
                    onPressed: () {
                      // Implementação futura
                    },
                  ),
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
